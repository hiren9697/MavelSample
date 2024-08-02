//
//  TestableData.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import Foundation

/// A dummy data class used to fill space
/// Used in TestableBaseCollectionVc, TestableDataItemVM, TestableAPIDataListable, TestableBaseLisVM...
class TestableData {
    let id: String = UUID().uuidString
    let text: String
    let description: String
    
    init(text: String, description: String) {
        self.text = text
        self.description = description
    }
}
