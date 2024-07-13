//
//  TestableUserDefaults.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit
@testable import MarvelSample

class TestableUserDefaults: UserDefaultsProtocol {
    
    var values: [String: Any] = [:]
    
    func set(_ value: Bool, forKey defaultName: String) {
        values[defaultName]  = value
    }
    
    func bool(forKey defaultName: String) -> Bool {
        values[defaultName] as? Bool ?? false
    }
}
