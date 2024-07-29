//
//  URLSessionSpy.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 28/07/24.
//

import Foundation
@testable import MarvelSample

/// This class is used to spy class used to mimick URLSession behaviour
/// It stores URLRequest in array called 'dataTaskArgsRequest' and clauser in array named 'completionArgs'
class URLSessionSpy: URLSessionProtocol {
    var dataTaskArgsRequest: [URLRequest] = []
    var completionArgs: [MarvelSample.URLSessionCompletionHandler] = []
    var dataTaskCallCount: Int {
        return dataTaskArgsRequest.count
    }
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping MarvelSample.URLSessionCompletionHandler) -> URLSessionDataTask {
        dataTaskArgsRequest.append(request)
        completionArgs.append(completionHandler)
        return URLSession.shared.dataTask(with: request)
    }
}
