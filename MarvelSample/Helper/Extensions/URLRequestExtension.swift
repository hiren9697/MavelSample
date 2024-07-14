//
//  URLRequestExtension.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import Foundation

extension URLRequest {
    var printDescription: String {
        return """
               URL: \(String(describing: self.url)),
               Type: \(String(describing: self.httpMethod))
               Body parameters: \(String(describing: self.httpBody?.prettyPrintedJSONString)),
               Headers: \(String(describing: self.allHTTPHeaderFields))
               """
    }
}
