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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private let consoleView = ConsoleView(frame: .zero)
  private lazy var rootViewController = MainViewController(consoleView: consoleView)

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

    setupWindow()

    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    // Check if a given URL is for the LINK SDK
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
    return MTLApplicationDelegate.shared.application(app, open: url, options: options)
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
      presentFrom: rootViewController
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

  private func setupWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
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
