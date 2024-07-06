//
//  APIService.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation

class APIService {
    
    func generateRequest(requestType: RequestType,
                         headers: [String: String],
                         queryParameters: [String: String],
                         parameters: [String: String]) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEndpoints.base.rawValue
        components.path = "/v1/public/characters"
        
        let timeStamp = "\(Date().timeIntervalSince1970)"
        
        let hash = (timeStamp + Keys.privateKey + Keys.publicKey).md5
        
        /// Add default query params
        var queryParamsList: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: Keys.publicKey),
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        if !queryParameters.isEmpty {
            queryParamsList.append(contentsOf: queryParameters.map { URLQueryItem(name: $0, value: $1) })
        }
        
        components.queryItems = queryParamsList
        
        guard let url = components.url else { throw  NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !parameters.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }
        
        //            Logger.networking.info("🚀 [REQUEST] [\(requestType.rawValue)] \(urlRequest, privacy: .private)")
        
        return urlRequest
    }
}
