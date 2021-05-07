//
//  ViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 15/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import MoneytreeLINKKit
import MoneytreeLinkCoreKit
import UIKit

enum AuthMode {
  case pkce, codeGrant
}

// Change to valid AuthMode to play around various flow SDK Offers.
let authMode: AuthMode = .pkce
// You can set default email address here
let defaultEmail: String = "test@example.com"

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
    switch authMode {
    case .pkce:
      configuration = MTLConfiguration()
    case .codeGrant:
      configuration = MTLConfiguration(
        // The example remote server you will host on yourself.
        redirectUri: "https://wf3kkdzcog.execute-api.ap-northeast-1.amazonaws.com/staging/external_client_server.json"
      )
    }
    configuration.environment = .staging
    configuration.scopes = Constants.defaultScopes
    configuration.stayLoggedIn = true
    return configuration
  }()
}

struct Message {
  let main: String
  var sub: String?
}

final class ViewController: UIViewController {

  @IBOutlet private weak var tokenLabel: UILabel!
  @IBOutlet private weak var expiresInLabel: UILabel!

  // Used to open Vault at a specific settings page
  @IBOutlet private weak var credentialId: UITextField!

  // Used to open Vault at the services page
  @IBOutlet private weak var type: UITextField!
  @IBOutlet private weak var group: UITextField!
  @IBOutlet private weak var search: UITextField!

  // Used to open Vault at a specific connect institution page
  @IBOutlet private weak var key: UITextField!

  private var codeGrantState: String = {
    // In production you should sync with your server
    UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
  }()

  private var message: Message? {
    didSet {
      tokenLabel.text = message?.main
      expiresInLabel.text = message?.sub
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let currentEnv = MTLinkClient.shared.currentConfiguration.environment.rawValue == 1 ? "Staging" : "Production"
    title = "AwesomeApp - \(currentEnv) - \(authMode)"
    update()
  }

  // MARK: IBActions

  @IBAction func getToken() {
    // Doesn't show login
    MTLinkClient.shared.getTokenAndRefreshAsNeeded { refreshedToken, error in
      guard let token = refreshedToken else {
        self.handle(error)
        return
      }
      self.update(with: token)
    }
  }

  @IBAction func onboardButtonTapped(_ sender: Any) {
    switch authMode {
    case .pkce:
      presentPKCEOnboard()
    case .codeGrant:
      presentAuthCodeGrantOnboard()
    }
  }

  private func presentPKCEOnboard() {
    alertWithTextField(
      title: "Onboard via PKCE",
      message: "Please enter your email",
      placeholder: defaultEmail
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
          self.handle(error)
          return
        }
        self.update(with: credential)
      }
    }
  }

  private func presentAuthCodeGrantOnboard() {
    alertWithTextField(
      title: "Onboard via Code Grant",
      message: "Please enter your email",
      placeholder: defaultEmail
    ) { input in
      guard !input.isEmpty else { return }
      MTLinkClient.shared.onboard(
        from: self,
        authorizationType: .codeGrant,
        email: input,
        state: self.codeGrantState,
        region: .japan,
        animated: true
      ) { _, error in
        if error != nil {
          self.handle(error)
        } else {
          self.tokenLabel.text = "Seems the server gets a token successfully."
        }
      }
    }
  }

  @IBAction func loginLinkButtonTapped(_ sender: Any) {
    alertWithTextField(
      title: "Login Link",
      message: "Please enter your email",
      placeholder: defaultEmail
    ) { [weak self] email in
      guard !email.isEmpty else { return }
      self?.showLoginLinkOptions { destination in
        MTLinkClient.shared.requestForLoginLink(
          forEmail: email,
          to: destination
        ) { error in
          self?.alert(
            title: "Done",
            message: error?.localizedDescription ?? "Login Link sent successfully. Close the app and check your inbox."
          )
        }
      }
    }
  }

  @IBAction func linkKitButtonTapped() {
    guard authMode == .pkce else {
      message = Message(main: "LINK Kit is available only on PKCE mode.")
      return
    }
    MTLinkKit.shared.makeViewController { viewController, error in
      guard let linkKitViewController = viewController else {
        self.handle(error)
        return
      }
      self.navigationController?.pushViewController(linkKitViewController, animated: true)
    }
  }

  @IBAction func vaultButtonTapped() {
    MTLinkClient.shared.openVault(
      from: self,
      animated: true,
      email: defaultEmail
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Opened Vault.")
      }
    }
  }

  @IBAction func vaultServicesButtonTapped() {
    let typeOption = type.text ?? ""
    let groupOption = group.text ?? ""
    let searchOption = search.text ?? ""
    let options = [
      "type": typeOption,
      "group": groupOption,
      "search": searchOption
    ]
    MTLinkClient.shared.openServices(
      from: self,
      animated: true,
      email: defaultEmail,
      options: options
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Opened Vault Services.")
      }
    }
  }

  @IBAction func vaultAddServiceButtonTapped() {
    let entityKey = key.text ?? "mitsubishi_trust_bank"
    MTLinkClient.shared.connectService(
      from: self,
      animated: true,
      email: defaultEmail,
      entityKey: entityKey
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Opened Vault Add Service.")
      }
    }
  }

  @IBAction func vaultServiceSettingsButtonTapped() {
    MTLinkClient.shared.serviceSettings(
      from: self,
      animated: true,
      email: defaultEmail,
      credentialId: credentialId.text ?? ""
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Opened Vault Service Settings.")
      }
    }
  }

  @IBAction func customerSupportButtonTapped() {
    MTLinkClient.shared.openCustomerSupport(
      from: self.navigationController!,
      animated: true,
      email: defaultEmail
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Opened Customer Support.")
      }
    }
  }

  @IBAction func authForTokenButtonTapped() {
    switch authMode {
    case .pkce:
      presentPKCEAuthorize()
    case .codeGrant:
      presentAuthCodeGrantAuthorize()
    }
  }

  private func presentPKCEAuthorize() {
    let authOption = MTLinkAuthOptions.authOption(
      showSignUp: true,
      guestEmail: defaultEmail
    )
    authOption.useForceLogout = true
    MTLinkClient.shared.authorizeUsingPkce(
      from: self,
      authOptions: authOption,
      animated: true
    ) { credential, error in
      guard let credential = credential else {
        self.handle(error)
        return
      }
      self.update(with: credential)
    }
  }

  private func presentAuthCodeGrantAuthorize() {
    let authOption = MTLinkAuthOptions.authOption(
      showSignUp: false,
      guestEmail: defaultEmail
    )
    authOption.useForceLogout = true
    MTLinkClient.shared.authorizeUsingCodeGrant(
      from: self,
      state: codeGrantState,
      authOptions: authOption,
      animated: true
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Seems the server gets a token successfully.")
      }
    }
  }

  @IBAction func settingsButtonTapped(_ sender: Any) {
    MTLinkClient.shared.openSettings(
      from: self,
      email: defaultEmail,
      animated: true
    ) { error in
      if error != nil {
        self.handle(error)
      } else {
        self.message = Message(main: "Opened MyAccount.")
      }
    }
  }

  @IBAction func clearButtonTapped(_ sender: Any) {
    MTLinkClient.shared.removeAllTokens()
    tokenLabel.text = "Token was removed."
    expiresInLabel.text = nil
  }

  @IBAction func logoutButtonTapped(_ sender: Any) {
    MTLinkClient.shared.logout(from: self) { error in
      if error == nil {
        self.message = Message(main: "Logout and removed an existing token.")
      }
    }
  }

  private func update(with newToken: MTOAuthCredential? = nil) {
    guard authMode == .pkce else {
      // SDK Doesn't manage token in this authorization code grant mode
      tokenLabel.text = nil
      expiresInLabel.text = nil
      return
    }
    guard let token = newToken?.accessToken else {
      message = Message(main: "Tap `Authorize` or `Get Token` (if already authorized) to grab token from SDK.")
      return
    }
    let expirationDate = newToken!.expirationDate
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    message = Message(
      main: "Access Token: \(token.prefix(50))...",
      sub: "Expires in: \(formatter.string(from: expirationDate))"
    )
  }

  // MARK: Public Method

  func log(title: String?, message: String?) {
    tokenLabel.text = title
    expiresInLabel.text = message
  }
}

// MARK: - Convenient Functions

private extension ViewController {

  func showLoginLinkOptions(completion: @escaping (_ destination: MTMagicLinkDestination) -> Void) {
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
    showActionSheet(
      title: "Login Link",
      message: "Please pick the destination",
      actions: actions
    ) { index in
      completion(destinations[index])
    }
  }

  func handle(_ error: Error?) {
    expiresInLabel.text = nil
    guard let error = error else {
      message = Message(main: "Unknown error.")
      return
    }
    let nsError = error as NSError
    guard let linkError = MTLinkClientError(rawValue: nsError.code) else {
      message = Message(main: "\(error.localizedDescription)")
      return
    }
    let errorMessage: String
    switch linkError {
    case .errorGuestCancelledAuthorization:
      errorMessage = "User cancelled authorization process."
    case .authorizationInProgress:
      errorMessage = "Authorization is in progress."
    case .errorGuestNotLinked:
      errorMessage = "User is not authorized yet."
    case .errorUnavailableInPKCEMode,
         .errorUnavailableInAuthorizationCodeGrantMode:
      errorMessage = "That operation is unavailable in this auth mode."
    case .errorUnknown:
      errorMessage = "Unknown error. Probably user closed WebView."
    @unknown default:
      errorMessage = "Unknown callback. Probably user closed WebView and it's not an issue."
    }
    message = Message(
      main: errorMessage,
      sub: "MTLinkClientError - \(linkError.rawValue)"
    )
  }

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
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      completion(alert.textFields?.first?.text ?? "")
    })
    present(alert, animated: true)
  }

  func showActionSheet(
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
