//
//  BaseCollectionVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import XCTest
@testable import MarvelSample

/// Uses TestableAPIDataListable as view model, Need to change properties of view model manually to perform changes
/// Uses TestableChildCollectionVC to fill space
/// Tests:
/// 1. UI components: Refresh control, CollectionView, Loader view
/// 2. Number of sections collectionView shows with different states
/// 3. Loader visibility with different states
/// 4. Number and types of cells dequed in different states
/// 5. Next page loader visibility in different states
final class BaseCollectionVCTests: XCTestCase {
    
    var sut: TestableChildCollectionVC!
    var viewModel: TestableAPIDataListable!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableAPIDataListable()
        sut = TestableChildCollectionVC(viewModel: viewModel)
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
extension BaseCollectionVCTests {
    
    func test_correctViewModelObject() {
        XCTAssertTrue(sut.viewModel === viewModel, "viewModel object is different")
    }
    
    func test_collectionView_delegateDatasourceNotNil() {
        XCTAssertNotNil(sut.collectionView.delegate, "Delegate")
        XCTAssertNotNil(sut.collectionView.dataSource, "Datasource")
    }
    
    func test_collectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.collectionView.superview, sut.view)
    }
    
    func test_orderOf_collectionViewAndLoader() {
        XCTAssertEqual(sut.view.subviews.first, sut.collectionView)
        XCTAssertEqual(sut.view.subviews[1], sut.loaderContainer)
    }
    
    func test_collectionView_hasRefreshControl() {
        XCTAssertEqual(sut.refreshControl.superview, sut.collectionView)
    }
    
    func test_refreshController_hasTarget() {
        var number = 0
        sut.refreshHandler = {
            number += 1
        }
        triggerRefresh(sut.refreshControl)
        XCTAssertEqual(number, 1)
    }
}

// MARK: - 2. CollectionView Sections
extension BaseCollectionVCTests {
    func test_fetchState_initialLoading_shouldShowZeroCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.initialLoading
        let numberOfSections = numberOfSections(in: sut.collectionView)
        XCTAssertEqual(numberOfSections, 0)
    }
    
    func test_fetchState_idle_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.idle
        XCTAssertEqual(numberOfSections(in: sut.collectionView), 1)
    }
    
    func test_fetchState_emptyData_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.emptyData
        XCTAssertEqual(numberOfSections(in: sut.collectionView), 1)
    }
    
    func test_fetchState_error_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.error(NetworkError.invalidURL)
        XCTAssertEqual(numberOfSections(in: sut.collectionView), 1)
    }
    
    func test_fetchState_loadingNextPage_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.loadingNextPage
        XCTAssertEqual(numberOfSections(in: sut.collectionView), 1)
    }
    
    func test_fetchState_reload_shouldShowOneCollectionViewSections() {
        viewModel.fetchState.value = DataFetchState.reload
        XCTAssertEqual(numberOfSections(in: sut.collectionView), 1)
    }
}

// MARK: - 3. Loader
extension BaseCollectionVCTests {
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
extension BaseCollectionVCTests {
    func test_fetchState_initialLoading_shouldShowZeroItemsInSection() {
        viewModel.fetchState.value = DataFetchState.initialLoading
        XCTAssertEqual(numberOfRows(in: sut.collectionView), 0)
    }
    
    func test_fetchState_idle_shouldShowItemsInSectionSameAsDataInViewModel() {
        viewModel.fetchState.value = DataFetchState.idle
        viewModel.listItems.value = [TestableDataItemVM(text: "0")]
        XCTAssertEqual(numberOfRows(in: sut.collectionView),
                       viewModel.listItems.value.count)
        viewModel.listItems.value.append(TestableDataItemVM(text: "1"))
        XCTAssertEqual(numberOfRows(in: sut.collectionView),
                       viewModel.listItems.value.count)
        let array = Array(repeating: TestableDataItemVM(text: "2"), count: 20)
        viewModel.listItems.value.append(contentsOf: array)
        XCTAssertEqual(numberOfRows(in: sut.collectionView),
                       viewModel.listItems.value.count)
        
    }
    
    func test_fetchState_idle_shouldDequeCorrectCollectionViewCell() {
        addListItemsWithIdleModeInViewModel()
        let cell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertTrue(cell is TestableCollectionCell,
                      "cell is not TestableCollectionCell")
    }
    
    func test_fetchState_emptyData_shouldDequeueCorrectCollectionViewCell() {
        viewModel.fetchState.value = .emptyData
        let cell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertTrue(cell is EmptyCC,
                      "cell is not EmptyCC")
    }
    
    func test_fetchState_error_shouldDequeueCorrectCollectionViewCell() {
        viewModel.fetchState.value = .error(NetworkError.invalidURL)
        let cell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertTrue(cell is ErrorCC,
                      "cell is not ErrorCC")
    }
}

// MARK: - 5. Next page loader
extension BaseCollectionVCTests {
    func test_fetchState_initialLoading_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .initialLoading
        let footerReferenceSize = referenceSizeForFooterView(in: sut.collectionView)
        XCTAssertEqual(footerReferenceSize, .zero)
    }
    
    func test_fetchState_idle_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .idle
        let footerReferenceSize = referenceSizeForFooterView(in: sut.collectionView)
        XCTAssertEqual(footerReferenceSize, .zero)
    }
    
    func test_fetchState_emptyData_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .emptyData
        let footerReferenceSize = referenceSizeForFooterView(in: sut.collectionView)
        XCTAssertEqual(footerReferenceSize, .zero)
    }
    
    func test_fetchState_error_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .error(NetworkError.invalidURL)
        let footerReferenceSize = referenceSizeForFooterView(in: sut.collectionView)
        XCTAssertEqual(footerReferenceSize, .zero)
    }
    
    func test_fetchState_reloading_shouldNotShowNextPageLoader() {
        viewModel.fetchState.value = .reload
        let footerReferenceSize = referenceSizeForFooterView(in: sut.collectionView)
        XCTAssertEqual(footerReferenceSize, .zero)
    }
    
    func test_fetchState_loadingNext_shouldShowNextPageLoader() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .loadingNextPage
        sut.collectionView.reloadData()
        let footerReferenceSize = referenceSizeForFooterView(in: sut.collectionView)
        XCTAssertNotEqual(footerReferenceSize, .zero)
    }
}

// MARK: - Helper
extension BaseCollectionVCTests {
    
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
}
