//
//  ViewController.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    let service: APIServiceProtocol = APIService()
    var dataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeAPICall()
    }
}

extension ViewController {
   
    func makeAPICall() {
        let request = try! service.generateRequest(requestType: .get,
                                                   relativePath: APIEndpoints.characters.rawValue)
        dataTask = service.dataTask(request: request,
                                        completion: { result in
            switch result {
            case .success(let json):
                Log.info("Received json: \(json)")
            case .failure(let error):
                Log.info("Received error in API call: \(error)")
            }
        })
        dataTask?.resume()
    }
    
}
