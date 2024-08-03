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
    override func initializeTabBarController()-> TabBarController {
        // Initialize TabBar Item ViewModels
        let tabBarItemVMs = [
            TabBarItemVM(title: "Comics",
                         image: UIImage(systemName: "book")!,
                         selectedImage: UIImage(systemName: "book.fill")!),
            TabBarItemVM(title: "Characters",
                         image: UIImage(systemName: "person")!,
                         selectedImage: UIImage(systemName: "person.fill")!),
            TabBarItemVM(title: "Events",
                         image: UIImage(systemName: "person.3.sequence")!,
                         selectedImage: UIImage(systemName: "person.3.sequence.fill")!),
        ]
        // Initialize ViewControllers
        let comicsVC = TestableComicsVC(viewModel: TestableComicsVM())
        let charactersVC = TestableCharactersVC(viewModel: TestableCharactersVM())
        let eventsVC = TestableEventsVC(viewModel: TestableEventsVM())
        let viewControllers = [comicsVC, charactersVC, eventsVC]
        // Initialize TabBar
        let tabBarVM = TabBarVM(tabBarItemVMs: tabBarItemVMs)
        return TabBarController(viewModel: tabBarVM,
                                viewControllers: viewControllers)
    }
}
