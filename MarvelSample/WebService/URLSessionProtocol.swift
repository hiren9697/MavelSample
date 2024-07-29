//
//  URLSessionProtocol.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 28/07/24.
//

import Foundation

typealias URLSessionCompletionHandler = @Sendable (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping URLSessionCompletionHandler) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

