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
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension WalkthroughSnapshotTests {
    func test_sample() {
        // assertSnapshots(matching: <#T##Value#>, as: <#T##[String : Snapshotting<Value, Format>]#>)
    }
}
