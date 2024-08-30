//
//  ComicDetailVCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 27/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Tests UI with:
/// 1. All non empty data(Description, characters and creators)
/// 2. Empty description and non empty creator and characters
/// 3. All empty data(Description, characters and creators)
final class ComicDetailVCSnapshotTests: XCTestCase {
    var sut: ComicDetailVC!
    // var viewModel: ComicDetailVM!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - UI Components
extension ComicDetailVCSnapshotTests {
    func test_UI_withAllDataNonEmpty() {
        initializeSUTWithAllNonEmptyData()
        assertSnapshot(matching: sut, as: .image, record: true, testName: "test_comicDetailVC_withAllDataNonEmpty")
    }
    
    func test_UI_withEmptyDescriptionAndNonEmptyCreatorsAndCharacters() {
        initializeSUTWithEmptyDescriptionAndNonEmptyCharactersAndCreators()
        assertSnapshot(matching: sut, as: .image, record: true, testName: "test_comicDetailVC_withEmptyDescriptionAndNonEmptyCreatorsAndCharacters")
    }
    
    func test_UI_withAllDataEmpty() {
        initializeSUTWithAllEmptyData()
        assertSnapshot(matching: sut, as: .image, record: true, testName: "test_comicDetailVC_withAllDataEmpty")
    }
}

// MARK: - Helper
extension ComicDetailVCSnapshotTests {
    func initializeSUTWithAllNonEmptyData() {
        let comic = Comic(title: "This is comic title",
                          descriptionText: "This is comic description",
                          characterIDs: ["character_id_0", "character_id_1", "character_id_2", "character_id_3", "character_id_4"],
                          creatorIDs: ["creator_id_0", "creator_id_1", "creator_id_2", "creator_id_3", "creator_id_4"])!
        let viewModel = ComicDetailVM(comic: comic)
        sut = ComicDetailVC(viewModel: viewModel)
        
    }
    
    func initializeSUTWithEmptyDescriptionAndNonEmptyCharactersAndCreators() {
        let comic = Comic(title: "This is comic title",
                          descriptionText: "",
                          characterIDs: ["character_id_0", "character_id_1", "character_id_2", "character_id_3", "character_id_4"],
                          creatorIDs: ["creator_id_0", "creator_id_1", "creator_id_2", "creator_id_3", "creator_id_4"])!
        let viewModel = ComicDetailVM(comic: comic)
        sut = ComicDetailVC(viewModel: viewModel)
    }
    
    func initializeSUTWithAllEmptyData() {
        let comic = Comic(title: "This is comic title",
                          descriptionText: "")!
        let viewModel = ComicDetailVM(comic: comic)
        sut = ComicDetailVC(viewModel: viewModel)
    }
}
