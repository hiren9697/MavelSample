//
//  WebServiceGenerateRequestTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import XCTest
@testable import MarvelSample

final class WebServiceGenerateRequestTests: XCTestCase {

    var sut: APIService!
    
    override func setUp() {
        super.setUp()
        sut = APIService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - TestCases
extension WebServiceGenerateRequestTests {
   
    func test_generateRequest_withRequestTypeGet_shouldHaveGetMethod() {
        let type: RequestType = .get
        guard let request = generateRequest(requestType: type) else {
            return
        }
        XCTAssertEqual(request.httpMethod, type.rawValue)
    }
    
    func test_generateRequest_withRequestTypePost_shouldHavePostMethod() {
        let type: RequestType = .post
        guard let request = generateRequest(requestType: type) else {
            return
        }
        XCTAssertEqual(request.httpMethod, type.rawValue)
    }
    
    func test_generateRequest_shouldHaveCorrectHost() {
        guard let request = generateRequest(requestType: .get) else {
            return
        }
        XCTAssertEqual(request.url?.host(), APIEndpoints.base.rawValue)
    }
    
    func test_generateRequest_shouldHaveCorrectRelativePath() {
        let relativePath = APIEndpoints.characters
        guard let request = generateRequest(requestType: .get,
                                            relativePath: relativePath.rawValue) else {
            return
        }
        XCTAssertEqual(request.url?.relativePath, relativePath.rawValue)
    }
    
    func test_generateRequest_shouldHaveDefaultURLQueryItems() {
        guard let request = generateRequest(requestType: .get) else {
            return
        }
        guard let queryItems = getQueryItems(request: request,
                                             line: #line) else {
            return
        }
        guard let _ = queryItems.first(where: { $0.name == APIParameterName.apiKey }) else {
            XCTFail("Generated request doesn't contain apikey")
            return
        }
        guard let _ = queryItems.first(where: { $0.name == APIParameterName.timeStamp }) else {
            XCTFail("Generated request doesn't contain timeStamp")
            return
        }
        guard let _ = queryItems.first(where: { $0.name == APIParameterName.hash }) else {
            XCTFail("Generated request doesn't contain hash")
            return
        }
    }
    
    func test_generateRequest_shouldHaveSuppliedQueryItems() {
        let firstKey = "firstKey"
        let firstValue = "firstValue"
        let secondKey = "secondKey"
        let secondValue = "secondValue"
        let parameters: [String: String] = [firstKey: firstValue, secondKey: secondValue]
        guard let request = generateRequest(requestType: .get,
                                            queryParameters: parameters) else {
            return
        }
        guard let queryItems = getQueryItems(request: request) else {
            return
        }
        guard let firstQueryItem = queryItems.first(where: { $0.name == firstKey }),
              let secondQueryItem = queryItems.first(where: { $0.name == secondKey }),
              firstQueryItem.value == firstValue,
              secondQueryItem.value == secondValue else {
            XCTFail("Generated request doens't supplied additional query parameters")
            return
        }
    }
}

// MARK: - Helper
extension WebServiceGenerateRequestTests {
    
    func generateRequest(requestType: RequestType,
                         relativePath: String = "",
                         headers: [String: String]? = nil,
                         queryParameters: [String: String]? = nil,
                         parameters: [String: String]? = nil,
                         line: UInt = #line) -> URLRequest? {
        do {
            return try sut.generateRequest(requestType: requestType,
                                           relativePath: relativePath,
                                           headers: headers,
                                           queryParameters: queryParameters,
                                           parameters: parameters)
        } catch {
            XCTFail("GenerateRequest failed: \(error)", line: line)
            return nil
        }
    }
    
    func getQueryItems(request: URLRequest,
                       line: UInt = #line)-> [URLQueryItem]? {
        guard let url = request.url else {
            XCTFail("Generated request has no URL", line: line)
            return nil
        }
        guard let components = NSURLComponents(string: url.absoluteString) else {
            XCTFail("Can't access components from generated URL", line: line)
            return nil
        }
        guard let queryItems = components.queryItems else {
            XCTFail("Can't access query items from generated URL", line: line)
            return nil
        }
        return queryItems
    }
}
