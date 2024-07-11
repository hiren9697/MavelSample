//
//  WalkthroughVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 10/07/24.
//

import XCTest
@testable import MarvelSample

final class WalkthroughVCTests: XCTestCase {

    var sut: WalkthroughVC!
    var viewModel: WalkthroughVM!
    
    override func setUp() {
        super.setUp()
        viewModel = WalkthroughVM()
        sut = WalkthroughVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Test Cases
extension WalkthroughVCTests {
    
    func test_collectionViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView.delegate, "collectionView Delegate")
        XCTAssertNotNil(sut.collectionView.dataSource, "collectionView Datasource")
    }
    
    func test_numberOfRows_shouldBeCorrect() {
        XCTAssertEqual(numberOfRows(in: sut.collectionView),
                       viewModel.items.count)
    }
    
    func test_cellForRow_shouldDequeu_correctTypeOfCells() {
        let firstCell = cellForRow(in: sut.collectionView, row: 0)
        let secondCell = cellForRow(in: sut.collectionView, row: 1)
        let lastCell = cellForRow(in: sut.collectionView, row: viewModel.items.lastIndex)
        XCTAssertTrue(firstCell is WalkthroughCC)
        XCTAssertTrue(secondCell is WalkthroughCC)
        XCTAssertTrue(lastCell is WalkthroughCC)
    }
    
    func test_cellForRow_with0_shouldUpdateUIComponentsCorrect() {
        let firstCell = cellForRow(in: sut.collectionView, row: 0) as? WalkthroughCC
        XCTAssertNotNil(firstCell, "Precondition")
        XCTAssertEqual(firstCell!.textLabel.text, viewModel.items.first?.text, "text label")
        XCTAssertEqual(firstCell!.backgroundImageView.image, UIImage(named: viewModel.items.first?.imageName ?? ""), "background image")
        
    }
    
    func test_cellForRow_with1_shouldUpdateUIComponentsCorrect() {
        let secondCell = cellForRow(in: sut.collectionView, row: 1) as? WalkthroughCC
        XCTAssertNotNil(secondCell, "Precondition")
        XCTAssertEqual(secondCell!.textLabel.text,
                       viewModel.items[1].text,
                       "text label")
        XCTAssertEqual(secondCell!.backgroundImageView.image,
                       UIImage(named: viewModel.items[1].imageName),
                       "background image")
        
    }
    
    func test_cellForRow_withLast_shouldUpdateUIComponentsCorrect() {
        let secondCell = cellForRow(in: sut.collectionView, row: viewModel.items.lastIndex) as? WalkthroughCC
        XCTAssertNotNil(secondCell, "Precondition")
        XCTAssertEqual(secondCell!.textLabel.text,
                       viewModel.items.last?.text,
                       "text label")
        XCTAssertEqual(secondCell!.backgroundImageView.image,
                       UIImage(named: viewModel.items.last?.imageName ?? ""),
                       "background image")
        
    }
}
