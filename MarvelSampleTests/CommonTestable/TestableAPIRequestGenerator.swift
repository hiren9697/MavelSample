//
//  TestableAPIRequestGenerator.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 27/07/24.
//

import Foundation
@testable import MarvelSample

/// This class created to solve hash differnce issue
/// In unit test when we compare two requests, due to different timestamp used in both requests, they don't match
/// So to solve that issue object of this class uses single timestamp date for every request generated through that object
/// Variable 'staticTimestampDate' is used every time to generate hash instead of timestamp received from method parameter
class TestableAPIRequestGenerator: APIRequestGenerator {
    
    /// Passed everytime to generate request, instead of timestamp received from method parameter
    lazy var staticTimestampDate: Date = Date()
    
    override func generateRequestWithHash(requestType: RequestType,
                                          relativePath: String,
                                          headers: [String : String]? = nil,
                                          queryParameters: [String : String]? = nil,
                                          parameters: [String : String]? = nil,
                                          timestampDate: Date = Date()) throws -> URLRequest {
        try super.generateRequestWithHash(requestType: requestType,
                                          relativePath: relativePath,
                                          headers: headers,
                                          queryParameters: queryParameters,
                                          parameters: parameters,
                                          timestampDate: staticTimestampDate)
    }
}
