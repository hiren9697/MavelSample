//
//  WebServiceGenerateRequestTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Request method: GET or POST
/// 2. Host
/// 3. Relative path
/// 4. Query items
/// 5. Body
// MARK: - Test Class
final class APIRequestGeneratorTests: XCTestCase {

    var sut: APIRequestGenerator!
    
    override func setUp() {
        super.setUp()
        sut = APIRequestGenerator()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - 1. Request method
extension APIRequestGeneratorTests {
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
}

// MARK: - 2. Host
extension APIRequestGeneratorTests {
    func test_generateRequest_shouldHaveCorrectHost() {
        guard let request = generateRequest(requestType: .get) else {
            return
        }
        XCTAssertEqual(request.url?.host(), APIEndpoints.base.rawValue)
    }
}

// MARK: - 3. Relative Path
extension APIRequestGeneratorTests {
    func test_generateRequest_shouldHaveCorrectRelativePath() {
        let relativePath = APIEndpoints.characters
        guard let request = generateRequest(requestType: .get,
                                            relativePath: relativePath.rawValue) else {
            return
        }
        XCTAssertEqual(request.url?.relativePath, relativePath.rawValue)
    }
}

// MARK: - 4. Query Items
extension APIRequestGeneratorTests {
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

// MARK: - 5. Body
extension APIRequestGeneratorTests {
    
    func test_generateRequest_shouldHaveSuppliedBodyParameters() {
        let firstKey = "firstKey"
        let firstValue = "firstValue"
        let secondKey = "secondKey"
        let secondValue = "secondValue"
        let parameters: [String: String] = [firstKey: firstValue, secondKey: secondValue]
        guard let request = generateRequest(requestType: .get,
                                            parameters: parameters) else {
            return
        }
        guard let bodyParameters = getBodyParameters(request: request) else {
            return
        }
        XCTAssertEqual((bodyParameters[firstKey] as? String), firstValue)
        XCTAssertEqual((bodyParameters[secondKey] as? String), secondValue)
    }
}

// MARK: - Helper
extension APIRequestGeneratorTests {
    
    func generateRequest(requestType: RequestType,
                         relativePath: String = "",
                         headers: [String: String]? = nil,
                         queryParameters: [String: String]? = nil,
                         parameters: [String: String]? = nil,
                         line: UInt = #line) -> URLRequest? {
        do {
            return try sut
                .generateRequestWithHash(requestType: requestType,
                                         relativePath: relativePath,
                                         headers: headers,
                                         queryParameters: queryParameters,
                                         parameters: parameters)
        } catch {
            XCTFail("Precondition: GenerateRequest failed: \(error)", line: line)
            return nil
        }
    }
    
    func getQueryItems(request: URLRequest,
                       line: UInt = #line)-> [URLQueryItem]? {
        guard let url = request.url else {
            XCTFail("Precondition: Generated request has no URL", line: line)
            return nil
        }
        guard let components = NSURLComponents(string: url.absoluteString) else {
            XCTFail("Precondition: Can't access components from generated URL", line: line)
            return nil
        }
        guard let queryItems = components.queryItems else {
            XCTFail("Precondition: Can't access query items from generated URL", line: line)
            return nil
        }
        return queryItems
    }
    
    func getBodyParameters(request: URLRequest,
                           line: UInt = #line)-> [String: Any]? {
        guard let httpBody = request.httpBody else {
            XCTFail("Precondition: Generated request has no body")
            return nil
        }
        do {
            let extractedParameters = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any]
            return extractedParameters
        } catch {
            XCTFail("Precondition: Failed to deserialize request body, Encountered error: \(error)")
            return nil
        }
    }
}
