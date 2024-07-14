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
            let tabBarController = TabBarController(viewModel: TabBarVM())
            window.rootViewController = tabBarController
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
}
