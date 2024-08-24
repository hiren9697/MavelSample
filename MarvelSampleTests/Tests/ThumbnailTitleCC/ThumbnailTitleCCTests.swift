//
//  ThumbnailTitleCC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import XCTest
import Combine
@testable import MarvelSample

/// Tests:
/// 1. UI components
/// 2. Data updates with viewModel and fetchState
/// 3. PrepareForReuse
final class ThumbnailTitleCCTests: XCTestCase {
    var sut: TestableThumbnailTitleCC<TestableThumbnailTitleVM>!
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

// MARK: - 1. UI Tests
extension ThumbnailTitleCCTests {
    func test_containerView_isInViewHierarchy() {
        XCTAssertEqual(sut.containerView.superview, sut.contentView, "containerView is not in view heirarchy")
    }
    
    func test_stackView_isInViewHierarchy() {
        XCTAssertEqual(sut.stackView.superview, sut.containerView, "stackView is not in view heirarchy")
    }
    
    func test_dataContainerView_isInViewHeirarchy() {
        XCTAssertEqual(sut.dataContainerView.superview, sut.stackView, "dataContainerView is not in view hierarchy")
    }
    
    func test_imageView_isInViewHierarchy() {
        XCTAssertEqual(sut.imageView.superview, sut.dataContainerView, "imageView is not in view hierarchy")
    }
    
    func test_titleLabel_isInViewHierarchy() {
        XCTAssertEqual(sut.titleLabel.superview, sut.dataContainerView, "titleLabel is not in view hierarchy")
    }
    
    func test_errorViewContainer_isInViewHierarchy() {
        XCTAssertEqual(sut.errorContainerView.superview, sut.stackView, "errorContainerView is not in view heirarchy")
    }
    
    func test_errorView_isInViewHierarchy() {
        XCTAssertEqual(sut.errorView.superview, sut.errorContainerView, "errorView is not in view hierarchy")
    }
    
    func test_loader_isInViewHierarchy() {
        XCTAssertEqual(sut.loader.superview, sut.containerView, "loader is not in view heirarchy")
    }
}

// MARK: - 2. Data Update Tests
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
        test_UIComponents_forNotStartedState(line: #line)
    }
    
    func test_fetchState_loading_shouldShowLoaderAndHideStackView() {
        setViewModelWithFetchState(.loading)
        test_UIComponents_forLoadingState(line: #line)
    }
    
    func test_fetchState_loaded_shouldHideLoaderErrorViewAndShowDataContainer() {
        setViewModelWithFetchState(.loaded)
        test_UIComponents_forLoadedState(line: #line)
    }
    
    func test_fetchState_failed_shouldHideLoaderDataContainerViewAndShowErrorView() {
        setViewModelWithFetchState(.failed)
        test_UIComponents_forFailedState(line: #line)
    }
    
    func test_fetchState_fromNotStartedToLoading_updatesUIComponents() {
        setViewModelWithFetchState(.notStarted)
        test_UIComponents_forNotStartedState(line: #line)
        viewModel.dataFetchState?.value = .loading
        test_UIComponents_forLoadingState(line: #line)
    }
    
    func test_fetchState_fromLoadigToFailed_updatedUIComponents() {
        setViewModelWithFetchState(.loading)
        test_UIComponents_forLoadingState(line: #line)
        viewModel.dataFetchState?.value = .failed
        test_UIComponents_forFailedState(line: #line)
    }
    
    func test_fetchState_fromLoadigToLoaded_updatedUIComponents() {
        setViewModelWithFetchState(.loading)
        test_UIComponents_forLoadingState(line: #line)
        viewModel.dataFetchState?.value = .loaded
        test_UIComponents_forLoadedState(line: #line)
    }
}

// MARK: - 3. PrepareForReuse
extension ThumbnailTitleCCTests {
    func test_prepareForReuse_shouleRemoveAllBindings() {
        XCTAssertTrue(sut.bindings.isEmpty, "Precondition")
        setViewModelWithFetchState(.notStarted)
        XCTAssertFalse(sut.bindings.isEmpty, "Precondition")
        sut.prepareForReuse()
        XCTAssertTrue(sut.bindings.isEmpty)
    }
}

// MARK: - Test Helper
/// These methods are helper methods used by test methods,
/// Declared private because these methods are not intended to called by XCTest framework, These should only be called by other test methods
extension ThumbnailTitleCCTests {
    private func test_UIComponents_forNotStartedState(line: UInt) {
        XCTAssertFalse(sut.loader.isAnimating, "loader is animating", line: line)
        XCTAssertTrue(sut.loader.isHidden, "loader is not hidden", line: line)
        XCTAssertTrue(sut.stackView.isHidden, "stackView is not hidden", line: line)
    }
    
    private func test_UIComponents_forLoadingState(line: UInt) {
        XCTAssertTrue(sut.loader.isAnimating, "loader is not animating", line: line)
        XCTAssertFalse(sut.loader.isHidden, "loader is hidden", line: line)
        XCTAssertTrue(sut.stackView.isHidden, "stackView is not hidden", line: line)
    }
    
    private func test_UIComponents_forLoadedState(line: UInt) {
        XCTAssertFalse(sut.loader.isAnimating, "loader not animating", line: line)
        XCTAssertTrue(sut.loader.isHidden, "loader is not hidden", line: line)
        XCTAssertFalse(sut.stackView.isHidden, "stackView is hidden", line: line)
        XCTAssertFalse(sut.dataContainerView.isHidden, "dataContainerView is hidden", line: line)
        XCTAssertTrue(sut.errorContainerView.isHidden, "errorContainerView is not hidden", line: line)
    }
    
    private func test_UIComponents_forFailedState(line: UInt) {
        XCTAssertFalse(sut.loader.isAnimating, "loader not animating", line: line)
        XCTAssertTrue(sut.loader.isHidden, "loader is not hidden", line: line)
        XCTAssertFalse(sut.stackView.isHidden, "stackView is hidden", line: line)
        XCTAssertTrue(sut.dataContainerView.isHidden, "dataContainerView is not hidden", line: line)
        XCTAssertFalse(sut.errorContainerView.isHidden, "errorContainerView is hidden", line: line)
    }
}

// MARK: - Data/ViewModel Helper
extension ThumbnailTitleCCTests {
    func setViewModelWithoutFetchState() {
        sut = nil
        viewModel = nil
        viewModel = TestableThumbnailTitleVM(title: "Test title",
                                             thumbnailURL: URL(string: "https://www.google.com"),
                                             dataFetchState: nil,
                                             errorVM: nil)
        sut = TestableThumbnailTitleCC()
        sut.update(viewModel: viewModel)
    }
    
    func setViewModelWithFetchState(_ state: ListItemLoadingState) {
        sut = nil
        viewModel = nil
        viewModel = TestableThumbnailTitleVM(title: "Test title",
                                             thumbnailURL: URL(string: "https://www.google.com"),
                                             dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>(state),
                                             errorVM: nil)
        sut = TestableThumbnailTitleCC()
        sut.update(viewModel: viewModel)
    }
}
