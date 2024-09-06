//
//  ComicsVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 21/07/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Dequeues cell
/// 2. Item selection
/// Excludes:
/// 1. Flow layout functionality, because it should be tested in snapshot tests
/// NOTE: use 'executeRunLoop()' before asserting navigation
final class ComicsVCTests: XCTestCase {
    var navigationController: UINavigationController!
    var sut: TestableComicsVC!
    var viewModel: TestableComicsVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableComicsVM()
        sut = TestableComicsVC(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        navigationController = nil
        super.tearDown()
    }
}

// MARK: - Dequeues cell
extension ComicsVCTests {
    func test_cellForRow_withFilledData_dequesCorrectTypeOfCell() {
        addListItemsWithIdleModeInViewModel()
        let zerothCell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertTrue(zerothCell is ThumbnailTitleCC<ComicItemVM>, "zerothCell is not ThumbnailTitleCC<ComicItemVM>")
        let firstCell = cellForRow(in: sut.collectionView, row: 1)
        XCTAssertTrue(firstCell is ThumbnailTitleCC<ComicItemVM>, "firstCell is not ThumbnailTitleCC<ComicItemVM>")
        let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.count - 1)
        XCTAssertTrue(lastCell is ThumbnailTitleCC<ComicItemVM>, "lastCell is not ThumbnailTitleCC<ComicItemVM>")
    }
    
    func test_cellForRow_withFilledData_updatesUIIfCell() {
        addListItemsWithIdleModeInViewModel()
        guard let zerothCell = cellForRow(in: sut.collectionView, row: 0) as? ThumbnailTitleCC<ComicItemVM> else {
            XCTFail("Dequed zeroth cell is not ThumbnailTitleCC<ComicItemVM>")
            return
        }
        XCTAssertEqual(zerothCell.titleLabel.text,
                       "Zeroth comic title")
        guard let firstCell = cellForRow(in: sut.collectionView, row: 1) as? ThumbnailTitleCC<ComicItemVM> else {
            XCTFail("Dequed first cell is not ThumbnailTitleCC<ComicItemVM>")
            return
        }
        XCTAssertEqual(firstCell.titleLabel.text,
                       "First comic title")
        guard let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.lastIndex) as? ThumbnailTitleCC<ComicItemVM> else {
            XCTFail("Dequed last cell is not ThumbnailTitleCC<ComicItemVM>")
            return
        }
        XCTAssertEqual(lastCell.titleLabel.text,
                       "Third comic title")
    }
}

// MARK: - Item selection
extension ComicsVCTests {
    func test_itemSelection_withIdleState_navigatesToComicDetail() {
        // Arrange
        addListItemsWithIdleModeInViewModel()
        // Act
        checkFirstVCInNavigationStackIsComicsVC()
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        executeRunLoop()
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 2, "After selecting item, There should be 2 viewControllers in navigation stack")
        XCTAssertTrue(navigationController.viewControllers.first is ComicsVC, "First VC in navigation stack should be ComicsVC")
        XCTAssertTrue(navigationController.viewControllers[1] is ComicDetailVC, "Second VC in navigation stack should be ComicDetailVC")
    }
    
    func test_afterItemSelection_addedComicDetail_shouldHaveCorrectViewModel() {
        // Arrange
        addListItemsWithIdleModeInViewModel()
        // Act
        checkFirstVCInNavigationStackIsComicsVC()
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        executeRunLoop()
        // Assert
        guard let comicDetailVC = navigationController.viewControllers.last as? ComicDetailVC else {
            XCTFail("last view controller in navigation controller is not ComicDetailVC")
            return
        }
        let comicDetailVM = comicDetailVC.viewModel
        let comic = viewModel.data.first!
        XCTAssertEqual(comicDetailVM.title, comic.title, "Comic title is incorrect")
        XCTAssertEqual(comicDetailVM.description, comic.descriptionText, "Comic description is incorrect")
        XCTAssertEqual(comicDetailVM.thumbnailURL, comic.thumbnailURL, "Thumbnail URL is incorrect")
        XCTAssertEqual(comicDetailVM.creatorIDs, comic.creatorIDs, "Creator IDs are incorrect")
        XCTAssertEqual(comicDetailVM.characterIDs, comic.characterIDs, "Charactor IDs are in correct")
    }
}

// MARK: - Helper
extension ComicsVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.data = [
            Comic(title: "Zeroth comic title",
                  descriptionText: "Zeroth comic description")!,
            Comic(title: "First comic title",
                  descriptionText: "First comic description")!,
            Comic(title: "Second comic title",
                  descriptionText: "Second comic description")!,
            Comic(title: "Third comic title",
                  descriptionText: "Third comic description")!,
        ]
        viewModel.listItems.value = viewModel.data.map({ ComicItemVM(comic: $0) })
    }
    
    private func checkFirstVCInNavigationStackIsComicsVC() {
        XCTAssertEqual(navigationController.viewControllers.count, 1, "Precondition")
        XCTAssertTrue(navigationController.viewControllers.first is ComicsVC, "Precondition")
    }
}
