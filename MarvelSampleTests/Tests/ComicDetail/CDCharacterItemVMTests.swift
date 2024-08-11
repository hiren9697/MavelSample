//
//  CDCharacterItemVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import XCTest
@testable import MarvelSample

final class CDCharacterItemVMTests: XCTestCase {

    var sut: TestableCDCharacterItemVM!
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        sut = TestableCDCharacterItemVM()
    }
}

// MARK: - Tests
extension CDCharacterItemVMTests {
    func test_parseModel_withCorrectJSON_returnsCorrectCharactor() {
        guard let firstCharacterJSON = getFirstCharacterJSON(line: #line) else {
            return
        }
        guard let character = sut.parseModel(from: firstCharacterJSON) else {
            XCTFail("parseModel returned nil character")
            return
        }
        XCTAssertEqual(character.name, "3-D Man", "name is incorrect")
        XCTAssertEqual(character.id, "1011334", "id is incorrect")
        XCTAssertEqual(character.thumbnailURLString, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", "thumbnailURLString is incorrect")
        XCTAssertEqual(character.modifiedDateText, "Apr 29, 2014", "modifiedDateText is incorrect")
    }
    
    func test_fetchTitleAndThumbnail_returnsCorrectData() {
        guard let character = getCharacter(line: #line) else {
            return
        }
        let tuple = sut.fetchTitleAndThumbnail(from: character)
        XCTAssertEqual(tuple?.thumbnail, character.thumbnailURL, "thumbnail is incorrect")
        XCTAssertEqual(tuple?.title, character.name, "title is incorrect")
    }
}

// MARK: - Helper
extension CDCharacterItemVMTests {
    private func getFirstCharacterJSON(line: UInt)-> NSDictionary? {
        guard let json = loadJSON(fileName: "CharactersListSuccess") else {
            XCTFail("Precondition: Found JSON nil", line: line)
            return nil
        }
        guard let items = JSONParser().parseListJSON(json) else {
            XCTFail("Precondition: Incorrect JSON", line: line)
            return nil
        }
        guard let firstItem = items.first else {
            XCTFail("Precondition: Empty JSON", line: line)
            return nil
        }
        return firstItem
    }
    
    private func getCharacter(line: UInt)-> Character? {
        guard let firstCharacterJOSN = getFirstCharacterJSON(line: line) else {
            XCTFail("Precondition: returned nil JSON for first character", line: line)
            return nil
        }
        guard let character = Character(dict: firstCharacterJOSN) else {
            XCTFail("Precondition: error in parsing Character")
            return nil
        }
        return character
    }
}
