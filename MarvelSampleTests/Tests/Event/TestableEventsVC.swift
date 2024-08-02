//
//  TestableEventsVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import Foundation
@testable import MarvelSample

/// A subclass of EventsVC written to prevent API call automatically when view loads
/// This class is used in unit tests whereever a EventsVC expected
/// If we uses actual EventsVC, actual API call will be called every-time a object of EventsVC created
class TestableEventsVC: EventsVC {
    
    override func fetchInitialData() {
        // Do nothing
    }
}
