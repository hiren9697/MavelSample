//
//  TestableEventsVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import Foundation
@testable import MarvelSample

/// A subclass of EventsVM, Written to privent API call to fetch next page
/// function 'fetchNextPage' is called everytime when view controller asks last list view model
class TestableEventsVM: EventsVM {
    
    override func fetchNextPage() {
        // Do nothing
    }
}
