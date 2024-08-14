//
//  CharacterVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import XCTest
@testable import MarvelSample

final class CharactersVMTests: XCTestCase {
    var sut: CharactersVM!
    var service: MockAPIService!
    
    override func setUp() {
        super.setUp()
        service = MockAPIService(requestGenerator: APIRequestGenerator())
        sut = CharactersVM(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
}

// MARK: - Test cases
extension CharactersVMTests {
    func test_parseJSON_withSuccessResponse_shouldSetExactNumberOfObject() {
        guard let json = loadJSON(fileName: "CharactersListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.data.count, 10, "Value in data array is not as expected")
        XCTAssertEqual(sut.listItems.value.count, 10, "Value in listItems not as expected")
    }
    
    func test_parseJSON_withSuccessResponse_firstDataObjectShouldHaveCorrectData() {
        guard let json = loadJSON(fileName: "CharactersListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        guard let firstData = sut.data.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.id, "1011334", "id")
        XCTAssertEqual(firstData.name, "3-D Man")
        XCTAssertEqual(firstData.modifiedDateText, "Apr 29, 2014", "modifiedDateText")
        XCTAssertEqual(firstData.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", "thumbnailURLString")
    }
    
    func test_parseJSON_withSuccessResponse_firstListItemVMObjectShouldHaveCorrectData() {
        guard let json = loadJSON(fileName: "CharactersListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        guard let firstData = sut.listItems.value.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.title, "3-D Man", "name")
        XCTAssertEqual(firstData.thumbnailURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"), "thumbnailURL")
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

