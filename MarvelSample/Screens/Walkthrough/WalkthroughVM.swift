//
//  WalkthroughVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit
import Combine

class WalkthroughVM {
    
    let items: [WalkthroughItemVM] = [
        WalkthroughItemVM(imageName: "first", text: "Sample app with Marvel's open APIs"),
        WalkthroughItemVM(imageName: "second", text: "Sample app with unit tests implemented"),
        WalkthroughItemVM(imageName: "third", text: "Sample app with CI / CD implemented"),
        WalkthroughItemVM(imageName: "fourth", text: "Sample app with MVVM"),
        WalkthroughItemVM(imageName: "fifth", text: ""),
        WalkthroughItemVM(imageName: "sixth", text: ""),
    ]
    
    var currentPage: CurrentValueSubject<Int, Never> = CurrentValueSubject(0)
    var buttonTitle: String {
        Log.info("Button title, currnetPage: \(currentPage)")
        if currentPage.value == items.count - 1 {
            return "Let's Start"
        } else {
            return "Continue"
        }
    }
    
    init() {
        Log.create("Initialized: \(String(describing: self))")
    }
    
    deinit {
        Log.destroy("Deinitialized: \(String(describing: self))")
    }
}

// MARK: - Helpers
extension WalkthroughVM {
    
    func goToNextPage() {
        func navigateToTabBar() {
            let tabBarVC = TabBarController()
            currentSceneWindow()?.rootViewController = tabBarVC
            // Save state
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSeenWalkthrough)
            UserDefaults.standard.synchronize()
        }
        
        guard currentPage.value < (items.count - 1) else {
            navigateToTabBar()
            return
        }
        currentPage.value += 1
    }
}
