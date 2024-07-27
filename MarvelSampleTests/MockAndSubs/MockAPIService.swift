//
//  MockAPIServic.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation
import XCTest
@testable import MarvelSample

/// This class is used to mock API calling behaviour
/// It stores URLRequest in array called 'dataTaskArgsRequest' and clauser in array named 'completionArgs'
class MockAPIService: APIServiceProtocol {
    
    var dataTaskArgsRequest: [URLRequest] = []
    var completionArgs: [MarvelSample.APICallHandler] = []
    var dataTaskCallCount: Int {
        return dataTaskArgsRequest.count
    }
    let requestGenerator: APIRequestGenerator
    
    init(requestGenerator: APIRequestGenerator) {
        self.requestGenerator = requestGenerator
    }
    
    func dataTask(request: URLRequest, completion: @escaping MarvelSample.APICallHandler) -> URLSessionDataTask? {
        dataTaskArgsRequest.append(request)
        completionArgs.append(completion)
        return URLSession.shared.dataTask(with: request)
    }
}

// MARK: - Helper
extension MockAPIService {
    
    /// Compares count of dataTaskArgsRequest, It fais if count != 1
    /// - Parameters:
    ///   - file: File from which this method is called
    ///   - line: Line from which this method is called
    /// - Returns: True if only one request call was made, false otherwise
    func dataTaskWasCalledOnce(file: StaticString, line: UInt)-> Bool {
        verifyMethodCalledOnce(method: "dataTask(with:completionHandler",
                               callCount: dataTaskCallCount,
                               describedArguments: "request: \(dataTaskArgsRequest)",
                               file: file,
                               line: line)
    }
    
    /// This method compares given request is identical to last request added in dataTaskArgsRequest
    /// This method compares request's url, http method, http header, http body
    /// - Parameters:
    ///   - request: URLRequest which need to be compared with last request of dataTaskArgsRequest
    ///   - file: File from which this method called
    ///   - line: Line number from which this method called
    func verifyDataTask(with request: URLRequest,
                        file: StaticString,
                        line: UInt) {
        guard dataTaskWasCalledOnce(file: file,
                                    line: line) else {
            return
        }
        guard let dataTaskArgsRequest = dataTaskArgsRequest.last else {
            XCTFail("Precondition: dataTaskArgs is empty, Should have atleast one request",
                    file: file,
                    line: line)
            return
        }
        // 1. URL
        guard let dataTaskArgsNormalizedURL = dataTaskArgsRequest.url?.normalized() else {
            XCTFail("Couldn't generate normalized url from request in dataTaskArgsRequest",
                    file: file,
                    line: line)
            return
        }
        guard let givenRequestNormalizedURL = request.url?.normalized() else {
            XCTFail("Couldn't generate normalized url from given request",
                    file: file,
                    line: line)
            return
        }
        guard dataTaskArgsNormalizedURL == givenRequestNormalizedURL else {
            XCTFail("URLs doens't match",
                    file: file,
                    line: line)
            return
        }
        // 2. Compare HTTP methods
        guard dataTaskArgsRequest.httpMethod == request.httpMethod else {
            XCTFail("HTTP methods doesn't match",
                    file: file,
                    line: line)
            return
        }
        // 3. Compare HTTP headers
        let dataTaskArgsRequestHeader = dataTaskArgsRequest.allHTTPHeaderFields ?? [:]
        let givenRequestHeader = request.allHTTPHeaderFields ?? [:]
        guard dataTaskArgsRequestHeader == givenRequestHeader else {
            XCTFail("HTTP headers doens't match",
                    file: file,
                    line: line)
            return
        }
        // 4. Compare HTTP body
        let dataTaskArgsRequestBody = dataTaskArgsRequest.httpBody
        let givenRequestBody = request.httpBody
        guard dataTaskArgsRequestBody == givenRequestBody else {
            XCTFail("HTTP body doens't match",
                    file: file,
                    line: line)
            return
        }
    }
}
