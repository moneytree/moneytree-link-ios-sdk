//
//  AppDelegate.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 15/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import CoreData
#if !(DEBUG)
import Firebase
#endif
import MoneytreeLinkCoreKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  @objc dynamic private(set) var deviceToken: Data?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    configureThirdPartyDependenciesIfPossible()

    let mtLinkClient = MTLinkClient(configuration: Constants.configuration)
    mtLinkClient.delegate = self

    UIApplication.shared.registerForRemoteNotifications()

    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate.
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    // Check if a given URL is for the SDK
    guard url.scheme?.starts(with: "mtlink") ?? false else {
      // You may consume a given URL if you have other schemes.
      return true
    }
    if url.absoluteString.contains(MTWebRunActionKeyAction),
       let queryKey = url.query?.split(separator: "=").first,
       queryKey == MTWebRunActionKeyAction,
       let queryValue = url.query?.split(separator: "=").last {
      print("Detected user action: \(queryValue)")
      switch queryValue {
      case MTWebRunActionKeyActionRevokeApplication, // When user revokes any connected apps
           MTWebRunActionKeyActionLogout, // When user gets logout from MyAccount website
           MTWebRunActionKeyActionDeleteAccount: // When user deletes Moneytree Account
        print("User left from MyAccount.")
      default:
        break
      }
    }
    return MTLApplicationDelegate
      .shared
      .application(
        app,
        open: url,
        options: options
    )
  }

  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    print("Device Token: \(deviceToken.hexEncodedString)")
    self.deviceToken = deviceToken
  }

  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    guard userActivity.webpageURL?.host?.contains("getmoneytree.com") ?? false else {
      // If a given universal link doesn't have something to do with LINK SDK, just ignores.
      return false
    }
    return MTLApplicationDelegate.shared.application(
      application,
      userActivity: userActivity,
      presentFrom: viewController!
    ) { error in
      if let error = error {
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

// MARK: - MTLinkClientDelegate

extension AppDelegate: MTLinkClientDelegate {

  func clientStatusDidChange(to status: MTLinkClientStatus, withError error: Error?) {
    let message =
      """
      \(#function): {
        status: \(status.caseName)
        error: \(error?.localizedDescription ?? "nil")
      }
      """
    NSLog(message)
    viewController?.log(title: message, message: nil)
  }
}

extension MTLinkClientStatus {
  var caseName: String {
    switch self {
    case .error:
      return "MTLinkClientStatusError"
    case .vaultDidClose:
      return "MTLinkClientStatusVaultDidClose"
    case .newCredentialAddedViaThirdPartyOauth:
      return "MTLinkClientStatusNewCredentialAddedViaThirdPartyOauth"
    @unknown default:
      return "Unknown"
    }
  }
}

// MARK: - Helpers

private extension AppDelegate {

  var viewController: ViewController? {
    guard
      let navigationController = window?.rootViewController as? UINavigationController,
      let viewController = navigationController.viewControllers.first as? ViewController
    else {
      return nil
    }
    return viewController
  }
}
