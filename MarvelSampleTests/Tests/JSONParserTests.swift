//
//  JSONParserTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/08/24.
//

import XCTest
@testable import MarvelSample

final class JSONParserTests: XCTestCase {

    var sut: JSONParser!
    
    override func setUp() {
        super.setUp()
        sut = JSONParser()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension JSONParserTests {
    
    func test_parseJSON_withNonDictionaryJSON_shouldReturnNil() {
        guard let json = loadJSON(fileName: "NonDictionary") else {
            XCTFail("Found JSON nil")
            return
        }
        let result = sut.parseListJSON(json)
        XCTAssertNil(result)
    }
    
    func test_parseJSON_withErrorJSON_shouldReturnNil() {
        guard let json = loadJSON(fileName: "Error") else {
            XCTFail("Found JSON nil")
            return
        }
        let result = sut.parseListJSON(json)
        XCTAssertNil(result)
    }
    
    func test_parseJSON_withJSONWithoutDataKey_shouldResturnNil() {
        guard let json = loadJSON(fileName: "WithoutDataKey") else {
            XCTFail("Found JSON nil")
            return
        }
        let result = sut.parseListJSON(json)
        XCTAssertNil(result)
    }
    
    func test_parseJSON_withJSONWithoutResultKey_shouldReturnNil() {
        guard let json = loadJSON(fileName: "WithoutResultKey") else {
            XCTFail("Found JSON nil")
            return
        }
        let result = sut.parseListJSON(json)
        XCTAssertNil(result)
    }
    
    func test_parseJSON_withEmptyResponse_shouldReturnEmptyResult() {
        guard let json = loadJSON(fileName: "EmptyList") else {
            XCTFail("Found JSON nil")
            return
        }
        let result = sut.parseListJSON(json)
        XCTAssertEqual(result, Array<NSDictionary>())
    }
    
    func test_parseJSON_withSuccessResponse_shouldReturnNonEmptyResult() {
        guard let json = loadJSON(fileName: "ComicsListSuccess") else {
            XCTFail("Found JSON nil")
            return
        }
        let result = sut.parseListJSON(json)
        XCTAssertNotNil(result, "Precondition")
        XCTAssertTrue(result!.count > 0)
    }
}
