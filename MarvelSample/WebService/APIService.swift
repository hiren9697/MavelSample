//
//  APIService.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation


class APIService: APIServiceProtocol {
    
    func dataTask(request: URLRequest,
                  completion: @escaping APICallHandler)-> URLSessionDataTask? {
        Log.apiRequest("request: \(request.printDescription)")
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
                if let textResponse = data.prettyPrintedJSONString {
                    Log.apiResponse(textResponse)
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(.success(json))
                } catch {
                    Log.error("Error in parsing JSON: \(error)")
                    completion(.failure(error))
                }
            }
    }
}
