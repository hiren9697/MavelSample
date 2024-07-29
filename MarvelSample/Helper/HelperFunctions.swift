//
//  HelperFunctions.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

func currentSceneWindow()-> UIWindow? {
    guard let currentScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) else {
        return nil
    }
    guard let sceneDelegate = currentScene.delegate as? SceneDelegate else {
        return nil
    }
    return sceneDelegate.window
}

func gauranteeMainThread(_ work: @escaping ()-> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async(execute: work)
    }
}
