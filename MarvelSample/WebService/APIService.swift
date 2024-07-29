//
//  APIService.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import Foundation

class APIService: APIServiceProtocol {
    let requestGenerator: APIRequestGenerator
    let session: URLSessionProtocol
    
    init(requestGenerator: APIRequestGenerator,
         session: URLSessionProtocol = URLSession.shared) {
        self.requestGenerator = requestGenerator
        self.session = session
    }
    
    func dataTask(request: URLRequest,
                  completion: @escaping APICallHandler)-> URLSessionDataTask? {
        @Sendable func logErrorJSON(data: Data?) {
            guard let data = data else {
                return
            }
            let message = """
                          API ERROR JSON:
                          URL: \(String(describing: request.url?.absoluteString)),
                          JSON: \(String(describing: data.prettyPrintedJSONString))
                          """
            Log.error(message)
        }
        
        Log.apiRequest("request: \(request.printDescription)")
        return session
            .dataTask(with: request) { data, response, error in
                if let error = error {
                    Log.error("Error in API call: \(error)")
                    logErrorJSON(data: data)
                    completion(.failure(error))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    Log.error("Couldn't receive HTTPURLResponse")
                    logErrorJSON(data: data)
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                guard response.statusCode == 200 else {
                    Log.error("Invalid status code in API response: \(response.statusCode)")
                    logErrorJSON(data: data)
                    completion(.failure(NetworkError.incorrectStatusCode))
                    return
                }
                guard let data = data else {
                    Log.error("Received empty data from API response")
                    logErrorJSON(data: data)
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
