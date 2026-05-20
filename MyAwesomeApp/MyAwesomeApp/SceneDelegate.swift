//
//  SceneDelegate.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2026/05/12.
//  Copyright © 2012-present Moneytree. All rights reserved.
//

import MoneytreeLinkCoreKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = appDelegate.rootViewController
    window.makeKeyAndVisible()
    self.window = window
  }

  // MARK: - Moneytree LINK SDK: Scene-Based Deep Link Handling

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url,
          url.scheme?.starts(with: "mtlink") ?? false else { return }

    if let queryKey = url.query?.split(separator: "=").first,
       queryKey == MTWebRunActionKeyAction,
       let queryValue = url.query?.split(separator: "=").last {
      print("Detected user action: \(queryValue)")
      switch queryValue {
      case MTWebRunActionKeyActionRevokeApplication,
           MTWebRunActionKeyActionLogout,
           MTWebRunActionKeyActionDeleteAccount:
        print("User left from MyAccount.")
      default:
        break
      }
    }

    MTLApplicationDelegate.shared.scene(scene, openURLContexts: URLContexts)
  }

  // MARK: - Moneytree LINK SDK: Scene-Based Universal Link Handling

  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    guard userActivity.webpageURL?.host?.contains("getmoneytree.com") ?? false else { return }
    guard let rootVC = window?.rootViewController else { return }

    MTLApplicationDelegate.shared.scene(
      scene,
      continue: userActivity,
      presentFrom: rootVC
    ) { error in
      if let error {
        print(
          """
            Error handling universal link: \(String(describing: userActivity.webpageURL))
            Error: \(error)
          """
        )
      } else {
        print(
          """
            Successfully handled universal link: \(String(describing: userActivity.webpageURL))
          """
        )
      }
    }
  }
}
