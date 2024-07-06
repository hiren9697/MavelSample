//
//  APIService.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation

typealias APICallHandler = (Result<Any, Error>) -> Void

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
    
    func dataTask(request: URLRequest,
                  completion: @escaping APICallHandler)-> URLSessionDataTask? {
        return URLSession
            .shared
            .dataTask(with: request) { data, response, error in
                if let error = error {
                    Log.error("Error in API call: \(error)")
                    completion(.failure(error))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    Log.error("Couldn't receive HTTPURLResponse")
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                guard response.statusCode == 200 else {
                    Log.error("Invalid status code in API response: \(response.statusCode)")
                    completion(.failure(NetworkError.incorrectStatusCode))
                    return
                }
                guard let data = data else {
                    Log.error("Received empty data from API response")
                    completion(.failure(NetworkError.emptyData))
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(.success(json))
                } catch {
                    Log.error("Error in parsing JSON: \(error)")
                    completion(.failure(error))
                }
            }
    }
}
