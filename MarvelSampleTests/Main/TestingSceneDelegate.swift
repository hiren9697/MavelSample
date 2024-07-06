//
//  TestingSceneDelegate.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit
@testable import MarvelSample

class TestingSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Log.info("SCENE DELEGATE: Launching from testing")
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
}

