//
//  ViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 15/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import Foundation
import UIKit

import MoneytreeIntelligence
import MoneytreeLINKKit
import MoneytreeLinkCoreKit

enum DemoMode {
  case pkce, authCodeGrant
}

// Change to valid DemoMode to play around various flow SDK Offers.
let demoMode: DemoMode = .pkce

struct Constants {

  static var defaultScopes = [
    MTLClientScopeGuestRead,
    MTLClientScopeAccountsRead,
    MTLClientScopeTransactionsRead
  ]

  static var linkKitScopes = [
    MTLClientScopeGuestRead,
    MTLClientScopeAccountsRead,
    MTLClientScopeTransactionsRead,
    MTLClientScopeTransactionsWrite,
    MTLClientScopePointsRead,
    MTLClientScopeInvestmentAccountsRead,
    MTLClientScopeInvestmentTransactionsRead
  ]

  static var configuration: MTLConfiguration = {
    let configuration: MTLConfiguration
    switch demoMode {
    case .pkce:
      configuration = MTLConfiguration()
    case .authCodeGrant:
      configuration = MTLConfiguration(
        // The example remote server you will host on yourself.
        redirectUri: "https://wf3kkdzcog.execute-api.ap-northeast-1.amazonaws.com/staging/external_client_server.json"
      )
    }
    configuration.environment = .staging
    configuration.scopes = Constants.defaultScopes
    configuration.stayLoggedIn = false
    return configuration
  }()
}

final class ViewController: UIViewController {

  @IBOutlet private var tokenLabel: UILabel!
  @IBOutlet private var expiresInLabel: UILabel!
  //  credentialId UITextField Used to open Vault at a specific settings page
  @IBOutlet private var credentialId: UITextField!
  //  type, group and search UITextFields Used to open Vault at the services page
  @IBOutlet private var type: UITextField!
  @IBOutlet private var group: UITextField!
  @IBOutlet private var search: UITextField!
  //  key UITextField Used to open Vault at a specific connect institution page
  @IBOutlet private var key: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    updateToken(with: nil)
  }

  func log(title: String?, message: String?) {
    tokenLabel.text = title
    expiresInLabel.text = message
  }

  private func handleError(_ error: Error?) {
    expiresInLabel.text = nil
    guard let error = error else {
      tokenLabel.text = "Unknown error."
      return
    }
    let nsError = error as NSError
    guard let linkError = MTLinkClientError(rawValue: UInt(nsError.code)) else {
      tokenLabel.text = "\(error.localizedDescription)"
      return
    }
    switch linkError {
    case .authorizationInProgress:
      tokenLabel.text = "Authorization is in progress."
    case .errorGuestCancelledAuthorization:
      tokenLabel.text = "User cancelled authorization process."
    case .errorGuestNotLinked:
      tokenLabel.text = "User is not authorized yet."
    case .errorUnavailableInAuthorizationCodeGrantMode, .errorUnavailableInPKCEMode:
      tokenLabel.text = "That operation is unavailable in this auth mode."
    case .errorUnknown:
      tokenLabel.text = "Unknown error. Probably user closed WebView."
    @unknown default:
      tokenLabel.text = "Unknown callback. Probably user closed WebView and it's not an issue."
    }
  }

  // MARK: IBActions

  @IBAction func getToken() {
    // Doesn't show login
    MTLinkClient.shared.getTokenAndRefreshAsNeeded { refreshedToken, error in
      guard let token = refreshedToken else {
        self.handleError(error)
        return
      }
      self.updateToken(with: token)
    }
  }

  @IBAction func onboardButtonTapped(_ sender: Any) {
    switch demoMode {
    case .pkce:
      presentPKCEOnboard()
    case .authCodeGrant:
      presentAuthCodeGrantOnboard()
    }
  }

  private func presentPKCEOnboard() {
    alertWithTextField(
      title: "Onboard via PKCE",
      message: "Please enter your email",
      placeholder: "your-email@example.com"
    ) { input in
      guard !input.isEmpty else { return }

      MTLinkClient.shared.onboard(
        from: self,
        authorizationType: .PKCE,
        email: input,
        state: nil,
        region: .japan,
        animated: true
      ) { credential, error in
        guard let credential = credential else {
          self.handleError(error)
          return
        }
        self.updateToken(with: credential)
      }
    }
  }

  private func presentAuthCodeGrantOnboard() {
    alertWithTextField(
      title: "Onboard via Code Grant",
      message: "Please enter your email",
      placeholder: "your-email@example.com"
    ) { input in
      guard !input.isEmpty else { return }

      MTLinkClient.shared.onboard(
        from: self,
        authorizationType: .codeGrant,
        email: input,
        state: "Provide_A_RandomState__See_Api_Description",
        region: .japan,
        animated: true
      ) { _, error in
        if error != nil {
          self.handleError(error)
        } else {
          self.tokenLabel.text = "Seems the server gets a token successfully."
        }
      }
    }
  }

  @IBAction func magicLinkButtonTapped(_ sender: Any) {
    alertWithTextField(
      title: "Magic Link",
      message: "Please enter your email",
      placeholder: "your-email@example.com"
    ) { [weak self] email in
      guard !email.isEmpty else { return }

      self?.showMagicLinkOptions { destination in
        MTLinkClient.shared.requestForMagicLink(
          forEmail: email,
          to: destination
        ) { error in
          self?.alert(title: "Done", message: error?.localizedDescription ?? "Magic Link sent successfully")
        }
      }
    }
  }

  @IBAction func linkKitButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]linkKit_tapped")
    MTLinkKit.shared.makeViewController { viewController, error in
      guard let linkKitViewController = viewController else {
        self.handleError(error)
        return
      }
      self.navigationController?.pushViewController(linkKitViewController, animated: true)
    }
  }

  @IBAction func vaultButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]vault_tapped")
    MTLinkClient.shared.openVault(from: self, animated: true, email: "test-prefill@fake-email.com") { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Opened Vault."
      }
    }
  }

  @IBAction func vaultServicesButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]vault_services_tapped")
    let typeOption = type.text ?? ""
    let groupOption = group.text ?? ""
    let searchOption = search.text ?? ""
    let options: NSDictionary = NSDictionary(dictionary: [
      "type": typeOption,
      "group": groupOption,
      "search": searchOption
    ])
    MTLinkClient.shared.openServices(
      from: self,
      animated: true,
      email: "test-prefill@fake-email.com",
      options: options as? [String: String]
    ) { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Opened Vault Services."
      }
    }
  }

  @IBAction func vaultAddServiceButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]vault_add_service_tapped")
    let entityKey = key.text ?? "mitsubishi_trust_bank"
    MTLinkClient.shared.connectService(
      from: self,
      animated: true,
      email: "test-prefill@fake-email.com",
      entityKey: entityKey
    ) { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Opened Vault Add Service."
      }
    }
  }

  @IBAction func vaultServiceSettingsButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]vault_service_settings_tapped")
    MTLinkClient.shared.serviceSettings(
      from: self,
      animated: true,
      email: "test-prefill@fake-email.com",
      credentialId: credentialId.text ?? ""
    ) { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Opened Vault Service Settings."
      }
    }
  }

  @IBAction func customerSupportButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]customer_support_tapped")

    MTLinkClient.shared.openCustomerSupport(
      from: self.navigationController!,
      animated: true,
      email: "test-prefill@fake-email.com"
    ) { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Opened Customer Support."
      }
    }
  }

  @IBAction func authForTokenButtonTapped() {
    MLIntelligence.shared().recordEvent("[awesomeApp]auth_tapped")
    switch demoMode {
    case .pkce:
      presentPKCEAuthorize()
    case .authCodeGrant:
      presentAuthCodeGrantAuthorize()
    }
  }

  private func presentPKCEAuthorize() {
    let authOption = MTLinkAuthOptions.authOption(
      showSignUp: true,
      guestEmail: "your-email@example.com"
    )
    authOption.useForceLogout = true
    MTLinkClient.shared.authorizeUsingPkce(from: self, authOptions: authOption, animated: true) { credential, error in
      guard let credential = credential else {
        self.handleError(error)
        return
      }
      self.updateToken(with: credential)
    }
  }

  private func presentAuthCodeGrantAuthorize() {
    let authOption = MTLinkAuthOptions.authOption(
      showSignUp: false,
      guestEmail: "your-email@example.com"
    )
    authOption.useForceLogout = true
    MTLinkClient.shared.authorizeUsingCodeGrant(
      from: self,
      state: "Provide_A_RandomState__See_Api_Description",
      authOptions: authOption,
      animated: true
    ) { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Seems the server gets a token successfully."
      }
    }
  }

  @IBAction func settingsButtonTapped(_ sender: Any) {
    MLIntelligence.shared().recordEvent("[awesomeApp]settings_tapped")
    MLIntelligence.shared().recordEvent(
      "[awesomeApp]event_with_segments",
      segments: ["segmentKey": "segmentValue"]
    )
    MTLinkClient.shared.openSettings(from: self, email: "test-prefill@fake-email.com", animated: true) { error in
      if error != nil {
        self.handleError(error)
      } else {
        self.tokenLabel.text = "Opened Settings webview."
      }
    }
  }

  @IBAction func clearButtonTapped(_ sender: Any) {
    MLIntelligence.shared().recordEvent("[awesomeApp]clear_tapped")
    MTLinkClient.shared.removeAllTokens()
    tokenLabel.text = "Token was removed."
    expiresInLabel.text = nil
  }

  @IBAction func logoutButtonTapped(_ sender: Any) {
    MLIntelligence.shared().recordEvent("[awesomeApp]logout_tapped")
    MTLinkClient.shared.logout(from: self) { error in
      if error == nil {
        self.tokenLabel.text = "Logout and removed an existing token."
        self.expiresInLabel.text = nil
      }
    }
  }

  // MARK: Public Method

  func updateToken(with newToken: MTOAuthCredential?) {
    guard demoMode == .pkce else {
      // SDK Doesn't manage token in this authorization code grant mode
      tokenLabel.text = nil
      expiresInLabel.text = nil
      return
    }
    guard let token = newToken?.accessToken else {
      tokenLabel.text = "Tap `Authorize` or `Get Token` (if already authorized) to grab token from SDK."
      expiresInLabel.text = nil
      return
    }
    tokenLabel.text = "Access Token: \(token.prefix(100))"
    let expirationDate = newToken!.expirationDate
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .long
    expiresInLabel.text = """
      (Only showing first 100 chars of access token)
      Expires in: \(formatter.string(from: expirationDate))
    """
  }
}

extension ViewController: UITextFieldDelegate { }

// MARK: - Convenient Functions

extension ViewController {
  func showMagicLinkOptions(completion: @escaping (_ destination: MTMagicLinkDestination) -> Void) {
    let destinations: [MTMagicLinkDestination] = [
      .settings,
      .changeLanguage,
      .deleteAccount,
      .authorizedApplications,
      .emailPreferences,
      .updateEmail,
      .updatePassword
    ]
    let actions: [(String, UIAlertAction.Style)] = destinations.map { ($0.rawValue, .default) }

    showActionsheet(title: "Magic Link", message: "Please pick the destination", actions: actions) { index in
      completion(destinations[index])
    }
  }
}

// MARK: - Helpers

extension ViewController {
  func alert(title: String? = nil, message: String? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

    present(alert, animated: true)
  }

  func alertWithTextField(
    title: String? = nil,
    message: String? = nil,
    placeholder: String? = nil,
    completion: @escaping (String) -> Void
  ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addTextField { newTextField in
      newTextField.placeholder = placeholder
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("") })
    alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
      completion(alert.textFields?.first?.text ?? "")
    })

    present(alert, animated: true)
  }

  func showActionsheet(
    title: String,
    message: String,
    actions: [(String, UIAlertAction.Style)],
    completion: @escaping (_ index: Int) -> Void
  ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    for (index, (title, style)) in actions.enumerated() {
      let alertAction = UIAlertAction(title: title, style: style) { _ in
        completion(index)
      }
      alert.addAction(alertAction)
    }

    present(alert, animated: true)
  }
}
