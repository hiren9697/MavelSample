//
//  TabBarTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import XCTest
@testable import MarvelSample

final class TabBarTests: XCTestCase {

    var viewModel: TabBarVM!
    var sut: TabBarController!
    
    override func setUp() {
        super.setUp()
        setupThreeViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        sut = nil
    }
}

// MARK: - Setup Helper
extension TabBarTests {
    
    private func setupThreeViewController() {
        // TabBar Item VMs
        let tabBarItemVMs = [
            TabBarItemVM(title: "Comics",
                         image: UIImage(systemName: "book")!,
                         selectedImage: UIImage(systemName: "book.fill")!),
            TabBarItemVM(title: "Characters",
                         image: UIImage(systemName: "person")!,
                         selectedImage: UIImage(systemName: "person.fill")!),
            TabBarItemVM(title: "Events",
                         image: UIImage(systemName: "person.3.sequence")!,
                         selectedImage: UIImage(systemName: "person.3.sequence.fill")!)
        ]
        // ViewControllers
        let viewControllers: [UIViewController] = [
            TestableComicsVC(viewModel: TestableComicsVM()),
            CharactersVC(),
            EventsVC()
        ]
        // TabBar Controller
        viewModel = TabBarVM(tabBarItemVMs: tabBarItemVMs)
        sut = TabBarController(viewModel: viewModel,
                               viewControllers: viewControllers)
        sut.loadViewIfNeeded()
    }
}

// MARK: - Tests with Three ViewControllers
extension TabBarTests {
    
    func test_numberOfViewControllers() {
        guard let viewControllers = sut.viewControllers else {
            XCTFail("Precondition: Found viewControllers nil")
            return
        }
        XCTAssertEqual(sut.viewControllers!.count, viewModel.tabBarItemVMs.count)
    }
    
    func test_viewControllerSequence() {
        guard let viewControllers = sut.viewControllers else {
            XCTFail("Precondition: Found viewControllers nil")
            return
        }
        XCTAssertEqual(viewControllers, sut.arrViewController)
    }
    
    func test_firstViewController_tabInformation() {
        guard let viewControllers = sut.viewControllers else {
            XCTFail("Precondition: Found viewControllers nil")
            return
        }
        let vc = viewControllers.first!
        let tabBarItemVM = viewModel.tabBarItemVMs.first!
        compareTabItemInformation(viewController: vc,
                                  tabBarItemVM: tabBarItemVM)
    }
    
    func test_secondViewController_tabInformation() {
        guard let viewControllers = sut.viewControllers else {
            XCTFail("Precondition: Found viewControllers nil")
            return
        }
        let vc = viewControllers[1]
        let tabBarItemVM = viewModel.tabBarItemVMs[1]
        compareTabItemInformation(viewController: vc,
                                  tabBarItemVM: tabBarItemVM)
    }
    
    func test_thirdViewController_tabInformation() {
        guard let viewControllers = sut.viewControllers else {
            XCTFail("Precondition: Found viewControllers nil")
            return
        }
        let vc = viewControllers[2]
        let tabBarItemVM = viewModel.tabBarItemVMs[2]
        compareTabItemInformation(viewController: vc,
                                  tabBarItemVM: tabBarItemVM)
    }
}

// MARK: - Helper
extension TabBarTests {
    
    private func compareTabItemInformation(viewController vc: UIViewController,
                                           tabBarItemVM vm: TabBarItemVM) {
        XCTAssertEqual(vc.tabBarItem.title, vm.title)
        XCTAssertEqual(vc.tabBarItem.image, vm.image)
        XCTAssertEqual(vc.tabBarItem.selectedImage, vm.selectedImage)
    }
    
}
