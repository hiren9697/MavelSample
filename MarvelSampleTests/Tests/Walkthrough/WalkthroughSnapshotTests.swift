//
//  WalkthroughSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Tests:
/// 1. Walkthrough screen with single item and various length of text
/// NOTE: method 'setup()' not initializing SUT, test methods need to call appropriate method before asserting
final class WalkthroughSnapshotTests: XCTestCase {
    var sut: WalkthroughVC!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension WalkthroughSnapshotTests {
    func test_withEmptyText() {
        setupWithEmptyTextInViewModel()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_withEmptyText")
    }
    
    func test_withNoramalLengthText() {
        setupWithNormalLengthTextInViewModel()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_withNormalLengthText")
    }
    
    func test_withLongLengthText() {
        setupWithLongLengthTextInViewModel()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_withLongLengthText")
    }
    
    func test_withExtraLongLengthText() {
        setupWithExtraLongLengthTextInViewModel()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_withExtraLongLengthText")
    }
}

// MARK: - Helper
extension WalkthroughSnapshotTests {
    func setupWithEmptyTextInViewModel() {
        let viewModel = WalkthroughVM(items: [WalkthroughItemVM(imageName: "first",
                                                            text: "")])
        sut = WalkthroughVC(viewModel: viewModel)
    }
    
    func setupWithNormalLengthTextInViewModel() {
        let viewModel = WalkthroughVM(items: [WalkthroughItemVM(imageName: "first",
                                                            text: "This is normal length text, Yes this is")])
        sut = WalkthroughVC(viewModel: viewModel)
    }
    
    func setupWithLongLengthTextInViewModel() {
        let viewModel = WalkthroughVM(items: [WalkthroughItemVM(imageName: "first",
                                                            text: "This is long length text, This is long length text, This is long length text, This is long length text, This is long length text,")])
        sut = WalkthroughVC(viewModel: viewModel)
    }
    
    func setupWithExtraLongLengthTextInViewModel() {
        let viewModel = WalkthroughVM(items: [WalkthroughItemVM(imageName: "first",
                                                            text: "This is long length text, This is long length text, This is long length text, This is long length text, This is long length text, This is long length text, This is long length text, This is long length text, This is long length text, This is long length text,")])
        sut = WalkthroughVC(viewModel: viewModel)
    }
}
