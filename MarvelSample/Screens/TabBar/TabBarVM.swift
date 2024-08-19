//
//  TabBarVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit

/// ViewModel for TabBarController
struct TabBarVM {
    let tabBarItemVMs: [TabBarItemVM]
    
    init(tabBarItemVMs: [TabBarItemVM]) {
        self.tabBarItemVMs = tabBarItemVMs
    }
}
