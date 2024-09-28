//
//  TabBarSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 21/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

/// Tests:
/// 1. TabBarController initialized from FlowManager
/// NOTE: It doens't make much sense to perform snapshot test on tab bar controller, because I already have performed unit tests around tab bar controller and flow manager
/// But I am keeping this test because I am facing issue of unselected tab icnos showing while in snapshot images, I tried many ways to fix but I am not able to,
/// So I am keeping this test because I would like to solve this issue or know about this behaviour in future
final class TabBarSnapshotTests: XCTestCase {
    var sut: TabBarController!
    
    override func setUp() {
        super.setUp()
        let window = UIWindow()
        let flowManager = TestableFlowManager(window: window, userDefaults: UserDefaults.standard)
        sut = flowManager.initializeTabBarController()
        sut.loadViewIfNeeded()
        if let viewControllers = sut.viewControllers {
            for controllers in viewControllers {
                controllers.loadViewIfNeeded()
            }
        }
        putInViewHeirarchy(sut)
        executeRunLoop()
    }
    
    func test_tabBarController_withFirstTabSelected() {
        // No need to select first tab, as it is by default selected
        assertSnapshot(matching: sut,
                       as: .image,
                       named: "test_tabBarController_initializedFromFlowManagerAndWithFirstTabSelected",
                       record: SnapshotTestConfiguration.isRecordingEnabled)
    }
    
    func test_tabBarController_withSecondTabSelected() {
        sut.selectedIndex = 1
        assertSnapshot(matching: sut,
                       as: .image,
                       named: "test_tabBarController_initializedFromFlowManagerAndWithSecondTabSelected",
                       record: SnapshotTestConfiguration.isRecordingEnabled)
    }
    
    func test_tabBarController_withThirdTabSelected() {
        sut.selectedIndex = 2
        assertSnapshot(matching: sut,
                       as: .image, named: "test_tabBarController_initializedFromFlowManagerAndWithThirdTabSelected",
                       record: SnapshotTestConfiguration.isRecordingEnabled)
    }
}
