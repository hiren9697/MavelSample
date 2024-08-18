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
    var sut: TestableEventsVC!
    var viewModel: TestableEventsVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableEventsVM()
        sut = TestableEventsVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
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

// MARK: - Helper
extension EventsVCTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            EventItemVM(event: Event(title: "Zeroth event title", description: "Zeroth event description")!),
            EventItemVM(event: Event(title: "First event title", description: "First event description")!),
            EventItemVM(event: Event(title: "Second event title", description: "Second event description")!),
            EventItemVM(event: Event(title: "Third event title", description: "Third event description")!),
            ]
    }
}
