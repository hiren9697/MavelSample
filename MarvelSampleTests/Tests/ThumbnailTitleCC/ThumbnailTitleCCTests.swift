//
//  ThumbnailTitleCC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import XCTest
import Combine
@testable import MarvelSample

final class ThumbnailTitleCCTests: XCTestCase {
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

// MARK: - UI Tests
extension ThumbnailTitleCCTests {
    func test_containerView_isInViewHierarchy() {
        XCTAssertEqual(sut.containerView.superview, sut.contentView, "containerView is not in view heirarchy")
    }
    
    func test_dataContainerView_isInViewHeirarchy() {
        XCTAssertEqual(sut.dataContainerView.superview, sut.containerView, "dataContainerView is not in view hierarchy")
    }
    
    func test_imageView_isInViewHierarchy() {
        XCTAssertEqual(sut.imageView.superview, sut.dataContainerView, "imageView is not in view hierarchy")
    }
    
    func test_titleLabel_isInViewHierarchy() {
        XCTAssertEqual(sut.titleLabel.superview, sut.dataContainerView, "titleLabel is not in view hierarchy")
    }
    
    func test_loader_isInViewHierarchy() {
        XCTAssertEqual(sut.loader.superview, sut.containerView, "loader is not in view heirarchy")
    }
}

// MARK: - Data Update Tests
extension ThumbnailTitleCCTests {
    func test_cellUpdatesUI_fromViewModel() {
        sut.update(viewModel: viewModel)
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
    }
    
    func test_fetchState_nil_shouldHideLoaderAndShowDataContainerView() {
        XCTAssertTrue(sut.loader.isHidden, "loader is not hidden")
        XCTAssertFalse(sut.dataContainerView.isHidden, "dataContainerView is not visible")
    }
    
    func test_fetchState_notStarted_shouldHideEverything() {
        setViewModelWithFetchState(.notStarted)
        XCTAssertFalse(sut.loader.isAnimating, "loader is animating")
        XCTAssertTrue(sut.loader.isHidden, "loader is not hidden")
        XCTAssertTrue(sut.dataContainerView.isHidden, "dataContainerView is not hidden")
    }
    
    func test_fetchState_loading_shouldShowLoaderAndHideDataContainerView() {
        setViewModelWithFetchState(.loading)
        XCTAssertTrue(sut.loader.isAnimating, "loader is not animating")
        XCTAssertFalse(sut.loader.isHidden, "loader is hidden")
        XCTAssertTrue(sut.dataContainerView.isHidden, "dataContainerView is not hidden")
    }
    
    func test_fetchState_loaded_shouldHideLoaderAndShowDataContainer() {
        setViewModelWithFetchState(.loaded)
        XCTAssertFalse(sut.loader.isAnimating, "loader not animating")
        XCTAssertTrue(sut.loader.isHidden, "loader is not hidden")
        XCTAssertFalse(sut.dataContainerView.isHidden, "dataContainerView is hidden")
    }
    
    func test_fetchState_failed_shouldHideLoaderDataContainerViewAndShowErrorView() {
        // Need to implement this
    }
}

// MARK: - Helper
extension ThumbnailTitleCCTests {
    func setViewModelWithoutFetchState() {
        sut = nil
        viewModel = nil
        viewModel = TestableThumbnailTitleVM(title: "Test title",
                                             thumbnailURL: URL(string: "https://www.google.com"),
                                             dataFetchState: nil)
        sut = ThumbnailTitleCC()
        sut.update(viewModel: viewModel)
    }
    
    func setViewModelWithFetchState(_ state: ListItemLoadingState) {
        sut = nil
        viewModel = nil
        viewModel = TestableThumbnailTitleVM(title: "Test title",
                                             thumbnailURL: URL(string: "https://www.google.com"),
                                             dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>(state))
        sut = ThumbnailTitleCC()
        sut.update(viewModel: viewModel)
    }
}
