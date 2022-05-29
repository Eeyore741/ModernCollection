//
//  SceneDelegate.swift
//  ExpandableCollection
//
//  Created by vitalii.kuznetsov on 2022-05-19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let applicationController: ApplicationController = ApplicationController()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.applicationController.startFromWindow(window)
        
        self.window = window
    }
}

