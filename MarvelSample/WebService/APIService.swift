//
//  APIService.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation

class APIService {
    
    func generateRequest(requestType: RequestType,
                         relativePath: String,
                         headers: [String: String]? = nil,
                         queryParameters: [String: String]? = nil,
                         parameters: [String: String]? = nil) throws -> URLRequest {
        // 1. Generate hash
        let timeStamp = "\(Date().timeIntervalSince1970)"
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
        Log.apiRequest("Request: \(requestType.rawValue): \(urlRequest)")
        return urlRequest
    }
}
