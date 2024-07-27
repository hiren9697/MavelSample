//
//  TestableComicsVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 23/07/24.
//

import UIKit
@testable import MarvelSample

/// A subclass of ComicsVC written to prevent API call automatically when view loads
/// This class is used in unit tests whereever a ComicsVC expected
/// If we uses actual ComicsVC, actual API call will be called every-time a object of ComicsVC created
class TestableComicsVC: ComicsVC {
    
    override func fetchInitialData() {
        // Do nothing
    }
}
