//
//  AppDelegate.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 15/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import UIKit
import CoreData
#if !(DEBUG)
import Firebase
#endif
import MoneytreeLinkCoreKit
import MoneytreeIntelligence

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
    MLIntelligence.start()

    UIApplication.shared.registerForRemoteNotifications()

    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate.
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return MTLApplicationDelegate
      .shared
      .application(
        app,
        open: url,
        options: options
    )
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("Device Token: \(deviceToken.hexEncodedString)")
    self.deviceToken = deviceToken
  }

  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    let canMoneytreeHandleUserActivity = MTLApplicationDelegate
      .shared
      .application(application, userActivity: userActivity, presentFrom: viewController!) { error in
        if let error = error {
          debugPrint("Error handling universal link: \(String(describing: userActivity.webpageURL)) \n Error: \(error)")
        } else {
          debugPrint("Successfully handled universal link: \(String(describing: userActivity.webpageURL))")
        }
      }

    // If Moneytree cannot handle this user activity, check if other party can
    return canMoneytreeHandleUserActivity
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

extension AppDelegate {
  private var viewController: ViewController? {
    guard
      let navigationController = window?.rootViewController as? UINavigationController,
      let viewController = navigationController.viewControllers.first as? ViewController
    else {
      return nil
    }

    return viewController
  }
}
