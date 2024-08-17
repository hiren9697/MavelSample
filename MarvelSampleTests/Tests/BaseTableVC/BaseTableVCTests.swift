//
//  BaseTableVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import XCTest
@testable import MarvelSample

/// Uses TestableAPIDataListable as view model
/// Uses TestableChildTableVC to fill space
/// Tests:
/// 1. UI components: Refresh control, TableView, Loader view
/// 2. Number of sections tableview shows with different states
/// 3. Loader visibility with different states
/// 4. Number and types of cells dequed in different states
/// 5. Next page loader visibility in different states
/// 6. API calls
/// 7. Row selection in different state
/// This test excludes:
/// 1. init?(coder:) as this is not called
/// 2. registerTableViewDataCell() as this must be implemented by subclass and subclass's implementation will be called
/// 3. dequeueCell(at: IndexPath)
/// 4. tableView(_:UITableView, heightForRowAt: IndexPath) as this must be implemented by subclass and subclass's implementation will be called, sub-class test should test this
/// 5. tableView(_:UITableView, didSelectRowAt: IndexPath)
final class BaseTableVCTests: XCTestCase {
    
    var sut: TestableChildTableVC!
    var viewModel: TestableAPIDataListable!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableAPIDataListable()
        sut = TestableChildTableVC(viewModel: viewModel)
        putInViewHeirarchy(sut)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - 1. UI Components
extension BaseTableVCTests {
    
    func test_correctViewModelObject() {
        XCTAssertTrue(sut.viewModel === viewModel, "viewModel object is different")
    }
    
    func test_tableView_delegateDatasourceNotNil() {
        XCTAssertNotNil(sut.tableView.delegate, "Delegate")
        XCTAssertNotNil(sut.tableView.dataSource, "Datasource")
    }
    
    func test_tableView_isInViewHierarchy() {
        XCTAssertEqual(sut.tableView.superview, sut.view)
    }
    
    func test_orderOf_tableViewAndLoader() {
        XCTAssertEqual(sut.view.subviews.first, sut.tableView)
        XCTAssertEqual(sut.view.subviews[1], sut.loaderContainer)
    }
    
    func test_tableView_hasRefreshControl() {
        XCTAssertEqual(sut.refreshControl.superview, sut.tableView)
    }
    
    func test_title() {
        XCTAssertEqual(sut.title, viewModel.navigationTitle)
    }
}

// MARK: - 2. TableView Sections
extension BaseTableVCTests {
    func test_fetchState_initialLoading_shouldShowZeroCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.initialLoading
        let numberOfSections = numberOfSections(in: sut.tableView)
        XCTAssertEqual(numberOfSections, 0)
    }
    
    func test_fetchState_idle_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.idle
        XCTAssertEqual(numberOfSections(in: sut.tableView), 1)
    }
    
    func test_fetchState_emptyData_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.emptyData
        XCTAssertEqual(numberOfSections(in: sut.tableView), 1)
    }
    
    func test_fetchState_error_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.error(NetworkError.invalidURL)
        XCTAssertEqual(numberOfSections(in: sut.tableView), 1)
    }
    
    func test_fetchState_loadingNextPage_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.loadingNextPage
        XCTAssertEqual(numberOfSections(in: sut.tableView), 1)
    }
    
    func test_fetchState_reload_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.reload
        XCTAssertEqual(numberOfSections(in: sut.tableView), 1)
    }
}

// MARK: - 3. Loader
extension BaseTableVCTests {
    func test_fetchState_initialLoading_shouldShowLoader() {
        viewModel.fetchState.value = DataFetchState.initialLoading
        XCTAssertFalse(sut.loaderContainer.isHidden, "Loader is not visible")
        XCTAssertTrue(sut.loader.isAnimating, "Loader is not animating")
    }
    
    func test_fetchState_reloading_shouldNotShowLoader() {
        viewModel.fetchState.value = .reload
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is visible")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating")
    }
    
    func test_fetchState_idle_shouldNotShowLoader() {
        viewModel.fetchState.value = .idle
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is visible")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating")
    }
    
    func test_fetchState_emptyData_shouldNotShowLoader() {
        viewModel.fetchState.value = .emptyData
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is visible")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating")
    }
    
    func test_fetchState_error_shouldNotShowLoader() {
        viewModel.fetchState.value = .error(NetworkError.invalidURL)
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is visible")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating")
    }
    
    func test_fetchState_loadingNextPage_shouldNotShowLoader() {
        viewModel.fetchState.value = .loadingNextPage
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is visible")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating")
    }
    
    func test_fetchState_updateFromIdleToInitialLoadingAndAgainInIdel_shouldShowHideLoaderAccordingly() {
        viewModel.fetchState.value = .idle
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is not hidden in idle state")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating in idle state")
        viewModel.fetchState.value = .initialLoading
        XCTAssertFalse(sut.loaderContainer.isHidden, "Loader is not shown in initialLoading state")
        XCTAssertTrue(sut.loader.isAnimating, "Loader is not animating in initialLoading state")
        viewModel.fetchState.value = .idle
        XCTAssertTrue(sut.loaderContainer.isHidden, "Loader is not hidden idle state")
        XCTAssertFalse(sut.loader.isAnimating, "Loader is animating in idle state")
    }
}

// MARK: - 4. Number and type of cell
extension BaseTableVCTests {
    func test_fetchState_initialLoading_shouldShowZeroItemsInSection() {
        viewModel.fetchState.value = DataFetchState.initialLoading
        XCTAssertEqual(numberOfRows(in: sut.tableView), 0)
    }
    
    func test_fetchState_idle_shouldShowItemsInSectionSameAsDataInViewModel() {
        viewModel.fetchState.value = DataFetchState.idle
        viewModel.listItems.value = [TestableDataItemVM(text: "0")]
        XCTAssertEqual(numberOfRows(in: sut.tableView),
                       viewModel.listItems.value.count)
        viewModel.listItems.value.append(TestableDataItemVM(text: "1"))
        XCTAssertEqual(numberOfRows(in: sut.tableView),
                       viewModel.listItems.value.count)
        let array = Array(repeating: TestableDataItemVM(text: "2"), count: 20)
        viewModel.listItems.value.append(contentsOf: array)
        XCTAssertEqual(numberOfRows(in: sut.tableView),
                       viewModel.listItems.value.count)
        
    }
    
    func test_fetchState_idle_shouldDequeCorrectCollectionViewCell() {
        addListItemsWithIdleModeInViewModel()
        let cell = cellForRow(in: sut.tableView, row: 0)
        XCTAssertTrue(cell is TestableTableCell,
                      "cell is not TestableTableCell")
    }
    
    func test_fetchState_emptyData_shouldDequeueCorrectCollectionViewCell() {
        viewModel.fetchState.value = .emptyData
        let cell = cellForRow(in: sut.tableView, row: 0)
        XCTAssertTrue(cell is EmptyTC,
                      "cell is not EmptyTC")
    }
    
    func test_fetchState_error_shouldDequeueCorrectCollectionViewCell() {
        viewModel.fetchState.value = .error(NetworkError.invalidURL)
        let cell = cellForRow(in: sut.tableView, row: 0)
        XCTAssertTrue(cell is ErrorTC,
                      "cell is not ErrorTC")
    }
}

// MARK: - 5. Next page loader
extension BaseTableVCTests {
    func test_fetchState_initialLoading_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .initialLoading
        checkTableViewHasNilFooter(line: #line)
    }
    
    func test_fetchState_idle_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .idle
        checkTableViewHasNilFooter(line: #line)
    }
    
    func test_fetchState_emptyData_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .emptyData
        checkTableViewHasNilFooter(line: #line)
    }
    
    func test_fetchState_error_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .error(NetworkError.invalidURL)
        checkTableViewHasNilFooter(line: #line)
    }
    
    func test_fetchState_reloading_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .reload
        checkTableViewHasNilFooter(line: #line)
    }
    
    func test_fetchState_loadingNext_shouldShowNextPageLoader() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .loadingNextPage
        sut.tableView.reloadData()
        let footerHeight = footerViewHeight(in: sut.tableView)
        XCTAssertNotEqual(footerHeight, .zero, "Height is zero")
        let footer = footer(in: sut.tableView)
        XCTAssertTrue(footer is TableViewNextPageLoader)
    }
}

// MARK: - 6. API calls
extension BaseTableVCTests {
    func test_viewDidLoad_makesAPICallToFetchInitialDataInViewModel() {
        // Arrange
        /// 1. Reinitialize sut and viewModel
        sut = nil
        viewModel = nil
        viewModel = TestableAPIDataListable()
        /// 2. Configure closure
        var number = 0
        viewModel.fetchInitialDataHandler = {
            number += 1
        }
        // Act
        sut = TestableChildTableVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
        // Assert
        XCTAssertEqual(number, 1)
    }
    
    func test_refreshController_makesAPICallToRefreshInViewModel() {
        var number = 0
        viewModel.refreshHandler = {
            number += 1
        }
        triggerRefresh(sut.refreshControl)
        XCTAssertEqual(number, 1)
    }
}

// MARK: - 7. DidSelectItem
extension BaseTableVCTests {
    func test_didSelectItem_withIdleState_shouldPassMethodCall() {
        addListItemsWithIdleModeInViewModel()
        // No need to set fetchState to .idld, addListItemsWithIdleModeInViewModel() method did that
        checkSUTIsPassingItemSelectionMethodCall()
    }
    
    func test_didSelectItem_withReloadingState_shouldPassMethodCall() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .reload
        checkSUTIsPassingItemSelectionMethodCall()
    }
    
    func test_didSelectItem_withLoadingNextPageState_shouldPassMethodCall() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .reload
        checkSUTIsPassingItemSelectionMethodCall()
    }
    
    func test_didSelectItem_withEmptyDataState_shouldNotPassMethodCall() {
        viewModel.fetchState.value = .emptyData
        checkSUTIsNotPassingItemSelectionMethodCall()
    }
    
    func test_didSelectItem_withErrorState_shouldNotPassMethodCall() {
        viewModel.fetchState.value = .error(DummyNetworkError.somethingWentWrong)
        checkSUTIsNotPassingItemSelectionMethodCall()
    }
    
    // No need to test ItemSelectionMethodPassing behaviour in initialLoading state, because in that state there will be no item to select
}

// MARK: - Helper
extension BaseTableVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            TestableDataItemVM(text: "0"),
            TestableDataItemVM(text: "1"),
            TestableDataItemVM(text: "2"),
            TestableDataItemVM(text: "3"),
            TestableDataItemVM(text: "4")
        ]
    }
    
    private func checkTableViewHasNilFooter(line: UInt) {
        let footerHeight = footerViewHeight(in: sut.tableView)
        XCTAssertEqual(footerHeight, .zero, "Height is not zero", line: line)
        let footer = footer(in: sut.tableView)
        XCTAssertNil(footer, "Footer is non-nil", line: line)
    }
    
    private func checkSUTIsPassingItemSelectionMethodCall() {
        // Arrange
        var number: Int = 0
        sut.itemSelectionHandler = {
            number += 1
        }
        // Act
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(number, 1)
    }
    
    private func checkSUTIsNotPassingItemSelectionMethodCall() {
        // Arrange
        var number: Int = 0
        sut.itemSelectionHandler = {
            number += 1
        }
        // Act
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(number, 0)
    }
}
