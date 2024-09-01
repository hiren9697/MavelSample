//
//  TestableData.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import Foundation
@testable import MarvelSample

/// A dummy data class used to fill space
/// Used in:
/// 1. TestableBaseCollectionVc
/// 2. TestableDataItemVM
/// 3. TestableAPIDataListable
/// 4. TestableBaseLisVM...
class TestableData {
    let id: String
    let text: String
    
    init(text: String) {
        self.id = UUID().uuidString
        self.text = text
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary.getStringValue(key: "id")
        text = dictionary.getStringValue(key: "text")
    }
}
