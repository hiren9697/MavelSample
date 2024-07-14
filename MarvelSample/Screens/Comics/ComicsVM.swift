//
//  ComicsVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit

class ComicsVM {
    let service = APIService()
    var fetchComicsTask: URLSessionDataTask?
    
}

// MARK: - API
extension ComicsVM {
    
    func fetchComics() {
        do {
            let request = try service.generateRequest(requestType: .get,
                                                  relativePath: APIEndpoints.comics.rawValue)
            fetchComicsTask = service.dataTask(request: request) { result in
                switch result {
                case .success(let json):
                    let a = 10
                case .failure(let error):
                    Log.error("Encountered Error in data task: \(error)")
                }
            }
            fetchComicsTask?.resume()
        } catch {
            Log.error("Encountered error in generating request: \(error)")
        }
        
    }
}
