//
//  ComicItemCCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 22/07/24.
//

import XCTest
@testable import MarvelSample

final class ComicItemCCTests: XCTestCase {

    var sut: ComicItemCC!
    var viewModel: ComicItemVM!
    
    override func setUp() {
        super.setUp()
        sut = ComicItemCC()
        sut.layoutIfNeeded()
    }
    
    func test_imageView_isInViewHierarchy() {
        Log.info(sut.imageView)
        // XCTAssertEqual(sut.imageView.superview, sut.contentView)
    }

    private func addListItemsWithIdleModeInViewModel(viewModel: ComicsVM) {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            ComicItemVM(comic: Comic(title: "Zeroth comic title",
                                     descriptionText: "Zeroth comic description")!),
            ComicItemVM(comic: Comic(title: "First comic title",
                                     descriptionText: "First comic description")!),
            ComicItemVM(comic: Comic(title: "Second comic title",
                                     descriptionText: "Third comic description")!),
            ComicItemVM(comic: Comic(title: "Third comic title",
                                     descriptionText: "Third comic description")!),
        ]
    }
}
