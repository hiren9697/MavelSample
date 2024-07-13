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
        guard let window = self.window else { return }
        App.flowManager = FlowManager(window: window,
                                      userDefaults: UserDefaults.standard)
        App.flowManager?.setRootViewController()
    }
}

