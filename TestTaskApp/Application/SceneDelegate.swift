//
//  SceneDelegate.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let tabBarVC = TabController()
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}

