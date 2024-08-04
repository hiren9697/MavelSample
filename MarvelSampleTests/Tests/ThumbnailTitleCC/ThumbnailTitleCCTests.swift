//
//  ThumbnailTitleCC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import XCTest
@testable import MarvelSample

final class ThumbnailTitleCCTests: XCTestCase {

    var sut: ThumbnailTitleCC<TestableThumbnailTitleData>!
    var viewModel: TestableThumbnailTitleData!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableThumbnailTitleData(title: "This is just a testing title",
                                               thumbnailURL: URL(string: "https://www.google.com"))
        sut = ThumbnailTitleCC()
        sut.layoutIfNeeded()
        sut.layoutSubviews()
    }
    
    func test_components_isInViewHierarchy() {
        Log.info(sut.imageView)
        XCTAssertEqual(sut.containerView.superview, sut.contentView)
        XCTAssertEqual(sut.dataContainerView.superview, sut.containerView)
        XCTAssertEqual(sut.imageView.superview, sut.dataContainerView)
        XCTAssertEqual(sut.titleLabel.superview, sut.dataContainerView)
        XCTAssertEqual(sut.loader.superview, sut.containerView)
    }
    
    func test_cellUpdatesUI_fromViewModel() {
        sut.updateUI(viewModel: viewModel)
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
    }
}
