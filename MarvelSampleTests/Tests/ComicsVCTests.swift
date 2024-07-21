//
//  ComicsVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 21/07/24.
//

import XCTest
@testable import MarvelSample

final class ComicsVCTests: XCTestCase {
    
    var sut: ComicsVC!
    var viewModel: ComicsVM!
    
    override func setUp() {
        super.setUp()
        viewModel = ComicsVM()
        sut = ComicsVC(viewModel: viewModel)
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
        XCTAssertTrue(zerothCell is ComicItemCC, "zerothCell is not ComicItemCC")
        let firstCell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertTrue(firstCell is ComicItemCC, "firstCell is not ComicItemCC")
        let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.count - 1)
        XCTAssertTrue(lastCell is ComicItemCC, "lastCell is not ComicItemCC")
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
            ComicItemVM(comic: Comic(title: "Fourth comic title",
                                     descriptionText: "Fourth comic description")!),
        ]
    }
}
