//
//  ViewController.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeAPICall()
    }
}

extension ViewController {
    
    func makeAPICall() {
        let service = APIService()
        let request = try! service.getRequest(requestType: .get,
                                              headers: [:],
                           queryParameters: [:],
                           parameters: [:])
        URLSession
            .shared
            .dataTask(with: request) { data, response, error in
                if let error = error {
                    print("error: \(error)")
                }
                if let response = response as? HTTPURLResponse {
                    print("Status code: \(response.statusCode)")
                }
                if let data = data {
                    let json = try! JSONSerialization.jsonObject(with: data)
                    print("json: \(json)")
                }
            }.resume()
    }
}

