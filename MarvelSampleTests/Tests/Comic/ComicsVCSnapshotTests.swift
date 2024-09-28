//
//  ComicsVCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 23/08/24.
//

import XCTest
import SnapshotTesting
import SnapshotTesting
@testable import MarvelSample

/// Tests:
/// 1. UI of comics screen with all the fetch states
final class ComicsVCSnapshotTests: XCTestCase {
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

// MARK: - Tests
extension ComicsVCSnapshotTests {
    func test_UIWithFetchState_initialLoading() {
        viewModel.fetchState.value = .initialLoading
        assertSnapshot(matching: sut,
                       as: SnapshotTestConfiguration.snapshottingForViewController,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_comicsVC_withFetchState_initialLoading")
    }
    
    func test_UIWithFetchState_emptyData() {
        viewModel.fetchState.value = .emptyData
        assertSnapshot(matching: sut,
                       as: SnapshotTestConfiguration.snapshottingForViewController,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_comicsVC_withFetchState_emptyData")
    }
    
    func test_UIWithFetchState_error() {
        viewModel.fetchState.value = .error(DummyNetworkError.somethingWentWrong)
        assertSnapshot(matching: sut,
                       as: SnapshotTestConfiguration.snapshottingForViewController,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_comicsVC_withFetchState_error")
    }
    
    func test_UIWithFetchState_idle() {
        addListItemsWithIdleModeInViewModel()
        assertSnapshot(matching: sut,
                       as: SnapshotTestConfiguration.snapshottingForViewController,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_comicsVC_withFetchState_idle")
    }
    
    func test_UIWithFetchState_nextPageLoading() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .loadingNextPage
        assertSnapshot(matching: sut,
                       as: SnapshotTestConfiguration.snapshottingForViewController,
                       record: SnapshotTestConfiguration.isRecordingEnabled,
                       testName: "test_comicsVC_withFetchState_loadingNextPage")
    }
}

// MARK: - Helper classes
extension ComicsVCSnapshotTests {
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
}


