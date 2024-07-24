//
//  TestableFlowManager.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 24/07/24.
//

import UIKit
@testable import MarvelSample

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
        let charactersVC = CharactersVC()
        let eventsVC = EventsVC()
        let viewControllers = [comicsVC, charactersVC, eventsVC]
        // Initialize TabBar
        let tabBarVM = TabBarVM(tabBarItemVMs: tabBarItemVMs)
        return TabBarController(viewModel: tabBarVM,
                                viewControllers: viewControllers)
    }
}
