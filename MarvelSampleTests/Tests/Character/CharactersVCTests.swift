//
//  CharactersVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Dequeues correct type of cell
/// 2. Updates / fills correct data to collectionView cell
final class CharactersVCTests: XCTestCase {
    var navigationController: UINavigationController!
    var sut: TestableCharactersVC!
    var viewModel: TestableCharactersVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableCharactersVM()
        sut = TestableCharactersVC(viewModel: viewModel)
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

// MARK: - Item selection
extension CharactersVCTests {
    func test_itemSelection_withIdleState_navigatesToCharacterDetail() {
        // Arrange
        addListItemsWithIdleModeInViewModel()
        // Act
        checkFirstVCInNavigationStackIsCharactersVC()
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        executeRunLoop()
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 2, "After selecting item, There should be 2 viewControllers in navigation stack")
        XCTAssertTrue(navigationController.viewControllers.first is CharactersVC, "First VC in navigation stack should be CharactersVC")
        XCTAssertTrue(navigationController.viewControllers[1] is CharacterDetailVC, "Second VC in navigation stack should be CharacterDetailVC")
    }
    
    func test_afterItemSelection_addedCharacterDetail_shouldHaveCorrectViewModel() {
        // Arrange
        addListItemsWithIdleModeInViewModel()
        // Act
        checkFirstVCInNavigationStackIsCharactersVC()
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        executeRunLoop()
        // Assert
        guard let characterDetailVC = navigationController.viewControllers.last as? CharacterDetailVC else {
            XCTFail("last view controller in navigation controller is not CharacterDetailVC")
            return
        }
        let characterDetailVM = characterDetailVC.viewModel
        let character = viewModel.data.first!
        XCTAssertEqual(characterDetailVM.name, character.name, "Character name is incorrect")
        XCTAssertEqual(characterDetailVM.thumbnailURL, character.thumbnailURL, "Thumbnail URL is incorrect")
        XCTAssertEqual(characterDetailVM.comicIDs, character.comicIDs, "Comics IDs are incorrect")
        XCTAssertEqual(characterDetailVM.seriesIDs, character.seriesIDs, "Series IDs are in correct")
    }
}

// MARK: - Helper
extension CharactersVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.data = [
            Character(name: "Zeroth character name")!,
            Character(name: "First character name")!,
            Character(name: "Second character name")!,
            Character(name: "Third character name")!,
        ]
        viewModel.listItems.value = viewModel.data.map { CharacterItemVM(character: $0) }
    }
    
    private func checkFirstVCInNavigationStackIsCharactersVC() {
        XCTAssertEqual(navigationController.viewControllers.count, 1, "Precondition")
        XCTAssertTrue(navigationController.viewControllers.first is CharactersVC, "Precondition")
    }
}
