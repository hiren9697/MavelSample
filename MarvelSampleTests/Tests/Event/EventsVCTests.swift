//
//  EventsVCTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Dequeues correct type of cell
/// 2. Updates / fills correct data to collectionView cell
final class EventsVCTests: XCTestCase {
    var navigationController: UINavigationController!
    var sut: TestableEventsVC!
    var viewModel: TestableEventsVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableEventsVM()
        sut = TestableEventsVC(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        navigationController = nil
        super.tearDown()
    }
}

// MARK: - CollectionView Cell
extension EventsVCTests {
    func test_cellForRow_withFilledData_dequesCorrectTypeOfCell() {
        addListItemsWithIdleModeInViewModel()
        let zerothCell = cellForRow(in: sut.tableView, row: 0)
        XCTAssertTrue(zerothCell is EventItemTC, "zerothCell is not EventItemTC")
        let firstCell = cellForRow(in: sut.tableView, row: 1)
        XCTAssertTrue(firstCell is EventItemTC, "firstCell is not EventItemTC")
        let lastCell = cellForRow(in: sut.tableView, row: viewModel.listItems.value.count - 1)
        XCTAssertTrue(lastCell is EventItemTC, "lastCell is not EventItemTC")
    }
    
    func test_cellForRow_withFilledData_updatesUIIfCell() {
        addListItemsWithIdleModeInViewModel()
        guard let zerothCell = cellForRow(in: sut.tableView, row: 0) as? EventItemTC else {
            XCTFail("Dequed zeroth cell is not EventItemTC")
            return
        }
        XCTAssertEqual(zerothCell.titleLabel.text, "Zeroth event title")
        XCTAssertEqual(zerothCell.descriptionLabel.text, "Zeroth event description")
        guard let firstCell = cellForRow(in: sut.tableView, row: 1) as? EventItemTC else {
            XCTFail("Dequed first cell is not EventItemTC")
            return
        }
        XCTAssertEqual(firstCell.titleLabel.text, "First event title")
        XCTAssertEqual(firstCell.descriptionLabel.text, "First event description")
        guard let lastCell = cellForRow(in: sut.tableView, row: viewModel.listItems.value.lastIndex) as? EventItemTC else {
            XCTFail("Dequed last cell is not EventItemTC")
            return
        }
        XCTAssertEqual(lastCell.titleLabel.text, "Third event title")
        XCTAssertEqual(lastCell.descriptionLabel.text, "Third event description")
    }
}

// MARK: - Item selection
extension EventsVCTests {
    func test_itemSelection_withIdleState_navigatesToEventDetail() {
        // Arrange
        addListItemsWithIdleModeInViewModel()
        // Act
        checkFirstVCInNavigationStackIsEventsVC()
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        executeRunLoop()
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 2, "After selecting item, There should be 2 viewControllers in navigation stack")
        XCTAssertTrue(navigationController.viewControllers.first is EventsVC, "First VC in navigation stack should be EventsVC")
        XCTAssertTrue(navigationController.viewControllers[1] is EventDetailVC, "Second VC in navigation stack should be EventDetailVC")
    }
    
    func test_afterItemSelection_addedEventDetail_shouldHaveCorrectViewModel() {
        // Arrange
        addListItemsWithIdleModeInViewModel()
        // Act
        checkFirstVCInNavigationStackIsEventsVC()
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        executeRunLoop()
        // Assert
        guard let eventDetailVC = navigationController.viewControllers.last as? EventDetailVC else {
            XCTFail("last view controller in navigation controller is not EventDetailVC")
            return
        }
        let eventDetailVM = eventDetailVC.viewModel
        let event = viewModel.data.first!
        XCTAssertEqual(eventDetailVM.title, event.title, "Event title is incorrect")
        XCTAssertEqual(eventDetailVM.thumbnailURL, event.thumbnailURL, "Thumbnail URL is incorrect")
        XCTAssertEqual(eventDetailVM.characterIDs, event.characterIDs, "Character IDs are incorrect")
        XCTAssertEqual(eventDetailVM.creatorIDs, event.creatorIDs, "Creator IDs are incorrect")
        XCTAssertEqual(eventDetailVM.comicIDs, event.comicIDs, "Comics IDs are incorrect")
    }
}

// MARK: - Helper
extension EventsVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.data = [
            Event(title: "Zeroth event title", description: "Zeroth event description")!,
            Event(title: "First event title", description: "First event description")!,
            Event(title: "Second event title", description: "Second event description")!,
            Event(title: "Third event title", description: "Third event description")!
        ]
        viewModel.listItems.value = viewModel.data.map { EventItemVM(event: $0) }
    }
    
    private func checkFirstVCInNavigationStackIsEventsVC() {
        XCTAssertEqual(navigationController.viewControllers.count, 1, "Precondition")
        XCTAssertTrue(navigationController.viewControllers.first is EventsVC, "Precondition")
    }
}
