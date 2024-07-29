//
//  APIServiceTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 28/07/24.
//

import XCTest
@testable import MarvelSample

final class APIServiceTests: XCTestCase {

    var session: URLSessionSpy!
    var sut: APIService!
    
    override func setUp() {
        super.setUp()
        session = URLSessionSpy()
        sut = APIService(requestGenerator: APIRequestGenerator(),
                         session: session)
    }
}

// MARK: - Request Tests
extension APIServiceTests {
    
    func test_dataTask_makesOneRequestToSession() throws {
        let request = getRequest()
        _ = sut.dataTask(request: request) { _ in }
        XCTAssertEqual(session.dataTaskCallCount, 1)
    }
    
    func test_dataTask_makesCorrectRequestToSession() throws {
        let request = getRequest()
        _ = sut.dataTask(request: request) { _ in }
        XCTAssertEqual(request, session.dataTaskArgsRequest.first)
    }
}

// MARK: - Response Tests
extension APIServiceTests {
    func test_dataTask_withError_shoudlCompleteWithSentError() {
        let request = getRequest()
        let expectation = expectation(description: "URLSessionCompletionHandler")
        _ = sut.dataTask(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTFail("Received success instead of failure")
            case.failure(let error):
                guard let dummyNetworkError = error as? DummyNetworkError else {
                    XCTFail("Received error is not as expected")
                    expectation.fulfill()
                    return
                }
                XCTAssertEqual(dummyNetworkError, .somethingWentWrong)
            }
            expectation.fulfill()
        })
        session.completionArgs.first?(nil, nil, DummyNetworkError.somethingWentWrong)
        // session.completionArgs.first?(nil, nil, NetworkError.emptyData)
        waitForExpectations(timeout: 0.01)
    }
    
    func test_dataTask_withNilURLResponse_shouldCompleteWithNetworkErrorInvalidResponse() {
        let request = getRequest()
        let expectation = expectation(description: "URLSessionCompletionHandler")
        _ = sut.dataTask(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTFail("Received success instead of failure")
            case.failure(let error):
                guard let networkError = error as? NetworkError else {
                    XCTFail("Received error is not as expected")
                    expectation.fulfill()
                    return
                }
                XCTAssertEqual(networkError, .invalidResponse)
            }
            expectation.fulfill()
        })
        session.completionArgs.first?(nil, nil, NetworkError.invalidResponse)
        // session.completionArgs.first?(nil, nil, NetworkError.emptyData)
        waitForExpectations(timeout: 0.01)
    }
    
    func test_dataTask_withInvalidStatusCodeResponse_shouldCompleteWithNetworkErrorIncorrectStatus() {
        let request = getRequest()
        let expectation = expectation(description: "URLSessionCompletionHandler")
        _ = sut.dataTask(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTFail("Received success instead of failure")
            case.failure(let error):
                guard let networkError = error as? NetworkError else {
                    XCTFail("Received error is not as expected")
                    expectation.fulfill()
                    return
                }
                XCTAssertEqual(networkError, .incorrectStatusCode)
            }
            expectation.fulfill()
        })
        session.completionArgs.first?(Data(), failureURLResponse(), nil)
        // session.completionArgs.first?(nil, nil, NetworkError.emptyData)
        waitForExpectations(timeout: 0.01)
    }
    
    func test_dataTask_withNilDataResponse_shouldCompleteWithNetworkErrorEmptyData() {
        let request = getRequest()
        let expectation = expectation(description: "URLSessionCompletionHandler")
        _ = sut.dataTask(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTFail("Received success instead of failure")
            case.failure(let error):
                guard let networkError = error as? NetworkError else {
                    XCTFail("Received error is not as expected")
                    expectation.fulfill()
                    return
                }
                XCTAssertEqual(networkError, .emptyData)
            }
            expectation.fulfill()
        })
        session.completionArgs.first?(nil, successURLResponse(), nil)
        waitForExpectations(timeout: 0.01)
    }
    
    func test_dataTask_withSuccessResponse_shouldCompleteWithSuccess() {
        guard let successJSONData = getDataOfSuccessJSON() else {
            return
        }
        let request = getRequest()
        let expectation = expectation(description: "URLSessionCompletionHandler")
        _ = sut.dataTask(request: request, completion: { result in
            switch result {
            case .success(_):
                // Do nothing, as expected
                break
            case.failure(let error):
                XCTFail("Expected success, but received filure with error: \(error)")
            }
            expectation.fulfill()
        })
        session.completionArgs.first?(successJSONData, successURLResponse(), nil)
        waitForExpectations(timeout: 0.01)
    }
}

// MARK: - Helper
extension APIServiceTests {
    
    private func getRequest()-> URLRequest {
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        return request
    }
    
    private func failureURLResponse()-> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://www.google.com")!,
                        statusCode: 300,
                        httpVersion: nil,
                        headerFields: nil)
    }
    
    private func successURLResponse()-> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://www.google.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil)
    }
    
    private func getDataOfSuccessJSON() -> Data? {
        guard let json = loadJSON(fileName: "ComicsListSuccess") else {
            XCTFail("Coulcn't get ComicsListSuccess JSON")
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: json) else {
            XCTFail("Couldn't Serialize ComicsListSuccess JSON")
            return nil
        }
        return data
    }
}
