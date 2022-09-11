//
//  SceneDelegate.swift
//  zzinmunication
//
//  Created by itzel.du on 2022/09/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene)
    else { return }

    UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")

    window = UIWindow(windowScene: windowScene)

    let mainViewController = MainViewController()
    let navigationViewController = UINavigationController(rootViewController: mainViewController)

    window?.rootViewController = navigationViewController
    window?.makeKeyAndVisible()
  }
}

