//
//  NetworkError.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case incorrectStatusCode
    case emptyData
}
