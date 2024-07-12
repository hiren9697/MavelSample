//
//  SceneDelegate.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Log.info("SCENE DELEGATE: Launching from production")
        guard let windoScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windoScene)
        setInitialScreen()
    }
}

// MARK: - Helper
extension SceneDelegate {
    
    private func setInitialScreen() {
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenWalkthrough) {
            let tabBarController = TabBarController()
            window?.rootViewController = tabBarController
        } else {
            let walkthroughVM = WalkthroughVM()
            let walkthroughVC = WalkthroughVC(viewModel: walkthroughVM)
            window?.rootViewController = walkthroughVC
        }
        window?.makeKeyAndVisible()
    }
}

