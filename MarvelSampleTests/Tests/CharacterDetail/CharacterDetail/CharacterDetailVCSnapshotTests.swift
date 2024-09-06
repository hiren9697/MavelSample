//
//  CharacterDetailVCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 03/09/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Tests UI with:
/// 1. All non empty data(Comics and series)
/// 2. All empty data(Comics and series)
final class CharacterDetailVCSnapshotTests: XCTestCase {
    var sut: TestableCharacterDetailVC!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - UI Components
extension CharacterDetailVCSnapshotTests {
    func test_UI_withAllDataNonEmpty() {
        initializeSUTWithAllNonEmptyData()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_characterDetailVC_withAllDataNonEmpty")
    }
    
    func test_UI_withAllDataEmpty() {
        initializeSUTWithAllEmptyData()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_characterDetailVC_withAllDataEmpty")
    }
}

// MARK: - Helper
extension CharacterDetailVCSnapshotTests {
    func initializeSUTWithAllNonEmptyData() {
        let character = Character(name: "This is character name",
                                  comicIDs: ["comic_id_0", "comic_id_1", "comic_id_2", "comic_id_3", "comic_id_4"],
                                  seriesIDs: ["series_id_0", "series_id_1", "series_id_2", "series_id_3", "series_id_4"])!
        let viewModel = TestableCharacterDetailVM(character: character)
        sut = TestableCharacterDetailVC(viewModel: viewModel)
    }
    
    func initializeSUTWithAllEmptyData() {
        let character = Character(name: "This is character name")!
        let viewModel = TestableCharacterDetailVM(character: character)
        sut = TestableCharacterDetailVC(viewModel: viewModel)
    }
}
