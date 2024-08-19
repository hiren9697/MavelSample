//
//  FlowManagerTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Updating flag 'hasSeenWalkthrough'
/// 2. Set view hierarchy when app starts
/// 3. Updates flag 'hasSeenWalkthrough', and update view hierarchy
/// 4. Initializes TabBarController as expected
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

// MARK: - 1. Updating flag 'hasSeenWalkthrough'
extension FlowManagerTests {
    func test_setSeenWalkthroug_shouldSaveToUserDefaults() {
        XCTAssertEqual(sut.hasSeenWalkthrough, false, "precondition")
        sut.setSeenWalkthrough()
        XCTAssertEqual(sut.hasSeenWalkthrough, true)
    }
}

// MARK: - 2. Set view hierarchy when app starts
extension FlowManagerTests {
    func test_setRootViewController_withoutSeenWalkthroug_shouldSetWalkthoughVCAsRoot() {
        XCTAssertNil(window.rootViewController, "precondition")
        sut.setRootViewController()
        guard let rootVC = window.rootViewController else {
            XCTFail("Found rootViewController nil")
            return
        }
        XCTAssertTrue(rootVC is WalkthroughVC, "rootViewController is not WalkthroughVC")
    }
    
    func test_setRootViewController_withSeenWalkthrough_shouldSetTabBarControllerAsRoot() {
        XCTAssertNil(window.rootViewController, "precondition")
        sut.setSeenWalkthrough()
        sut.setRootViewController()
        XCTAssertTrue(window.rootViewController is TabBarController)
    }
}

// MARK: - 3. Updates flag 'hasSeenWalkthrough', and update view hierarchy
extension FlowManagerTests {
    func test_setRootViewController_withWalkthroughAsRoot_settingWalkthroughSeen_shouldSetTabBarControllerAsRoot() {
        sut.setRootViewController()
        XCTAssertTrue(window.rootViewController is WalkthroughVC, "precondition")
        sut.setSeenWalkthrough()
        sut.setRootViewController()
        XCTAssertTrue(window.rootViewController is TabBarController)
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

// MARK: - 4. Initializes TabBarController as expected
extension FlowManagerTests {
    func test_initializedTabBarController_shouldHaveThreeVCs() {
        let tabBarVC = sut.initializeTabBarController()
        XCTAssertEqual(tabBarVC.viewControllers?.count, 3, "Number of viewControler are wrong")
    }
    
    func test_initializedTabBar_shouldHaveNavigationControllerWithComicsVCAsFirstVC() {
        let vc = getViewControllerFromTabBar(at: 0)
        guard let navigationController = vc as? UINavigationController else {
            XCTFail("first VC is not UINavigationController")
            return
        }
        XCTAssertTrue(navigationController.viewControllers.first is ComicsVC)
    }
    
    func test_initializedTabBar_shouldHaveNavigationControllerWithCharactersVCAsSecondVC() {
        let vc = getViewControllerFromTabBar(at: 1)
        guard let navigationController = vc as? UINavigationController else {
            XCTFail("second VC is not UINavigationController")
            return
        }
        XCTAssertTrue(navigationController.viewControllers.first is CharactersVC)
    }
    
    func test_initializedTabBar_shouldHaveNavigationControllerWithEventsVCAsThirdVC() {
        let vc = getViewControllerFromTabBar(at: 2)
        guard let navigationController = vc as? UINavigationController else {
            XCTFail("third VC is not UINavigationController")
            return
        }
        XCTAssertTrue(navigationController.viewControllers.first is EventsVC)
    }
    
    func test_initializedTabBarVM_shouldHaveFirstVMWithComicsProperties() {
        let viewModel = getTabBarVM()
        let firstTabBarItemVM = viewModel.tabBarItemVMs.first
        XCTAssertEqual(firstTabBarItemVM?.title, "Comics", "title is incorrect")
        XCTAssertEqual(firstTabBarItemVM?.image, UIImage(systemName: "book"), "image is incorrect")
        XCTAssertEqual(firstTabBarItemVM?.selectedImage, UIImage(systemName: "book.fill"), "selectedImage is incorrect")
    }
    
    func test_initializedTabBarVM_shouldHaveSecondVMWithCharactersProperties() {
        let viewModel = getTabBarVM()
        let secondTabBarItemVM = viewModel.tabBarItemVMs[1]
        XCTAssertEqual(secondTabBarItemVM.title, "Characters", "title is incorrect")
        XCTAssertEqual(secondTabBarItemVM.image, UIImage(systemName: "person"), "image is incorrect")
        XCTAssertEqual(secondTabBarItemVM.selectedImage, UIImage(systemName: "person.fill"), "selectedImage is incorrect")
    }
    
    func test_initializedTabBarVM_shouldHaveThirdVMWithEventsProperties() {
        let viewModel = getTabBarVM()
        let secondTabBarItemVM = viewModel.tabBarItemVMs[2]
        XCTAssertEqual(secondTabBarItemVM.title, "Events", "title is incorrect")
        XCTAssertEqual(secondTabBarItemVM.image, UIImage(systemName: "person.3.sequence"), "image is incorrect")
        XCTAssertEqual(secondTabBarItemVM.selectedImage, UIImage(systemName: "person.3.sequence.fill"), "selectedImage is incorrect")
    }
}

// MARK: - Helper
extension FlowManagerTests {
    func getViewControllerFromTabBar(at index: Int)-> UIViewController? {
        let tabBarVC = sut.initializeTabBarController()
        return tabBarVC.viewControllers?[index]
    }
    
    func getTabBarVM()-> TabBarVM {
        let tabBarVC = sut.initializeTabBarController()
        return tabBarVC.viewModel
    }
}
