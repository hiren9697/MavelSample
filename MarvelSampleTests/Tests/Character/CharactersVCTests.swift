//
//  CharactersVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import XCTest
@testable import MarvelSample

// Notes:
// - This class doesn't test navigation title, as it changes tabBarController's title in viewWillAppear, I couldn't feagure out how to test this

final class CharactersVCTests: XCTestCase {
    var sut: TestableCharactersVC!
    var viewModel: TestableCharactersVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableCharactersVM()
        sut = TestableCharactersVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - CollectionView Cell
extension CharactersVCTests {
    
    func test_cellForRow_withFilledData_dequesCorrectTypeOfCell() {
        addListItemsWithIdleModeInViewModel()
        let zerothCell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertTrue(zerothCell is ThumbnailTitleCC<CharacterItemVM>, "zerothCell is not ThumbnailTitleCC<CharacterItemVM>")
        let firstCell = cellForRow(in: sut.collectionView, row: 1)
        XCTAssertTrue(firstCell is ThumbnailTitleCC<CharacterItemVM>, "firstCell is not ThumbnailTitleCC<CharacterItemVM>")
        let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.count - 1)
        XCTAssertTrue(lastCell is ThumbnailTitleCC<CharacterItemVM>, "lastCell is not ThumbnailTitleCC<CharacterItemVM>")
    }
    
    func test_cellForRow_withFilledData_updatesUIIfCell() {
        addListItemsWithIdleModeInViewModel()
        guard let zerothCell = cellForRow(in: sut.collectionView, row: 0) as? ThumbnailTitleCC<CharacterItemVM> else {
            XCTFail("Dequed zeroth cell is not ThumbnailTitleCC<CharacterItemVM>")
            return
        }
        XCTAssertEqual(zerothCell.titleLabel.text,
                       "Zeroth character name")
        guard let firstCell = cellForRow(in: sut.collectionView, row: 1) as? ThumbnailTitleCC<CharacterItemVM> else {
            XCTFail("Dequed first cell is not ThumbnailTitleCC<CharacterItemVM>")
            return
        }
        XCTAssertEqual(firstCell.titleLabel.text,
                       "First character name")
        guard let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.lastIndex) as? ThumbnailTitleCC<CharacterItemVM> else {
            XCTFail("Dequed last cell is not ThumbnailTitleCC<CharacterItemVM>")
            return
        }
        XCTAssertEqual(lastCell.titleLabel.text,
                       "Third character name")
    }
}

// MARK: - Helper
extension CharactersVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            CharacterItemVM(character: Character(name: "Zeroth character name")!),
            CharacterItemVM(character: Character(name: "First character name")!),
            CharacterItemVM(character: Character(name: "Second character name")!),
            CharacterItemVM(character: Character(name: "Third character name")!),
        ]
    }
}
