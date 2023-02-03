//
//  OtherFunctionsViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/11/30.
//  Copyright © 2012-present Moneytree. All rights reserved.
//

import UIKit
import MoneytreeLinkCoreKit

final class OtherFunctionsViewController: UIViewController {

  // MARK: - View Properties
  private let loginLinkTextField = UITextField()
  private let loginLinkDestinationsPicker = UIPickerView()

  private lazy var notificationsRegisterButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("other_functions.notifications.register", comment: "")
    )
    button.addTarget(self, action: #selector(registerNotifications), for: .touchUpInside)
    return button
  }()

  private lazy var notificationsUnregisterButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("other_functions.notifications.unregister", comment: "")
    )
    button.addTarget(self, action: #selector(unregisterNotifications), for: .touchUpInside)
    return button
  }()

  private lazy var loginLinkButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("other_functions.login_link.request_login_link", comment: "")
    )
    button.addTarget(self, action: #selector(requestLoginLink), for: .touchUpInside)
    return button
  }()

  private lazy var settingsButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("other_functions.settings.open_settings", comment: "")
    )
    button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
    return button
  }()

  private lazy var customerSupportButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("other_functions.customer_support.open_customer_support", comment: "")
    )
    button.addTarget(self, action: #selector(openCustomerSupport), for: .touchUpInside)
    return button
  }()

  private lazy var getTokenButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("other_functions.get_token", comment: "")
    )
    button.addTarget(self, action: #selector(getToken), for: .touchUpInside)
    return button
  }()

  private lazy var clearTokenButton: UIButton = {
    let button = UIComponents.negativeButton(
      title: NSLocalizedString("other_functions.clear_token", comment: "")
    )
    button.addTarget(self, action: #selector(clearToken), for: .touchUpInside)
    return button
  }()

  // MARK: - Initialization

  private let debugConsole: DebugConsole

  init(debugConsole: DebugConsole) {
    self.debugConsole = debugConsole
    super.init(nibName: nil, bundle: nil)
    title = NSLocalizedString("other_functions.title", comment: "")
    tabBarItem.image = UIImage(systemName: "wrench.adjustable")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private

  let loginLinkDestinations: [(destination: MTMagicLinkDestination, name: String)] = [
    (.settings, NSLocalizedString("other_functions.login_link.destination.settings", comment: "")),
    (.changeLanguage, NSLocalizedString("other_functions.login_link.destination.change_language", comment: "")),
    (.authorizedApplications, NSLocalizedString("other_functions.login_link.destination.authorized_apps", comment: "")),
    (.deleteAccount, NSLocalizedString("other_functions.login_link.destination.delete_account", comment: "")),
    (.emailPreferences, NSLocalizedString(
      "other_functions.login_link.destination.update_email_preferences",
      comment: "")
    ),
    (.updateEmail, NSLocalizedString("other_functions.login_link.destination.update_email_address", comment: "")),
    (.updatePassword, NSLocalizedString("other_functions.login_link.destination.update_password", comment: ""))
  ]

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.addGestureRecognizer(tapGesture)
  }

  // MARK: - Moneytree LINK SDK

  @objc
  private func registerNotifications() {
    debugConsole.log(message: NSLocalizedString("other_functions.notifications.registering_device", comment: ""))

    // See https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns
    // to understand how to retrieve a device token
    let deviceToken: MTDeviceToken? = "someToken".data(using: .utf8) as? NSData

    let request = MTRegisterDeviceTokenAPI(requestBody: deviceToken) { _, _, error in
      // Notice this closure does not execute on the main thread

      DispatchQueue.main.async {
        guard let error else {
          self.debugConsole.log(
            message: NSLocalizedString("other_functions.output.notification_register_success", comment: "")
          )
          return
        }
        self.debugConsole.log(error: error)
      }
    }
    MTLinkClient.shared.api?.sendRequest(request)
  }

  @objc
  private func unregisterNotifications() {
    debugConsole.log(message: NSLocalizedString("other_functions.notifications.unregistering_device", comment: ""))

    // See https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns
    // to understand how to retrieve a device token
    let deviceToken: MTDeviceToken? = "someToken".data(using: .utf8) as? NSData

    let request = MTDeregisterDeviceTokenAPI(requestBody: deviceToken) { _, _, error in
      // Notice this closure does not execute on the main thread

      DispatchQueue.main.async {
        guard let error else {
          self.debugConsole.log(
            message: NSLocalizedString("other_functions.output.notification_unregister_success", comment: "")
          )
          return
        }
        self.debugConsole.log(error: error)
      }
    }
    MTLinkClient.shared.api?.sendRequest(request)
  }

  @objc
  private func requestLoginLink() {
    guard let email = loginLinkTextField.text, !email.isEmpty else {
      debugConsole.log(message: NSLocalizedString("general.output.email_required", comment: ""),
                       style: .negative)
      return
    }

    let selectedLoginLinkDestinationIndex = loginLinkDestinationsPicker.selectedRow(inComponent: 0)
    debugConsole.log(message: NSLocalizedString("other_functions.login_link.requesting_login_link", comment: ""))

    MTLinkClient.shared.requestForLoginLink(
      forEmail: email,
      to: loginLinkDestinations[selectedLoginLinkDestinationIndex].destination
    ) { error in
      guard let error else {
        self.debugConsole.log(
          message: NSLocalizedString("other_functions.login_link.requested_login_link", comment: "")
        )
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  @objc
  private func openSettings() {
    MTLinkClient.shared.openSettings(
      from: self,
      email: nil,
      animated: true
    ) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("other_functions.output.opened_settings", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  @objc
  private func openCustomerSupport() {
    MTLinkClient.shared.openCustomerSupport(
      from: self,
      animated: true,
      email: nil
    ) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("other_functions.output.opened_customer_support", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  @objc
  private func getToken() {
    MTLinkClient.shared.getTokenAndRefreshAsNeeded { refreshedCredential, error in
      guard let credential = refreshedCredential else {
        self.debugConsole.log(error: error ?? fatalError("Expecting an error"))
        return
      }
      self.debugConsole.log(
        message: String(format: NSLocalizedString("general.output.token", comment: ""),
                        credential.accessToken)
      )
    }
  }

  @objc
  private func clearToken() {
    MTLinkClient.shared.removeAllTokens()
    debugConsole.log(message: NSLocalizedString("other_functions.output.cleared_token_success", comment: ""))
  }
}

// MARK: - UI

extension OtherFunctionsViewController {
  private func setupSubviews() {
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    // Description
    let descriptionLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.description", comment: "")
    )

    // Notifications
    let notificationsLabel = UIComponents.titleLabel(
      title: NSLocalizedString("other_functions.notifications.title", comment: "")
    )
    let notifictionsSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.notifications.description", comment: "")
    )

    let notificationsButtonStackView = UIStackView()
    notificationsButtonStackView.axis = .horizontal
    notificationsButtonStackView.spacing = 10.0
    notificationsButtonStackView.distribution = .fillEqually
    notificationsButtonStackView.addArrangedSubview(notificationsRegisterButton)
    notificationsButtonStackView.addArrangedSubview(notificationsUnregisterButton)

    // Login Link
    let loginLinkLabel = UIComponents.titleLabel(
      title: NSLocalizedString("other_functions.login_link.title", comment: "")
    )
    loginLinkLabel.numberOfLines = 2
    let loginLinkSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.login_link.description", comment: "")
    )

    loginLinkTextField.placeholder = NSLocalizedString(
      "general.email_required_placeholder",
      comment: ""
    )
    loginLinkTextField.autocapitalizationType = .none
    loginLinkTextField.keyboardType = .emailAddress
    loginLinkTextField.textContentType = .emailAddress
    loginLinkTextField.borderStyle = .roundedRect

    let loginLinkDestinationsLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.login_link.select_destination", comment: "")
    )

    loginLinkDestinationsPicker.dataSource = self
    loginLinkDestinationsPicker.delegate = self

    // Settings
    let settingsLabel = UIComponents.titleLabel(
      title: NSLocalizedString("other_functions.settings.title", comment: "")
    )
    let settingsSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.settings.description", comment: "")
    )

    // Customer Support
    let customerSupportLabel = UIComponents.titleLabel(
      title: NSLocalizedString("other_functions.customer_support.title", comment: "")
    )
    let customerSupportSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.customer_support.description", comment: "")
    )

    // Get Token
    let getTokenLabel = UIComponents.titleLabel(
      title: NSLocalizedString("other_functions.get_token", comment: "")
    )
    let getTokenSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.get_token.description", comment: "")
    )

    // Clear Token
    let clearTokenLabel = UIComponents.titleLabel(
      title: NSLocalizedString("other_functions.clear_token", comment: "")
    )
    let clearTokenSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("other_functions.clear_token.description", comment: "")
    )

    let stackView = UIStackView(frame: view.bounds)
    stackView.axis = .vertical
    stackView.spacing = 16.0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(descriptionLabel)
    stackView.setCustomSpacing(48.0, after: descriptionLabel)
    stackView.addArrangedSubview(notificationsLabel)
    stackView.addArrangedSubview(notifictionsSubtitleLabel)
    stackView.addArrangedSubview(notificationsButtonStackView)
    stackView.setCustomSpacing(48.0, after: notificationsButtonStackView)
    stackView.addArrangedSubview(loginLinkLabel)
    stackView.addArrangedSubview(loginLinkSubtitleLabel)
    stackView.addArrangedSubview(loginLinkTextField)
    stackView.addArrangedSubview(loginLinkDestinationsLabel)
    stackView.addArrangedSubview(loginLinkDestinationsPicker)
    stackView.addArrangedSubview(loginLinkButton)
    stackView.setCustomSpacing(48.0, after: loginLinkButton)
    stackView.addArrangedSubview(settingsLabel)
    stackView.addArrangedSubview(settingsSubtitleLabel)
    stackView.addArrangedSubview(settingsButton)
    stackView.setCustomSpacing(48.0, after: settingsButton)
    stackView.addArrangedSubview(customerSupportLabel)
    stackView.addArrangedSubview(customerSupportSubtitleLabel)
    stackView.addArrangedSubview(customerSupportButton)
    stackView.setCustomSpacing(48.0, after: customerSupportButton)
    stackView.addArrangedSubview(getTokenLabel)
    stackView.addArrangedSubview(getTokenSubtitleLabel)
    stackView.addArrangedSubview(getTokenButton)
    stackView.setCustomSpacing(48.0, after: getTokenButton)
    stackView.addArrangedSubview(clearTokenLabel)
    stackView.addArrangedSubview(clearTokenSubtitleLabel)
    stackView.addArrangedSubview(clearTokenButton)
    stackView.addArrangedSubview(UIView())

    let bottomOffset = ConsoleView.height
    let scrollViewContainer = UIView()
    scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(scrollViewContainer)

    NSLayoutConstraint.activate([
      scrollViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      scrollViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
      scrollViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      scrollViewContainer.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: -bottomOffset
      )
    ])

    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsVerticalScrollIndicator = false

    scrollViewContainer.addSubview(scrollView)
    scrollView.addSubview(stackView)

    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: scrollViewContainer.bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }

  @objc
  private func hideKeyboard() {
    view.endEditing(true)
  }
}

// MARK: - UIPickerViewDataSource

extension OtherFunctionsViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return loginLinkDestinations.count
  }
}

// MARK: - UIPickerViewDelegate

extension OtherFunctionsViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView,
                  viewForRow row: Int,
                  forComponent component: Int,
                  reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.adjustsFontSizeToFitWidth = true
    label.text = loginLinkDestinations[row].name
    return label
  }
}
