//
//  AppDelegate.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 15/5/17.
//  Copyright © 2012-present Moneytree. All rights reserved.
//

import CoreData
import MoneytreeLinkCoreKit
import UIKit

// MARK: - Moneytree LINK SDK configuration

struct LinkSDKScopes {

  static let defaultScopes = [
    MTLClientScopeGuestRead,
    MTLClientScopeAccountsRead,
    MTLClientScopeTransactionsRead
  ]

  static let linkKitScopes = [
    MTLClientScopeGuestRead,
    MTLClientScopeAccountsRead,
    MTLClientScopeTransactionsRead,
    MTLClientScopeTransactionsWrite,
    MTLClientScopePointsRead,
    MTLClientScopeInvestmentAccountsRead,
    MTLClientScopeInvestmentTransactionsRead,
    MTLClientScopeRequestRefresh
  ]
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  let consoleView = ConsoleView(frame: .zero)
  lazy var rootViewController = MainViewController(consoleView: consoleView)

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Moneytree LINK SDK configuration
    let configuration = MTLConfiguration()
    configuration.environment = .staging
    configuration.scopes = LinkSDKScopes.defaultScopes
    configuration.stayLoggedIn = true
    configuration.authenticationMethod = .credentials

    // Moneytree LINK SDK initialization
    let mtLinkClient = MTLinkClient(configuration: configuration)
    mtLinkClient.delegate = self


    UIApplication.shared.registerForRemoteNotifications()

    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    // This method is only called in app-based lifecycle (no UIApplicationSceneManifest in Info.plist).
    // In a scene-based app, iOS routes URL callbacks to SceneDelegate instead — this method is never called.
    // See `scene(_:openURLContexts:)` in SceneDelegate.swift for the scene-based implementation.
    return true
  }

  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    // This method is only called in app-based lifecycle (no UIApplicationSceneManifest in Info.plist).
    // In a scene-based app, iOS routes universal link callbacks to SceneDelegate instead — this method is never called.
    // See `scene(_:continue:)` in SceneDelegate.swift for the scene-based implementation.
    return false
  }

}

// MARK: - MTLinkClientDelegate

extension AppDelegate: MTLinkClientDelegate {

  func clientStatusDidChange(to status: MTLinkClientStatus, withError error: Error?) {
    consoleView.log(message: "Status: \(status.caseName)\nError: \(error?.localizedDescription ?? "nil")")
  }
}

extension MTLinkClientStatus {
  var caseName: String {
    switch self {
    case .error:
      return "MTLinkClientStatusError"
    case .vaultDidClose:
      return NSLocalizedString("services.output.vault_closed", comment: "")
    case .newCredentialAddedViaThirdPartyOauth:
      return "MTLinkClientStatusNewCredentialAddedViaThirdPartyOauth"
    @unknown default:
      return "Unknown"
    }
  }
}
