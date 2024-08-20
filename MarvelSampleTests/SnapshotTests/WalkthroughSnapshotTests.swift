//
//  WalkthroughSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

final class WalkthroughSnapshotTests: XCTestCase {
    var sut: WalkthroughVC!
    var viewModel: WalkthroughVM!
    
    override func setUp() {
        super.setUp()
        viewModel = WalkthroughVM()
        sut = WalkthroughVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
        putInViewHeirarchy(sut)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension WalkthroughSnapshotTests {
    func test_withFirstPage() {
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_withFirstPage")
    }
    
    func test_withSecondPage() {
        // viewModel.currentPage.value = 1
        sut.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        sut.collectionView.layoutIfNeeded()
        executeRunLoop()
        assertSnapshot(matching: sut, as: .image, record: true, testName: "test_withSecondPage")
    }
    
    
}
