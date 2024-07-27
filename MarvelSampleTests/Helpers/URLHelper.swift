//
//  URLHelper.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 27/07/24.
//

import Foundation

import Foundation

extension URL {
    func normalized() -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        // Extract and sort the query items
        if let queryItems = components.queryItems {
            components.queryItems = queryItems.sorted(by: { $0.name < $1.name })
        }
        
        // Create a new URL from the components
        return components.url
    }
}

func areURLsEquivalent(_ url1: URL, _ url2: URL) -> Bool {
    // Normalize both URLs
    guard let normalizedURL1 = url1.normalized(),
          let normalizedURL2 = url2.normalized() else {
        return false
    }
    
    // Compare the normalized URLs
    return normalizedURL1 == normalizedURL2
}

func areRequestsEquivalent(_ request1: URLRequest, _ request2: URLRequest) -> Bool {
    // Compare URLs after normalizing
    guard let url1 = request1.url?.normalized(),
          let url2 = request2.url?.normalized(),
          url1 == url2 else {
        return false
    }
    
    // Compare HTTP methods
    guard request1.httpMethod == request2.httpMethod else {
        return false
    }
    
    // Compare HTTP headers
    let headers1 = request1.allHTTPHeaderFields ?? [:]
    let headers2 = request2.allHTTPHeaderFields ?? [:]
    guard headers1 == headers2 else {
        return false
    }
    
    // Compare HTTP body
    let body1 = request1.httpBody
    let body2 = request2.httpBody
    guard body1 == body2 else {
        return false
    }
    
    return true
}


// Example usage
//let urlString1 = "https://example.com/path?b=2&a=1"
//let urlString2 = "https://example.com/path?a=1&b=2"
//
//if let url1 = URL(string: urlString1),
//   let url2 = URL(string: urlString2) {
//    let areEquivalent = areURLsEquivalent(url1, url2)
//    print("URLs are equivalent: \(areEquivalent)")
//} else {
//    print("Invalid URLs")
//}

