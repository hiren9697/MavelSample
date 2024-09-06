//
//  HorizontalThumbnailTitleGridSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 27/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Tests HorizontalThumbnailTitleGrid UI with empty and not empty data
final class HorizontalThumbnailTitleGridSnapshotTests: XCTestCase {
    var sut: ThumbnailTitleHorizontalGridView<GenericHorizontalThumbnailTitleGridViewModel<TestableThumbnailTitleVM>>!
    var viewModel: GenericHorizontalThumbnailTitleGridViewModel<TestableThumbnailTitleVM>!
    
    override func setUp() {
        super.setUp()
        /// ViewModel and SUT are initialzed with non-empty data
        /// If test method requires to test empty data state then they can initialze them by calling helper method
        setUPSUTWithNonEmptyData()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewModel = nil
    }
}

// MARK: - UI Tests
extension HorizontalThumbnailTitleGridSnapshotTests {
    func testUI_withData_empty() {
        setUpSUTWithEmptyData()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_horizontalThumbnailTitleGrid_withEmpty_data")
    }
    
    func testUI_withData_nonEmpty() {
        setUPSUTWithNonEmptyData()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_horizontalThumbnailTitleGrid_withNonEmpty_data")
    }
}

// MARK: - Helper
extension HorizontalThumbnailTitleGridSnapshotTests {
    private func setUpSUTWithEmptyData() {
        viewModel = GenericHorizontalThumbnailTitleGridViewModel(title: "Test title",
                                                                 emptyDataTitle: "Test empty title",
                                                                 data: [])
        sut = ThumbnailTitleHorizontalGridView(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 200)
    }
    
    private func setUPSUTWithNonEmptyData() {
        let first = TestableThumbnailTitleVM(title: "First",
                                             thumbnailURL: nil,
                                             dataFetchState: nil,
                                             errorVM: nil)
        let second = TestableThumbnailTitleVM(title: "Second",
                                              thumbnailURL: nil,
                                              dataFetchState: nil,
                                              errorVM: nil)
        let third = TestableThumbnailTitleVM(title: "Third",
                                             thumbnailURL: nil,
                                             dataFetchState: nil,
                                             errorVM: nil)
        let fourth = TestableThumbnailTitleVM(title: "Fourth",
                                              thumbnailURL: nil,
                                              dataFetchState: nil,
                                              errorVM: nil)
        let fifth = TestableThumbnailTitleVM(title: "Fifth",
                                             thumbnailURL: nil,
                                             dataFetchState: nil,
                                             errorVM: nil)
        let data = [first, second, third, fourth, fifth]
        viewModel = GenericHorizontalThumbnailTitleGridViewModel<TestableThumbnailTitleVM>(title: "Test title",
                                                                                           emptyDataTitle: "Test empty title",
                                                                                           data: data)
        sut = ThumbnailTitleHorizontalGridView(viewModel: viewModel)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 200)
    }
}
