//
//  UserDefaultProtocol.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit

protocol UserDefaultsProtocol {
    func set(_ value: Bool, forKey defaultName: String)
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: UserDefaultsProtocol {
    
}
