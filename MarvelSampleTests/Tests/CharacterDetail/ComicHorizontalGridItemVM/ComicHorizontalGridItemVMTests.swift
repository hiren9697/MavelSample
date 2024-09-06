//
//  ComicHorizontalGridItemVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/09/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Parse model correctly
/// 2. Extracts title and thumbnail correctly from model
final class ComicHorizontalGridItemVMTests: XCTestCase {
    var sut: TestableComicHorizontalGridItemVM!
    
    override func setUp() {
        super.setUp()
        sut = TestableComicHorizontalGridItemVM()
    }
}

// MARK: - Tests
extension ComicHorizontalGridItemVMTests {
    func test_parseModel_withCorrectJSON_returnsCorrectCharactor() {
        guard let jsonDictionary = getJSONDictionary(line: #line) else {
            return
        }
        guard let series = sut.parseModel(from: jsonDictionary) else {
            XCTFail("parseModel returned nil comic")
            return
        }
        XCTAssertEqual(series.title, "Avengers: The Initiative (2007) #17", "title is incorrect")
        XCTAssertEqual(series.id, "21975", "id is incorrect")
        XCTAssertEqual(series.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/b/a0/58dd03dc2ec00.jpg", "thumbnailURLString is incorrect")
    }
    
    func test_fetchTitleAndThumbnail_returnsCorrectData() {
        guard let comic = getComic(line: #line) else {
            return
        }
        let tuple = sut.fetchTitleAndThumbnail(from: comic)
        XCTAssertEqual(tuple?.thumbnail, comic.thumbnailURL, "thumbnail is incorrect")
        XCTAssertEqual(tuple?.title, comic.title, "title is incorrect")
    }
}

// MARK: - Helper
extension ComicHorizontalGridItemVMTests {
    private func getJSONDictionary(line: UInt)-> NSDictionary? {
        guard let json = loadJSON(fileName: "SingleComic") else {
            XCTFail("Precondition: Found JSON nil", line: line)
            return nil
        }
        guard let dictionary = json as? NSDictionary else {
            XCTFail("Incorrect JSON", line: line)
            return nil
        }
        return dictionary
    }
    
    private func getComic(line: UInt)-> Comic? {
        guard let json = getJSONDictionary(line: line) else {
            XCTFail("Precondition: returned nil JSON", line: line)
            return nil
        }
        guard let creator = Comic(dict: json) else {
            XCTFail("Precondition: error in parsing Creator")
            return nil
        }
        return creator
    }
}
