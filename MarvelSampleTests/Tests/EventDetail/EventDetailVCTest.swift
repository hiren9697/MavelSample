//
//  EventDetailVCTest.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 07/09/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. UI components is in view hierarchy
/// 2. Fill data from viewModel
/// NOTE: By default this class initialize SUT with non-empty description text, But test method can call 'initializeSUTWithEmptyDescriptionText' method to initialize SUT with empty description text
final class EventDetailVCTests: XCTestCase {
    var sut: TestableEventDetailVC!
    var viewModel: TestableEventDetailVM!
    
    override func setUp() {
        super.setUp()
        initializeSUTWithNonEmptyDescriptionText()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - UI Components
extension EventDetailVCTests {
    func test_scrollViewComponents_areInViewHierarchy() {
        XCTAssertEqual(sut.scrollView.superview, sut.view, "scrollView is not in view hierarchy")
        XCTAssertEqual(sut.stackView.superview, sut.scrollView, "stackView is not in view hierarchy")
    }
    
    func test_imageViewComponents_areInViewHierarchy() {
        XCTAssertEqual(sut.imageViewContainer.superview, sut.stackView, "imageViewContainer is not in view hierarchy")
        XCTAssertEqual(sut.imageView.superview, sut.imageViewContainer, "imageView is not in view hierarchy")
    }
    
    func test_titleComponents_areInViewHierarchy() {
        XCTAssertEqual(sut.titleLabelContainer.superview, sut.stackView, "titleLabelContainer is not in view hierarchy")
        XCTAssertEqual(sut.titleLabel.superview, sut.titleLabelContainer, "titleLabel is not in view hierarchy")
    }
    
    func test_descriptionComponents_areInViewHierarchy() {
        XCTAssertEqual(sut.descriptionLabelContainer.superview, sut.stackView, "descriptionLabelContainer is not in view hierarchy")
        XCTAssertEqual(sut.descriptionLabel.superview, sut.descriptionLabelContainer, "descriptionLabel is not in view hierarchy")
    }
    
    func test_comicsCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.comicCollectionView.superview, sut.stackView)
    }
    
    func test_charactersCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.characterCollectionView.superview, sut.stackView)
    }
    
    func test_creatorsCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.creatorCollectionView.superview, sut.stackView)
    }
}

// MARK: - Fill data
extension EventDetailVCTests {
    func test_fillDataFromViewModel() {
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.descriptionLabel.text, viewModel.description)
    }
    
    func test_descriptionLabelContainer_shouldHide_withViewModelWithEmptyDescriptionText() {
        initializeSUTWithEmptyDescriptionText()
        XCTAssertTrue(sut.descriptionLabelContainer.isHidden)
    }
    
    func test_descriptionLabelContainer_shouldShow_withViewModelWithNonEmptyDescriptionText() {
        XCTAssertFalse(sut.descriptionLabelContainer.isHidden)
    }
    
    func test_characterCollectionView_hasCorrectViewModel() {
        XCTAssertEqual(sut.characterCollectionView.viewModel, viewModel.charactersHorizontalGridVM)
    }
    
    func test_creatorCollectionView_hasCorrectViewModel() {
        XCTAssertEqual(sut.creatorCollectionView.viewModel, viewModel.creatorsHorizontalGridVM)
    }
    
    func test_comicCollectionView_hasCorrectViewModel() {
        XCTAssertEqual(sut.comicCollectionView.viewModel, viewModel.comicsHorizontalGridVM)
    }
}

// MARK: - Helper
extension EventDetailVCTests {
    func initializeSUTWithNonEmptyDescriptionText() {
        let event = Event(title: "This is event title",
                          descriptionText: "This is event description")!
        viewModel = TestableEventDetailVM(event: event)
        sut = TestableEventDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    func initializeSUTWithEmptyDescriptionText() {
        let event = Event(title: "This is event title",
                          descriptionText: "")!
        viewModel = TestableEventDetailVM(event: event)
        sut = TestableEventDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
}

