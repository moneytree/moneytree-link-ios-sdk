//
//  MoneytreeIdViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/10/18.
//  Copyright © 2012-present Moneytree. All rights reserved.


import UIKit
import MoneytreeLinkCoreKit

final class MoneytreeIdViewController: UIViewController {

  // MARK: - View Properties

  private let authenticationMethodSegmentedControl = UISegmentedControl(
    items: MTLAuthenticationMethod.allCases.map(\.localizedString)
  )
  private let authorizeTextField = UITextField()
  private let forceLogoutSwitch = UISwitch()
  private let onboardingTextField = UITextField()

  private lazy var createAccountButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("moneytree_id.authorize.create_moneytree_id", comment: "")
    )
    button.addTarget(self, action: #selector(createMoneytreeId), for: .touchUpInside)
    return button
  }()

  private lazy var logInButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("moneytree_id.authorize.log_in", comment: "")
    )
    button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
    return button
  }()

  private lazy var passwordlessSignUpButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("moneytree_id.onboarding.passwordless_signup", comment: "")
    )
    button.addTarget(self, action: #selector(passwordlessSignUp), for: .touchUpInside)
    return button
  }()

  private lazy var logOutButton: UIButton = {
    let button = UIComponents.negativeButton(
      title: NSLocalizedString("moneytree_id.logout", comment: "")
    )
    button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    return button
  }()

  // MARK: - Initialization

  private let debugConsole: DebugConsole

  init(debugConsole: DebugConsole) {
    self.debugConsole = debugConsole
    super.init(nibName: nil, bundle: nil)
    title = NSLocalizedString("moneytree_id.title", comment: "")
    tabBarItem.image = UIImage(systemName: "lock.slash")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.addGestureRecognizer(tapGesture)
  }

  // MARK: - Moneytree LINK SDK

  @objc
  private func createMoneytreeId() {
    let authOption = MTLAuthenticationOptions.options(
      mode: .signup,
      allowModeChange: true,
      email: authorizeTextField.text,
      forceLogout: forceLogoutSwitch.isOn
    )

    MTLinkClient.shared.authorize(self, options: authOption, animated: true) { credential, error in
      guard let credential else {
        self.debugConsole.log(error: error ?? fatalError("Expecting an error"))
        return
      }
      self.debugConsole.log(message: self.parse(credential: credential))
    }
  }

  @objc
  private func logIn() {
    let authOption = MTLAuthenticationOptions.options(
      mode: .login,
      allowModeChange: true,
      email: authorizeTextField.text,
      forceLogout: forceLogoutSwitch.isOn
    )

    MTLinkClient.shared.authorize(self, options: authOption, animated: true) { credential, error in
      guard let credential else {
        self.debugConsole.log(error: error ?? fatalError("Expecting an error"))
        return
      }
      self.debugConsole.log(message: self.parse(credential: credential))
    }
  }

  @objc
  private func passwordlessSignUp() {
    guard let email = onboardingTextField.text, !email.isEmpty else {
      debugConsole.log(message: NSLocalizedString("general.output.email_required", comment: ""),
                       style: .negative)
      return
    }

    MTLinkClient.shared.onboard(self, email: email, animated: true) { credential, error in
      guard let credential else {
        self.debugConsole.log(error: error ?? fatalError("Expecting an error"))
        return
      }
      self.debugConsole.log(message: self.parse(credential: credential))
    }
  }

  @objc
  private func logOut() {
    MTLinkClient.shared.logout(from: self) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("moneytree_id.output.logged_out", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  // MARK: - Processing output

  private func parse(credential: MTOAuthCredential) -> String {
    return String(
      format: NSLocalizedString("general.output.token", comment: ""),
      credential.accessToken
    )
  }
}

// MARK: - UI

private extension MoneytreeIdViewController {
  private func setupSubviews() {
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    // Description
    let descriptionLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("moneytree_id.description", comment: "")
    )

    // Authorize
    let authorizeLabel = UIComponents.titleLabel(
      title: NSLocalizedString("moneytree_id.authorize.title", comment: "")
    )
    let authorizeSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("moneytree_id.authorize.description", comment: "")
    )

    authenticationMethodSegmentedControl.addTarget(
      self,
      action: #selector(authenticationMethodChanged),
      for: .valueChanged
    )
    authenticationMethodSegmentedControl.selectedSegmentIndex = 0
    authenticationMethodSegmentedControl.selectedSegmentTintColor = UIColor(named: "PrimaryButtonColor")
    authenticationMethodSegmentedControl.setTitleTextAttributes(
      [NSAttributedString.Key.foregroundColor: UIColor(named: "PrimaryButtonFontColor")!],
      for: .selected
    )
    authenticationMethodChanged()

    authorizeTextField.placeholder = NSLocalizedString("moneytree_id.authorize.email_optional_placeholder", comment: "")
    authorizeTextField.autocapitalizationType = .none
    authorizeTextField.keyboardType = .emailAddress
    authorizeTextField.textContentType = .emailAddress
    authorizeTextField.borderStyle = .roundedRect

    let forceLogoutDescriptionLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("moneytree_id.authorize.force_logout.description", comment: "")
    )
    let forceLogoutTitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("moneytree_id.authorize.force_logout", comment: "")
    )

    forceLogoutSwitch.onTintColor = UIColor(named: "PrimaryButtonColor")
    forceLogoutSwitch.accessibilityIdentifier = "forceLogoutSwitch"

    let forceLogoutStackView = UIStackView()
    forceLogoutStackView.axis = .horizontal
    forceLogoutStackView.addArrangedSubview(forceLogoutTitleLabel)
    forceLogoutStackView.setCustomSpacing(10.0, after: forceLogoutTitleLabel)
    forceLogoutStackView.addArrangedSubview(forceLogoutSwitch)
    forceLogoutStackView.addArrangedSubview(UIView())

    logInButton.accessibilityIdentifier = "logInButton"

    let authorizeButtonStackView = UIStackView()
    authorizeButtonStackView.axis = .vertical
    authorizeButtonStackView.spacing = 10.0
    authorizeButtonStackView.addArrangedSubview(createAccountButton)
    authorizeButtonStackView.addArrangedSubview(logInButton)

    // Onboarding
    let onboardingLabel = UIComponents.titleLabel(
      title: NSLocalizedString("moneytree_id.onboarding.title", comment: "")
    )
    let onboardingSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("moneytree_id.onboarding.description", comment: "")
    )

    onboardingTextField.placeholder = NSLocalizedString(
      "general.email_required_placeholder",
      comment: ""
    )
    onboardingTextField.autocapitalizationType = .none
    onboardingTextField.keyboardType = .emailAddress
    onboardingTextField.textContentType = .emailAddress
    onboardingTextField.borderStyle = .roundedRect

    // Logout
    let logoutLabel = UIComponents.titleLabel(
      title: NSLocalizedString("moneytree_id.logout", comment: "")
    )
    let logoutSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("moneytree_id.logout.description", comment: "")
    )

    let stackView = UIStackView(frame: view.bounds)
    stackView.axis = .vertical
    stackView.spacing = 16.0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(descriptionLabel)
    stackView.setCustomSpacing(48.0, after: descriptionLabel)
    stackView.addArrangedSubview(authorizeLabel)
    stackView.addArrangedSubview(authorizeSubtitleLabel)
    stackView.addArrangedSubview(authenticationMethodSegmentedControl)
    stackView.addArrangedSubview(authorizeTextField)
    stackView.addArrangedSubview(forceLogoutDescriptionLabel)
    stackView.addArrangedSubview(forceLogoutStackView)
    stackView.addArrangedSubview(authorizeButtonStackView)
    stackView.setCustomSpacing(48.0, after: authorizeButtonStackView)
    stackView.addArrangedSubview(onboardingLabel)
    stackView.addArrangedSubview(onboardingSubtitleLabel)
    stackView.addArrangedSubview(onboardingTextField)
    stackView.addArrangedSubview(passwordlessSignUpButton)
    stackView.setCustomSpacing(48.0, after: passwordlessSignUpButton)
    stackView.addArrangedSubview(logoutLabel)
    stackView.addArrangedSubview(logoutSubtitleLabel)
    stackView.addArrangedSubview(logOutButton)
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

    let environment: String
    let configuration = MTLinkClient.shared.currentConfiguration
    if configuration.environment == .production {
      environment = NSLocalizedString("general.output.production", comment: "")
    } else {
      environment = NSLocalizedString("general.output.staging", comment: "")
    }
    debugConsole.log(
      message: String(
        format: NSLocalizedString("general.output.message.default", comment: ""),
        environment
      )
    )
  }

  @objc
  private func hideKeyboard() {
    view.endEditing(true)
  }
}

// MARK: - Authentication method

private extension UISegmentedControl {
  var selectedTitle: String? {
    titleForSegment(at: selectedSegmentIndex)
  }
}

private extension MoneytreeIdViewController {

  @objc
  func authenticationMethodChanged() {
    // There is a potential index out of range error here, which we're aware of but choose not to address due to the simplicity of the sample application.
    let authenticationMethod = MTLAuthenticationMethod
      .allCases[authenticationMethodSegmentedControl.selectedSegmentIndex]
    MTLinkClient.shared.currentConfiguration.authenticationMethod = authenticationMethod

    debugConsole.log(
      message: String(
        format: NSLocalizedString("moneytree_id.output.selected_authentication_method", comment: ""),
        authenticationMethod.localizedString
      )
    )
  }
}

extension MTLAuthenticationMethod: CaseIterable {
  public static var allCases: [MTLAuthenticationMethod] {
    [.credentials, .passwordless, .singleSignOn]
  }

  var localizedString: String {
    let outputKey: String
    switch self {
    case .credentials: outputKey = "moneytree_id.authorize.authentication_method.credentials"
    case .passwordless: outputKey = "moneytree_id.authorize.authentication_method.passwordless"
    case .singleSignOn: outputKey = "moneytree_id.authorize.authentication_method.sso"
    default:
      fatalError("Invalid authentication method: \(String(describing: self))")
    }
    return NSLocalizedString(outputKey, comment: "")
  }
}
