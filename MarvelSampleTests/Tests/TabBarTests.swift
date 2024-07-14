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
        viewModel = TabBarVM()
        sut = TabBarController(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        sut = nil
    }
}

// MARK: - Tests
extension TabBarTests {
    
    func test_numberOfViewControllers() {
        XCTAssertEqual(sut.viewControllers?.count, 3)
    }
    
    func test_sequenceOfViewControllers() {
        XCTAssertTrue(sut.viewControllers?.first is ComicsVC,
        "First ViewController should be ComicsVC")
        XCTAssertTrue(sut.viewControllers![1] is CharactersVC,
        "Second ViewController should be CharactersVC")
        XCTAssertTrue(sut.viewControllers![2] is EventsVC,
        "Third ViewController should be EventsVC")
    }
    
    func test_comicsTabItemInformation() {
        guard let firstVC = sut.viewControllers?.first else {
            XCTFail("First ViewController is nil")
            return
        }
        XCTAssertEqual(firstVC.tabBarItem.title,
                       viewModel.comicsTabItemVM.title,
                       "Title")
        XCTAssertEqual(firstVC.tabBarItem.image,
                       viewModel.comicsTabItemVM.image,
                       "Image")
        XCTAssertEqual(firstVC.tabBarItem.selectedImage,
                       viewModel.comicsTabItemVM.selectedImage,
                       "Selected Image")
    }
    
    func test_charactersTabItemInformation() {
        guard let secondVC = sut.viewControllers?[1] else {
            XCTFail("Second ViewController is nil")
            return
        }
        XCTAssertEqual(secondVC.tabBarItem.title,
                       viewModel.charactersTabItemVM.title,
                       "Title")
        XCTAssertEqual(secondVC.tabBarItem.image,
                       viewModel.charactersTabItemVM.image,
                       "Image")
        XCTAssertEqual(secondVC.tabBarItem.selectedImage,
                       viewModel.charactersTabItemVM.selectedImage,
                       "Selected Image")
    }
    
    func test_eventsTabItemInformation() {
        guard let thirdVC = sut.viewControllers?[2] else {
            XCTFail("Third ViewController is nil")
            return
        }
        XCTAssertEqual(thirdVC.tabBarItem.title,
                       viewModel.eventsTabItemVM.title,
                       "Title")
        XCTAssertEqual(thirdVC.tabBarItem.image,
                       viewModel.eventsTabItemVM.image,
                       "Image")
        XCTAssertEqual(thirdVC.tabBarItem.selectedImage,
                       viewModel.eventsTabItemVM.selectedImage,
                       "Selected Image")
    }
}
