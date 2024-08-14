//
//  ComicDetailVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 03/08/24.
//

import XCTest
@testable import MarvelSample

// TO DO:
// - Test image view

/// Tests:
/// 1. UI components is in view hierarchy
/// 2. Fill data from viewModel
/// NOTE: By default this class initialize SUT with non-empty description text, But test method can call 'initializeSUTWithEmptyDescriptionText' method to initialize SUT with empty description text
final class ComicDetailVCTests: XCTestCase {
    var sut: ComicDetailVC!
    var viewModel: ComicDetailVM!
    
    override func setUp() {
        super.setUp()
        initializeSUTWithNonEmptyDescriptionText()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - UI Components
extension ComicDetailVCTests {
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
    
    func test_charactersCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.characterCollectionView.superview, sut.stackView)
    }
    
    func test_creatorsCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.creatorCollectionView.superview, sut.stackView)
    }
}

// MARK: - Fill data
extension ComicDetailVCTests {
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
        let characterGridVM = CharactersGridVM(data: viewModel.characterIDs.map { CDCharacterItemVM(modelID: $0) })
        XCTAssertEqual(sut.characterCollectionView.viewModel, characterGridVM)
    }
    
    func test_creatorCollectionView_hasCorrectViewModel() {
        let creatorGridVM = CreatorGridVM(data: viewModel.creatorIDs.map { CDCreatorItemVM(modelID: $0) })
        XCTAssertEqual(sut.creatorCollectionView.viewModel, creatorGridVM)
    }
}

// MARK: - Helper
extension ComicDetailVCTests {
    func initializeSUTWithNonEmptyDescriptionText() {
        let comic = Comic(title: "This is comic title",
                          descriptionText: "This is comic description")!
        viewModel = ComicDetailVM(comic: comic)
        sut = ComicDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    func initializeSUTWithEmptyDescriptionText() {
        let comic = Comic(title: "This is comic title",
                          descriptionText: "")!
        viewModel = ComicDetailVM(comic: comic)
        sut = ComicDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
}
