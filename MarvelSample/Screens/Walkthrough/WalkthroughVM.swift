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
            return "Lets's Start"
        } else {
            return "Continue"
        }
    }
    // @Published var buttonTitle: String = "Continue"
    
    func goToNextPage() {
        guard currentPage.value < (items.count - 1) else {
            return
        }
        currentPage.value += 1
    }
    
//    func updateTitle() {
//        buttonTitle = currentPage < items.lastIndex ? "Continue" : "Let's Start"
//    }
}

extension Array {
    var lastIndex: Int {
        return count - 1
    }
}
