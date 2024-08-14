//
//  FlowManagerTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import XCTest
@testable import MarvelSample

final class FlowManagerTests: XCTestCase {

    var sut: TestableFlowManager!
    var window: UIWindow!
    var testableUserDefaults: FakeUserDefaults!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        testableUserDefaults = FakeUserDefaults()
        sut = TestableFlowManager(window: window,
                                  userDefaults: testableUserDefaults)
    }
    
    override func tearDown() {
        window = nil
        testableUserDefaults = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Test Cases
extension FlowManagerTests {
    
    func test_setSeenWalkthroug_shouldSaveToUserDefaults() {
        XCTAssertEqual(sut.hasSeenWalkthrough, false, "precondition")
        sut.setSeenWalkthrough()
        XCTAssertEqual(sut.hasSeenWalkthrough, true)
    }
    
    func test_setRootViewController_withoutSeenWalkthroug_shouldSetWalkthoughVCAsRoot() {
        XCTAssertNil(window.rootViewController, "precondition")
        sut.setRootViewController()
        guard let rootVC = window.rootViewController else {
            XCTFail("Found rootViewController nil")
            return
        }
        XCTAssertTrue(rootVC is WalkthroughVC, "rootViewController is not WalkthroughVC")
    }
    
    func test_setRootViewController_withSeenWalkthrough_shouldSetNavigationControllerWithTabBarControllerAsRoot() {
        XCTAssertNil(window.rootViewController, "precondition")
        sut.setSeenWalkthrough()
        sut.setRootViewController()
        guard let navigationController = window.rootViewController as? UINavigationController else {
            XCTFail("Window's rootViewController is not UINavigationController")
            return
        }
        XCTAssertTrue(navigationController.viewControllers.first is TabBarController, "navigationController's rootViewController is not TabBarController")
    }
    
    func test_setRootViewController_withWalkthroughAsRoot_settingWalkthroughSeen_shouldSetNavigationControllerWithTabBarControllerAsRoot() {
        sut.setRootViewController()
        XCTAssertTrue(window.rootViewController is WalkthroughVC, "precondition")
        sut.setSeenWalkthrough()
        sut.setRootViewController()
        guard let navigationController = window.rootViewController as? UINavigationController else {
            XCTFail("Window's rootViewController is not UINavigationController")
            return
        }
        XCTAssertTrue(navigationController.viewControllers.first is TabBarController, "navigationController's rootViewController is not TabBarController")
    }
    
    func test_setRootViewController_withWalkthroughAsRoot_withoutSeenWalkthrough_shouldNotChangeRoot() {
        let walkthroughVC = WalkthroughVC(viewModel: WalkthroughVM())
        window.rootViewController = walkthroughVC
        sut.setRootViewController()
        XCTAssertTrue(walkthroughVC === window.rootViewController, "rootViewController is changed")
    }
    
    func test_setRootViewController_withTabBarControllerAsRoot_withSeenWalkthrough_shouldNotChangeRoot() {
        let tabBarController = sut.initializeTabBarController()
        window.rootViewController = tabBarController
        sut.setSeenWalkthrough()
        sut.setRootViewController()
        XCTAssertTrue(tabBarController === window.rootViewController, "rootViewController is changed")
    }
}
