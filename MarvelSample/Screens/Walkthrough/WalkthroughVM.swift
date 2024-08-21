//
//  WalkthroughVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit
import Combine

/// ViewModel for walkthrough screen
class WalkthroughVM {
    let items: [WalkthroughItemVM]
    var currentPage: CurrentValueSubject<Int, Never> = CurrentValueSubject(0)
    var buttonTitle: String {
        Log.info("Button title, currnetPage: \(currentPage)")
        if currentPage.value == items.count - 1 {
            return "Let's Start"
        } else {
            return "Continue"
        }
    }
    
    /// Q. Why am I initializing items through initializer intstead of implicit assignment?
    /// A. Because I am using this initializer in snapshot tesitng, to test UI behaviour with various texts
    /// - Parameter items: WalkthroughItemVM to be displayed horizontally in walkthrough
    init(items: [WalkthroughItemVM] = [
        WalkthroughItemVM(imageName: "first", text: "Sample app with Marvel's open APIs"),
        WalkthroughItemVM(imageName: "second", text: "Sample app with unit tests implemented"),
        WalkthroughItemVM(imageName: "third", text: "Sample app with CI / CD implemented"),
        WalkthroughItemVM(imageName: "fourth", text: "Sample app with MVVM"),
        WalkthroughItemVM(imageName: "fifth", text: ""),
        WalkthroughItemVM(imageName: "sixth", text: ""),
    ]) {
        self.items = items
        Log.create("Initialized: \(String(describing: self))")
    }
    
    deinit {
        Log.destroy("Deinitialized: \(String(describing: self))")
    }
}

// MARK: - Helpers
extension WalkthroughVM {
    func goToNextPage() {
        
        guard currentPage.value < (items.count - 1) else {
            App.flowManager?.setSeenWalkthrough()
            App.flowManager?.setRootViewController()
            return
        }
        currentPage.value += 1
    }
}
