//
//  TestableComicsVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 23/07/24.
//

import Foundation
@testable import MarvelSample

/// A subclass of ComicsVM, Written to privent API call to fetch next page
/// function 'fetchNextPage' is called everytime when view controller asks last list view model
/// Use in:
/// 1. TestableFlowManager
/// 2. TabBarTests
/// 3. ComicVCTests
/// 4. ComicsVCSnapshotTests
class TestableComicsVM: ComicsVM {
    override func fetchNextPage() {
        // Do nothing
    }
}
