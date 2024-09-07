//
//  EventDetailVCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 07/09/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Tests UI with:
/// 1. All non empty data(Description, characters, creators and comics)
/// 2. Empty description and non empty creator, characters and comics
/// 3. All empty data(Description, characters, creators and comics)
final class EventDetailVCSnapshotTests: XCTestCase {
    var sut: TestableEventDetailVC!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - UI Components
extension EventDetailVCSnapshotTests {
    func test_UI_withAllDataNonEmpty() {
        initializeSUTWithAllNonEmptyData()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_evnetDetailVC_withAllDataNonEmpty")
    }
    
    func test_UI_withEmptyDescriptionAndNonEmptyCreatorsCharactersAndComics() {
        initializeSUTWithEmptyDescriptionAndNonEmptyCharactersAndCreators()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_eventDetailVC_withEmptyDescriptionAndNonEmptyCreatorsCharactersAndComics")
    }
    
    func test_UI_withAllDataEmpty() {
        initializeSUTWithAllEmptyData()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_eventDetailVC_withAllDataEmpty")
    }
}

// MARK: - Helper
extension EventDetailVCSnapshotTests {
    func initializeSUTWithAllNonEmptyData() {
        let event = Event(title: "This is event title",
                          descriptionText: "This is event description",
                          characterIDs: ["character_id_0", "character_id_1", "character_id_2", "character_id_3", "character_id_4"],
                          creatorIDs: ["creator_id_0", "creator_id_1", "creator_id_2", "creator_id_3", "creator_id_4"],
                          comicIDs: ["comic_id_0", "comic_id_1", "comic_id_2", "comic_id_3", "comic_id_4"])!
        let viewModel = TestableEventDetailVM(event: event)
        sut = TestableEventDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    func initializeSUTWithEmptyDescriptionAndNonEmptyCharactersAndCreators() {
        let event = Event(title: "This is event title",
                          descriptionText: "",
                          characterIDs: ["character_id_0", "character_id_1", "character_id_2", "character_id_3", "character_id_4"],
                          creatorIDs: ["creator_id_0", "creator_id_1", "creator_id_2", "creator_id_3", "creator_id_4"],
                          comicIDs: ["comic_id_0", "comic_id_1", "comic_id_2", "comic_id_3", "comic_id_4"])!
        let viewModel = TestableEventDetailVM(event: event)
        sut = TestableEventDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    func initializeSUTWithAllEmptyData() {
        let event = Event(title: "This is event title",
                          descriptionText: "")!
        let viewModel = TestableEventDetailVM(event: event)
        sut = TestableEventDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
}


