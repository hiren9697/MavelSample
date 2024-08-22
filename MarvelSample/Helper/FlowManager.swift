//
//  FlowManager.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit

/// Helper class that used to set or update view hierarchy
/// Sets view hierarchy on app start and updates after seeing walkthrough screen
class FlowManager {
    private let window: UIWindow
    private let userDefaults: UserDefaultsProtocol
    var hasSeenWalkthrough: Bool {
        userDefaults.bool(forKey: UserDefaultKeys.hasSeenWalkthrough)
    }
    
    init(window: UIWindow, userDefaults: UserDefaultsProtocol) {
        self.window = window
        self.userDefaults = userDefaults
    }
    
    func setSeenWalkthrough() {
        userDefaults.set(true, forKey: UserDefaultKeys.hasSeenWalkthrough)
    }
    
    func setRootViewController() {
        if hasSeenWalkthrough {
           ///*
            guard !(window.rootViewController is TabBarController) else {
                return
            }
            let tabBarController = initializeTabBarController()
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            //*/
            //window.rootViewController = ComicDetailVC(viewModel: ComicDetailVM())
        } else {
            guard !(window.rootViewController is WalkthroughVC) else {
                return
            }
            let walkthroughVM = WalkthroughVM()
            let walkthroughVC = WalkthroughVC(viewModel: walkthroughVM)
            window.rootViewController = walkthroughVC
        }
    }
    
    func initializeComicsVC()-> ComicsVC {
        ComicsVC(viewModel: ComicsVM())
    }
    
    func initializeCharactersVC()-> CharactersVC {
        CharactersVC(viewModel: CharactersVM())
    }
    
    func initializeEventsVC()-> EventsVC {
        EventsVC(viewModel: EventsVM())
    }
    
    func initializeTabBarController()-> TabBarController {
        // Initialize TabBar Item ViewModels
        let tabBarItemVMs = [
            TabBarItemVM(title: "Comics",
                         image: UIImage(systemName: "book")!.withRenderingMode(.alwaysTemplate),
                         selectedImage: UIImage(systemName: "book.fill")!),
            TabBarItemVM(title: "Characters",
                         image: UIImage(systemName: "person")!,
                         selectedImage: UIImage(systemName: "person.fill")!),
            TabBarItemVM(title: "Events",
                         image: UIImage(systemName: "person.3.sequence")!,
                         selectedImage: UIImage(systemName: "person.3.sequence.fill")!),
        ]
        // Initialize ViewControllers
        let comicsVC = initializeComicsVC()
        let charactersVC = initializeCharactersVC()
        let eventsVC = initializeEventsVC()
        let comicsVCNavigationController = UINavigationController(rootViewController: comicsVC)
        let charactersVCNavigationController = UINavigationController(rootViewController: charactersVC)
        let eventsVCNavigationController = UINavigationController(rootViewController: eventsVC)
        let viewControllers = [comicsVCNavigationController, charactersVCNavigationController, eventsVCNavigationController]
        // Initialize TabBar
        let tabBarVM = TabBarVM(tabBarItemVMs: tabBarItemVMs)
        return TabBarController(viewModel: tabBarVM,
                                viewControllers: viewControllers)
    }
}
