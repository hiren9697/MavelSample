//
//  APIRequestGenerator.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 26/07/24.
//

import Foundation

class APIRequestGenerator {
    
    /// Generates URLRequest with given components
    /// - Parameters:
    ///   - requestType: HTTP method type
    ///   - relativePath: Endpoint of request
    ///   - headers: HTTP headers
    ///   - queryParameters: Query parameters of URL
    ///   - parameters: HTTP body parameters
    ///   - timestampDate: Timestamp to be used to generate hash, Most use of this method in production code doesn't pass timestamp,
    ///   But unit test uses this frequently, To compare two requests unit test methos passes same time stamp in requests
    /// - Returns: URLRequest
    func generateRequestWithHash(requestType: RequestType,
                                 relativePath: String,
                                 headers: [String: String]? = nil,
                                 queryParameters: [String: String]? = nil,
                                 parameters: [String: String]? = nil,
                                 timestampDate: Date = Date()) throws -> URLRequest {
        // 1. Generate hash
        let timeStamp = "\(timestampDate.timeIntervalSince1970)"
        let hash = (timeStamp + Keys.privateKey + Keys.publicKey).md5
        // 2. Generate url request
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEndpoints.base.rawValue
        components.path = relativePath
        var queryParamsList: [URLQueryItem] = [
            URLQueryItem(name: APIParameterName.apiKey, value: Keys.publicKey),
            URLQueryItem(name: APIParameterName.timeStamp, value: timeStamp),
            URLQueryItem(name: APIParameterName.hash, value: hash)
        ]
        if let queryParameters = queryParameters,
           !queryParameters.isEmpty {
            queryParamsList.append(contentsOf: queryParameters.map { URLQueryItem(name: $0, value: $1) })
        }
        components.queryItems = queryParamsList
        guard let url = components.url else { throw  NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        if let headers = headers,
           !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters,
           !parameters.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }
        return urlRequest
    }
}
