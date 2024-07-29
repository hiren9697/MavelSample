//
//  Constants.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

class App {
    static let application    = UIApplication.shared
    static let appDelegator   = UIApplication.shared.delegate! as! AppDelegate
    static var flowManager: FlowManager?
}

struct UserDefaultKeys {
    static let hasSeenWalkthrough = "hasSeenWalkthrough"
}

struct Geometry {
    static let screenFrame     : CGRect     = UIScreen.main.bounds
    static let screenSize      : CGSize     = UIScreen.main.bounds.size
    static let screenWidth     : CGFloat    = screenSize.width
    static let screenHeight    : CGFloat    = screenSize.height
    static let windowScene     : UIWindowScene?   = App.application.connectedScenes.first as? UIWindowScene
    static let window          : UIWindow?  = windowScene?.windows.last
    static let topSafearea     : CGFloat    = window?.safeAreaInsets.top ?? 0
    static let bottomSafearea  : CGFloat    = window?.safeAreaInsets.bottom ?? 0
    static let statusbarHeight : CGFloat    = topSafearea
}
