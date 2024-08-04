//
//  ComicsVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 21/07/24.
//

import XCTest
@testable import MarvelSample

// Notes:
// - This class doesn't test navigation title, as it changes tabBarController's title in viewWillAppear, I couldn't feagure out how to test this

final class ComicsVCTests: XCTestCase {
    
    var sut: TestableComicsVC!
    var viewModel: TestableComicsVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableComicsVM()
        sut = TestableComicsVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - CollectionView Cell
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

// MARK: - Helper
extension ComicsVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            ComicItemVM(comic: Comic(title: "Zeroth comic title",
                                     descriptionText: "Zeroth comic description")!),
            ComicItemVM(comic: Comic(title: "First comic title",
                                     descriptionText: "First comic description")!),
            ComicItemVM(comic: Comic(title: "Second comic title",
                                     descriptionText: "Third comic description")!),
            ComicItemVM(comic: Comic(title: "Third comic title",
                                     descriptionText: "Third comic description")!),
        ]
    }
}
