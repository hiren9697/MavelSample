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

final class ComicDetailVCTests: XCTestCase {

    var sut: ComicDetailVC!
    var viewModel: ComicDetailVM!
    
    override func setUp() {
        super.setUp()
        viewModel = getViewModel()
        sut = ComicDetailVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
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
}

// MARK: - Fill data
extension ComicDetailVCTests {
   
    func test_fillDataFromViewModel() {
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.descriptionLabel.text, viewModel.description)
    }
}

// MARK: - Helper
extension ComicDetailVCTests {
   
    func getViewModel()-> ComicDetailVM {
        let comic = Comic(title: "This is comic title",
                          descriptionText: "This is comic description")!
        let viewModel = ComicDetailVM(comic: comic)
        return viewModel
    }
}
