//
//  FlowManager.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit

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
            guard !(window.rootViewController is TabBarController) else {
                return
            }
            let tabBarController = initializeTabBarController()
            let navigationController = UINavigationController(rootViewController: tabBarController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        } else {
            guard !(window.rootViewController is WalkthroughVC) else {
                return
            }
            let walkthroughVM = WalkthroughVM()
            let walkthroughVC = WalkthroughVC(viewModel: walkthroughVM)
            window.rootViewController = walkthroughVC
        }
    }
    
    func initializeTabBarController()-> TabBarController {
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
        let comicsVC = ComicsVC(viewModel: ComicsVM())
        let charactersVC = CharactersVC(viewModel: CharactersVM())
        let eventsVC = EventsVC(viewModel: EventsVM())
        let viewControllers = [comicsVC, charactersVC, eventsVC]
        // Initialize TabBar
        let tabBarVM = TabBarVM(tabBarItemVMs: tabBarItemVMs)
        return TabBarController(viewModel: tabBarVM,
                                viewControllers: viewControllers)
    }
}
