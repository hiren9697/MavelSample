//
//  EventsVCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 25/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Test UI with all the fetchStates
final class EventsVCSnapshotTests: XCTestCase {
    var sut: TestableEventsVC!
    var viewModel: TestableEventsVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableEventsVM()
        sut = TestableEventsVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - Test
extension EventsVCSnapshotTests {
    func test_UIWithFetchState_initialLoading() {
        viewModel.fetchState.value = .initialLoading
        assertSnapshot(matching: sut,
                       as: .image,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_eventsVC_withFetchState_initialLoading")
    }
    
    func test_UIWithFetchState_emptyData() {
        viewModel.fetchState.value = .emptyData
        assertSnapshot(matching: sut,
                       as: .image,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_eventsVC_withFetchState_emptyData")
    }
    
    func test_UIWithFetchState_error() {
        viewModel.fetchState.value = .error(DummyNetworkError.somethingWentWrong)
        assertSnapshot(matching: sut,
                       as: .image,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_eventsVC_withFetchState_error")
    }
    
    func test_UIWithFetchState_idle() {
        addListItemsWithIdleModeInViewModel()
        assertSnapshot(matching: sut,
                       as: .image,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_eventsVC_withFetchState_idle")
    }
    
    func test_UIWithFetchState_nextPageLoading() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .loadingNextPage
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_eventsVC_withFetchState_loadingNextPage")
    }
}

// MARK: - Helper
extension EventsVCSnapshotTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            EventItemVM(event: Event(title: "Zeroth event title", descriptionText: "Zeroth event description")!),
            EventItemVM(event: Event(title: "First event title", descriptionText: "First event description")!),
            EventItemVM(event: Event(title: "Second event title", descriptionText: "Second event description")!),
            EventItemVM(event: Event(title: "Third event title", descriptionText: "Third event description")!),
            ]
    }
}
