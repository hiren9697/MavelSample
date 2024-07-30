//
//  CharactersVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import XCTest
@testable import MarvelSample

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
        XCTAssertTrue(zerothCell is CharacterItemCC, "zerothCell is not CharacterItemCC")
        let firstCell = cellForRow(in: sut.collectionView, row: 1)
        XCTAssertTrue(firstCell is CharacterItemCC, "firstCell is not CharacterItemCC")
        let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.count - 1)
        XCTAssertTrue(lastCell is CharacterItemCC, "lastCell is not CharacterItemCC")
    }
    
    func test_cellForRow_withFilledData_updatesUIIfCell() {
        addListItemsWithIdleModeInViewModel()
        guard let zerothCell = cellForRow(in: sut.collectionView, row: 0) as? CharacterItemCC else {
            XCTFail("Dequed zeroth cell is not CharacterItemCC")
            return
        }
        XCTAssertEqual(zerothCell.nameLabel.text,
                       "Zeroth character name")
        guard let firstCell = cellForRow(in: sut.collectionView, row: 1) as? CharacterItemCC else {
            XCTFail("Dequed first cell is not CharacterItemCC")
            return
        }
        XCTAssertEqual(firstCell.nameLabel.text,
                       "First character name")
        guard let lastCell = cellForRow(in: sut.collectionView, row: viewModel.listItems.value.lastIndex) as? CharacterItemCC else {
            XCTFail("Dequed last cell is not CharacterItemCC")
            return
        }
        XCTAssertEqual(lastCell.nameLabel.text,
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
