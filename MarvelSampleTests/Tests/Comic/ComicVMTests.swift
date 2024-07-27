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
        let successJSON = loadSuccessJSON()
        guard successJSON != nil else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(successJSON!))
        XCTAssertEqual(sut.data.count, 9, "Value in data array is not as expected")
        XCTAssertEqual(sut.listItems.value.count, 9, "Value in listItems not as expected")
    }
    
    func test_parseJSON_withSuccessResponse_firstDataObjectShouldHaveCorrectData() {
        guard let successJSON = loadSuccessJSON() else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(successJSON))
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
        guard let successJSON = loadSuccessJSON() else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(successJSON))
        guard let firstData = sut.listItems.value.first else {
            XCTFail("Precondition: First element of data is nil")
            return
        }
        XCTAssertEqual(firstData.title, "Marvel Previews (2017)", "title")
        XCTAssertEqual(firstData.thumbnailURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"), "thumbnailURL")
    }
    
    func test_parseJSON_withEmptyResponse_shouldHanldeEmptyData() {
        guard let successJSON = loadEmptyJSON() else {
            XCTFail("Found JSON nil")
            return
        }
        sut.fetchData()
        service.completionArgs.last?(.success(successJSON))
        XCTAssertEqual(sut.fetchState.value, .emptyData)
    }
}

// MARK: - Helper
extension ComicsVMTests {
    private func loadSuccessJSON()-> Any? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "ComicsListSuccess", ofType: "json") else {
            fatalError("ComicsListSuccess.json not found")
        }
        let url = URL(filePath: pathString)
        let data = try! Data(contentsOf: url)
        do {
            let anyObject = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
            return anyObject
        } catch {
            Log.error("Error in searlizing ComicsListSuccess JSON: \(error)")
            return nil
        }
    }
    
    private func loadErrorJSON()-> Any? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "ComicsListError", ofType: "json") else {
            fatalError("ComicsListError.json not found")
        }
        let url = URL(filePath: pathString)
        let data = try! Data(contentsOf: url)
        do {
            let anyObject = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
            return anyObject
        } catch {
            Log.error("Error in searlizing ComicsListError JSON: \(error)")
            return nil
        }
    }
    
    private func loadEmptyJSON()-> Any? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "ComicsListEmpty", ofType: "json") else {
            fatalError("ComicsListEmpty.json not found")
        }
        let url = URL(filePath: pathString)
        let data = try! Data(contentsOf: url)
        do {
            let anyObject = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
            return anyObject
        } catch {
            Log.error("Error in searlizing ComicsListEmpty JSON: \(error)")
            return nil
        }
    }
}
