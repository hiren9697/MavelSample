//
//  ThumbnailTitleCCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 23/08/24.
//

import XCTest
import SnapshotTesting
import Combine
@testable import MarvelSample

final class ThumbnailTitleCCSnapshotTests: XCTestCase {
    var sut: ThumbnailTitleCC<TestableThumbnailTitleVM>!
    var viewModel: TestableThumbnailTitleVM!
    
    override func setUp() {
        super.setUp()
        /// By default viewModel is set with nil fetshState,
        /// Test methods can call helper methods to set fetchState
        setViewModelWithoutFetchState()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension ThumbnailTitleCCSnapshotTests {
    func testUI_withFetchState_nil() {
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_thumbnailTitleCC_withFetchState_nil")
    }
    
    func testUI_withFetchState_notStarted() {
        setViewModelWithFetchState(.notStarted)
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_thumbnailTitleCC_withFetchState_notStarted")
    }
    
    func testUI_withFetchState_loading() {
        setViewModelWithFetchState(.loading)
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_thumbnailTitleCC_withFetchState_loading")
    }
    
    func testUI_withFetchState_loaded() {
        setViewModelWithFetchState(.loaded)
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_thumbnailTitleCC_withFetchState_loaded")
    }
}

// MARK: - Data/ViewModel Helper
extension ThumbnailTitleCCSnapshotTests {
    func setViewModelWithoutFetchState() {
        sut = nil
        viewModel = nil
        viewModel = TestableThumbnailTitleVM(title: "Test title",
                                             thumbnailURL: URL(string: "https://www.google.com"),
                                             dataFetchState: nil,
                                             errorVM: nil)
        sut = ThumbnailTitleCC()
        sut.update(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
    }
    
    func setViewModelWithFetchState(_ state: ListItemLoadingState) {
        sut = nil
        viewModel = nil
        viewModel = TestableThumbnailTitleVM(title: "Test title",
                                             thumbnailURL: URL(string: "https://www.google.com"),
                                             dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>(state),
                                             errorVM: nil)
        sut = ThumbnailTitleCC()
        sut.update(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
    }
}
