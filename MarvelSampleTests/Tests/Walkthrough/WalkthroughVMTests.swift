//
//  WalkthroughVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/07/24.
//

import XCTest
@testable import MarvelSample

final class WalkthroughVMTests: XCTestCase {
    
    var sut: WalkthroughVM!
    
    override func setUp() {
        super.setUp()
        sut = WalkthroughVM()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - TestCases
extension WalkthroughVMTests {
    
    func test_goToNextPage_withFirstPage_increaseCurrentPage() {
        XCTAssertEqual(sut.currentPage.value, 0, "precondition")
        sut.goToNextPage()
        XCTAssertEqual(sut.currentPage.value, 1)
    }
    
    func test_goToNextPage_withSeconPage_increaseCurrentPage() {
        sut.currentPage.value = 1
        sut.goToNextPage()
        XCTAssertEqual(sut.currentPage.value, 2)
    }
    
    func test_goToNextPage_withLastPage_doNotIncreaseCurrentPage() {
        sut.currentPage.value = sut.items.lastIndex
        sut.goToNextPage()
        XCTAssertEqual(sut.currentPage.value, sut.items.lastIndex)
    }
    
    func test_goToNextPage_withFirstPage_doNotChangeButtonTitle() {
        XCTAssertEqual(sut.buttonTitle, "Continue", "precondition")
        sut.goToNextPage()
        XCTAssertEqual(sut.buttonTitle, "Continue")
    }
    
    func test_goToNextPage_withSecondPage_doNotChangeButtonTitle() {
        XCTAssertEqual(sut.buttonTitle, "Continue", "precondition")
        sut.currentPage.value = 1
        sut.goToNextPage()
        XCTAssertEqual(sut.buttonTitle, "Continue")
    }
    
    func test_goToNextPage_withLastPage_shouldChangeButtonTitle() {
        XCTAssertEqual(sut.buttonTitle, "Continue", "precondition")
        sut.currentPage.value = sut.items.lastIndex - 1
        sut.goToNextPage()
        XCTAssertEqual(sut.buttonTitle, "Let's Start")
    }
}
