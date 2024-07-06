//
//  MockAPIServic.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation
@testable import MarvelSample

class MockAPIService: APIServiceProtocol {
    
    var dataTaskArgsRequest: [URLRequest] = []
    var completionArgs: [MarvelSample.APICallHandler] = []
    var dataTaskCallCount: Int {
        return dataTaskArgsRequest.count
    }
    
    func dataTask(request: URLRequest, completion: @escaping MarvelSample.APICallHandler) -> URLSessionDataTask? {
        dataTaskArgsRequest.append(request)
        completionArgs.append(completion)
        return URLSession.shared.dataTask(with: request)
    }
}
