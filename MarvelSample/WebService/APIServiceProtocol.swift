//
//  APIServiceProtocol.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation

typealias APICallHandler = (Result<Any, Error>) -> Void

protocol APIServiceProtocol {
    var requestGenerator: APIRequestGenerator { get }
    func dataTask(request: URLRequest,
                  completion: @escaping APICallHandler)-> URLSessionDataTask?
}

