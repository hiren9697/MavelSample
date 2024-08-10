//
//  HorizontalThumbnailTitleGridViewTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import XCTest
@testable import MarvelSample

final class HorizontalThumbnailTitleGridViewTests: XCTestCase {

    var sut: ThumbnailTitleHorizontalGridView<TestableHorizontalThumbnailTitleGridVM>!
    var viewModel: TestableHorizontalThumbnailTitleGridVM!
    
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
extension HorizontalThumbnailTitleGridViewTests {
    func test_containerView_isInViewHierarchy() {
        XCTAssertEqual(sut.containerView.superview, sut)
    }
    
    func test_titleLabelAndTitleLabelContainer_isInViewHierarchy() {
        XCTAssertEqual(sut.titleLabel.superview, sut.titleLabelContainer, "titleLabel is not in view hierarchy")
        XCTAssertEqual(sut.titleLabelContainer.superview, sut.stackView, "titleLabelContainer is not in view hierarchy")
    }
    
    func test_collectionViewAndCollectionViewContainer_isInViewHierarchy() {
        XCTAssertEqual(sut.collectionView.superview, sut.collectionViewContainer, "collectionView is not in view hierarchy")
        XCTAssertEqual(sut.collectionViewContainer.superview, sut.stackView, "collectionViewContainer is not in view hierarchy")
    }
    
    func test_emptyDataTitleAndEmptyDataContainer_isInViewHierarchy() {
        XCTAssertEqual(sut.emptyDataLabel.superview, sut.emptyDataContainer, "emptyDataLabel is not in view hierarchy")
        XCTAssertEqual(sut.emptyDataContainer.superview, sut.stackView, "emptyDataContainer is not in view hierarchy")
    }
}

// MARK: - Data Update Tests
extension HorizontalThumbnailTitleGridViewTests {
   func test_titleText_isCorrect() {
        setUPSUTWithNonEmptyData()
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
    }
    
    func test_emptyDataTitleText_isCorrect() {
        XCTAssertEqual(sut.emptyDataLabel.text, viewModel.emptyDataTitle)
    }
    
    func test_withEmptyData_collectionViewContainerIsHiddenAndEmptyDataContainerIsVisible() {
        setUpSUTWithEmptyData()
        XCTAssertTrue(sut.collectionViewContainer.isHidden, "collectionViewContainer is not hidden")
        XCTAssertFalse(sut.emptyDataContainer.isHidden, "emptyDataContainer is not visible")
    } 
    
    func test_collectionView_shouldShowCells_withNonEmptyViewModelData() {
        XCTAssertEqual(numberOfRows(in: sut.collectionView),
                       viewModel.data.count)
    }
    
    func test_collectionView_dequesCorrectTypeOfCell_withNonEmptyViewModelData() {
        let firstCell = cellForRow(in: sut.collectionView, row: 0)
        XCTAssertNotNil(firstCell, "Precondition")
        XCTAssertFalse(sut.collectionViewContainer.isHidden, "Precondition")
        XCTAssertTrue(sut.emptyDataContainer.isHidden, "Precondition")
        XCTAssertTrue(firstCell is ThumbnailTitleCC<TestableThumbnailTitleVM>)
    }
}

// MARK: - Helper
extension HorizontalThumbnailTitleGridViewTests {
    
    private func setUpSUTWithEmptyData() {
        viewModel = TestableHorizontalThumbnailTitleGridVM(title: "Test title",
                                                           emptyDataTitle: "Test empty title",
                                                           data: [])
        sut = ThumbnailTitleHorizontalGridView(viewModel: viewModel)
    }
    
    private func setUPSUTWithNonEmptyData() {
        let first = TestableThumbnailTitleVM(title: "First",
                                             thumbnailURL: nil,
                                             dataFetchState: nil)
        let second = TestableThumbnailTitleVM(title: "Second",
                                              thumbnailURL: nil,
                                              dataFetchState: nil)
        let third = TestableThumbnailTitleVM(title: "Third",
                                             thumbnailURL: nil,
                                             dataFetchState: nil)
        let fourth = TestableThumbnailTitleVM(title: "Fourth",
                                              thumbnailURL: nil,
                                              dataFetchState: nil)
        let fifth = TestableThumbnailTitleVM(title: "Fifth",
                                             thumbnailURL: nil,
                                             dataFetchState: nil)
        let data = [first, second, third, fourth, fifth]
        viewModel = TestableHorizontalThumbnailTitleGridVM(title: "Test title",
                                                           emptyDataTitle: "Test empty title",
                                                           data: data)
        sut = ThumbnailTitleHorizontalGridView(viewModel: viewModel)
    }
}
