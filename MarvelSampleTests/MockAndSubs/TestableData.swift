//
//  TestableData.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import Foundation

class TestableData {
    let id: String = UUID().uuidString
    let text: String
    
    init(text: String) {
        self.text = text
    }
}
