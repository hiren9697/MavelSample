//
//  EventsVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 18/08/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Parses JSON in various kind of JSONs
class EventsVMTests: XCTestCase {
    var sut: EventsVM!
    var service: MockAPIService!
    
    override func setUp() {
        super.setUp()
        service = MockAPIService(requestGenerator: APIRequestGenerator())
        sut = EventsVM(service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        service = nil
    }
}

// MARK: - Test cases
extension EventsVMTests {
    func test_parseJSON_withSuccessResponse_shouldSetExactNumberOfObject() {
        guard let json = loadJSON(fileName: "EventsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.data.count, 10, "Value in data array is not as expected")
        XCTAssertEqual(sut.listItems.value.count, 10, "Value in listItems not as expected")
    }
    
    func test_parseJSON_withSuccessResponse_firstDataObjectShouldHaveCorrectData() {
        guard let json = loadJSON(fileName: "EventsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        guard let firstData = sut.data.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.id, "116", "id")
        XCTAssertEqual(firstData.title, "Acts of Vengeance!")
        XCTAssertEqual(firstData.modifiedDateText, "Jun 29, 2013", "modifiedDateText")
        XCTAssertEqual(firstData.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/9/40/51ca10d996b8b.jpg", "thumbnailURLString")
    }
    
    func test_parseJSON_withSuccessResponse_firstListItemVMObjectShouldHaveCorrectData() {
        guard let json = loadJSON(fileName: "EventsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        guard let firstData = sut.listItems.value.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.title, "Acts of Vengeance!", "title")
        XCTAssertEqual(firstData.thumbnailURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/40/51ca10d996b8b.jpg"), "thumbnailURL")
    }
    
    func test_parseJSON_withEmptyResponse_shouldHanldeEmptyData() {
        guard let json = loadJSON(fileName: "EmptyList") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.fetchState.value, .emptyData)
    }
    
    func test_parseJSON_withJSONWithoutResultKey_shouldHanldeEmptyData() {
        guard let json = loadJSON(fileName: "WithoutResultKey") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.fetchState.value, .emptyData)
    }
    
    func test_parseJSON_withJSONWithoutDataKey_shouldHanldeEmptyData() {
        guard let json = loadJSON(fileName: "WithoutDataKey") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.fetchState.value, .emptyData)
    }
    
    func test_parseJSON_withNonDictionaryJSON_shouldHanldeEmptyData() {
        guard let json = loadJSON(fileName: "NonDictionary") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.fetchState.value, .emptyData)
    }
}
