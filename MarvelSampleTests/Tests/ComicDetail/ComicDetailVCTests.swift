//
//  ComicDetailVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 03/08/24.
//

import XCTest
@testable import MarvelSample

final class ComicDetailVCTests: XCTestCase {

    var sut: ComicDetailVC!
    
    override func setUp() {
        super.setUp()
        sut = ComicDetailVC()
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
}
