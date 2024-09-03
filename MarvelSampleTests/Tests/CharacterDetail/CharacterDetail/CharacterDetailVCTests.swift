//
//  CharacterDetailVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 03/09/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. UI components is in view hierarchy
/// 2. Fill data from viewModel
final class CharacterDetailVCTests: XCTestCase {
    var sut: CharacterDetailVC!
    var viewModel: CharacterDetailVM!
    
    override func setUp() {
        super.setUp()
        let character = Character(name: "This is character name")!
        viewModel = CharacterDetailVM(character: character)
        sut = CharacterDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - UI Components
extension CharacterDetailVCTests {
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
    
    func test_comicsCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.comicCollectionView.superview, sut.stackView)
    }
    
    func test_seriesCollectionView_isInViewHierarchy() {
        XCTAssertEqual(sut.seriesCollectionView.superview, sut.stackView)
    }
}

// MARK: - Fill data
extension CharacterDetailVCTests {
    func test_fillDataFromViewModel() {
        XCTAssertEqual(sut.titleLabel.text, viewModel.name)
    }
    
    func test_comicCollectionView_hasCorrectViewModel() {
        let comicGridVM = ComicHorizontalGridVM(data: viewModel.comicIDs.map { ComicHorizontalGridItemVM(modelID: $0) })
        XCTAssertEqual(sut.comicCollectionView.viewModel, comicGridVM)
    }
    
    func test_creatorCollectionView_hasCorrectViewModel() {
        let serisGridVM = SeriesHorizontalGridVM(data: viewModel.seriesIDs.map { SeriesHorizontalGridItemVM(modelID: $0) })
        XCTAssertEqual(sut.seriesCollectionView.viewModel, serisGridVM)
    }
}
