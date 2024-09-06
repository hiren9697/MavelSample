//
//  SeriesHorizontalGridItemVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/09/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Parse model correctly
/// 2. Extracts title and thumbnail correctly from model
final class SeriesHorizontalGridItemVMTests: XCTestCase {
    var sut: TestableSeriesHorizontalGridItemVM!
    
    override func setUp() {
        super.setUp()
        sut = TestableSeriesHorizontalGridItemVM()
    }
}

// MARK: - Tests
extension SeriesHorizontalGridItemVMTests {
    func test_parseModel_withCorrectJSON_returnsCorrectCharactor() {
        guard let jsonDictionary = getJSONDictionary(line: #line) else {
            return
        }
        guard let series = sut.parseModel(from: jsonDictionary) else {
            XCTFail("parseModel returned nil series")
            return
        }
        XCTAssertEqual(series.title, "Scarlet Witch (1994)", "title is incorrect")
        XCTAssertEqual(series.id, "20338", "id is incorrect")
        XCTAssertEqual(series.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/5/c0/57d170a70fd01.jpg", "thumbnailURLString is incorrect")
    }
    
    func test_fetchTitleAndThumbnail_returnsCorrectData() {
        guard let series = getSeries(line: #line) else {
            return
        }
        let tuple = sut.fetchTitleAndThumbnail(from: series)
        XCTAssertEqual(tuple?.thumbnail, series.thumbnailURL, "thumbnail is incorrect")
        XCTAssertEqual(tuple?.title, series.title, "title is incorrect")
    }
}

// MARK: - Helper
extension SeriesHorizontalGridItemVMTests {
    private func getJSONDictionary(line: UInt)-> NSDictionary? {
        guard let json = loadJSON(fileName: "SingleSeries") else {
            XCTFail("Precondition: Found JSON nil", line: line)
            return nil
        }
        guard let dictionary = json as? NSDictionary else {
            XCTFail("Incorrect JSON", line: line)
            return nil
        }
        return dictionary
    }
    
    private func getSeries(line: UInt)-> Series? {
        guard let json = getJSONDictionary(line: line) else {
            XCTFail("Precondition: returned nil JSON", line: line)
            return nil
        }
        guard let creator = Series(dict: json) else {
            XCTFail("Precondition: error in parsing Creator")
            return nil
        }
        return creator
    }
}
