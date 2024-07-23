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
        viewModel = ComicItemVM(comic: Comic(title: "Zeroth comic title",
                                     descriptionText: "Zeroth comic description")!)
        let comicsVM = TestableComicsVM()
        addListItemsWithIdleModeInViewModel(viewModel: comicsVM)
        let vc = TestableComicsVC(viewModel: comicsVM)
        // putInViewHeirarchy(vc)
        vc.loadViewIfNeeded()
        sut = cellForRow(in: vc.collectionView, row: 0) as? ComicItemCC
        Log.info(sut)
    }
    
    func test_imageView_isInViewHierarchy() {
        Log.info("Sut: \(sut)")
        Log.info("imageView: \(sut.imageView)")
        XCTAssertEqual(sut.imageView.superview, sut.contentView)
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
