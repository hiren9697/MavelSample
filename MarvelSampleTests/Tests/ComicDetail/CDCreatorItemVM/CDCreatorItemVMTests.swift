//
//  CDCreatorItemVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Parse model correctly
/// 2. Extracts title and thumbnail correctly from model
final class CDCreatorItemVMTests: XCTestCase {
    var sut: TestableCDCreatorItemVM!
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        sut = TestableCDCreatorItemVM()
    }
}

// MARK: - Tests
extension CDCreatorItemVMTests {
    func test_parseModel_withCorrectJSON_returnsCorrectCharactor() {
        guard let jsonDictionary = getJSONDictionary(line: #line) else {
            return
        }
        guard let creator = sut.parseModel(from: jsonDictionary) else {
            XCTFail("parseModel returned nil character")
            return
        }
        XCTAssertEqual(creator.fullName, "Jim Nausedas", "fullName is incorrect")
        XCTAssertEqual(creator.id, "10021", "id is incorrect")
        XCTAssertEqual(creator.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg", "thumbnailURLString is incorrect")
    }
    
    func test_fetchTitleAndThumbnail_returnsCorrectData() {
        guard let creator = getCreator(line: #line) else {
            return
        }
        let tuple = sut.fetchTitleAndThumbnail(from: creator)
        XCTAssertEqual(tuple?.thumbnail, creator.thumbnailURL, "thumbnail is incorrect")
        XCTAssertEqual(tuple?.title, creator.fullName, "title is incorrect")
    }
}

// MARK: - Helper
extension CDCreatorItemVMTests {
    private func getJSONDictionary(line: UInt)-> NSDictionary? {
        guard let json = loadJSON(fileName: "SingleCreator") else {
            XCTFail("Precondition: Found JSON nil", line: line)
            return nil
        }
        guard let dictionary = json as? NSDictionary else {
            XCTFail("Incorrect JSON", line: line)
            return nil
        }
        return dictionary
    }
    
    private func getCreator(line: UInt)-> Creator? {
        guard let json = getJSONDictionary(line: line) else {
            XCTFail("Precondition: returned nil JSON", line: line)
            return nil
        }
        guard let creator = Creator(dict: json) else {
            XCTFail("Precondition: error in parsing Creator")
            return nil
        }
        return creator
    }
}
