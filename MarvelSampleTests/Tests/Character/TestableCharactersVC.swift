//
//  TestableCharactersVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import UIKit
@testable import MarvelSample

/// A subclass of CharactersVC written to prevent API call automatically when view loads
/// This class is used in unit tests whereever a CharactersVC expected
/// If we uses actual CharactersVC, actual API call will be called every-time a object of CharactersVC created
class TestableCharactersVC: CharactersVC {
    
    override func fetchInitialData() {
        // Do nothing
    }
}

