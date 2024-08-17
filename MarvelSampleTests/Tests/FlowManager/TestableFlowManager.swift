//
//  TestableFlowManager.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 24/07/24.
//

import UIKit
@testable import MarvelSample

/// Sub-class of FlowManager which uses testable sub-classes of view controller and view models instead of production classes
/// Production classes makes API call on loading view of view controller, which we don't want to happen in testing
class TestableFlowManager: FlowManager {
    
    override func initializeComicsVC() -> ComicsVC {
        TestableComicsVC(viewModel: TestableComicsVM())
    }
    
    override func initializeCharactersVC() -> CharactersVC {
        TestableCharactersVC(viewModel: TestableCharactersVM())
    }
    
    override func initializeEventsVC() -> EventsVC {
        TestableEventsVC(viewModel: TestableEventsVM())
    }
}
