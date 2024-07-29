//
//  ComicVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 27/07/24.
//

import XCTest
@testable import MarvelSample

final class ComicsVMTests: XCTestCase {

    var sut: ComicsVM!
    var service: MockAPIService!
    
    override func setUp() {
        super.setUp()
        service = MockAPIService(requestGenerator: APIRequestGenerator())
        sut = ComicsVM(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
}

// MARK: - Test cases
extension ComicsVMTests {
    func test_parseJSON_withSuccessResponse_shouldSetExactNumberOfObject() {
        guard let json = loadJSON(fileName: "ComicsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        XCTAssertEqual(sut.data.count, 9, "Value in data array is not as expected")
        XCTAssertEqual(sut.listItems.value.count, 9, "Value in listItems not as expected")
    }
    
    func test_parseJSON_withSuccessResponse_firstDataObjectShouldHaveCorrectData() {
        guard let json = loadJSON(fileName: "ComicsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        guard let firstData = sut.data.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.id, "82967", "id")
        XCTAssertEqual(firstData.title, "Marvel Previews (2017)", "title")
        XCTAssertEqual(firstData.descriptionText, "", "descriptionText")
        XCTAssertEqual(firstData.pages, 112, "pages")
        XCTAssertEqual(firstData.modifiedDateText, "Nov 7, 2019", "modifiedDateText")
        XCTAssertEqual(firstData.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg", "thumbnailURLString")
    }
    
    func test_parseJSON_withSuccessResponse_firstListItemVMObjectShouldHaveCorrectData() {
        guard let json = loadJSON(fileName: "ComicsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(json))
        guard let firstData = sut.listItems.value.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.title, "Marvel Previews (2017)", "title")
        XCTAssertEqual(firstData.thumbnailURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"), "thumbnailURL")
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
