//
//  TestableCharactersVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import Foundation
@testable import MarvelSample

/// A subclass of CharactersVM, Written to privent API call to fetch next page
/// function 'fetchNextPage' is called everytime when view controller asks last list view model
/// Used in:
/// 1. TestableFlowManager
/// 2. TabBarTests
/// 3. CharactersVCTests
/// 4. CharactersVCSnapshotTests
class TestableCharactersVM: CharactersVM {
    override func fetchNextPage() {
        // Do nothing
    }
}
