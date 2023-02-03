//
//  ServicesViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/11/16.
//  Copyright © 2012-present Moneytree. All rights reserved.


import UIKit
import MoneytreeLinkCoreKit

final class ServicesViewController: UIViewController {

  // MARK: - View Properties

  private let serviceListPicker = UIPickerView()
  private let serviceSearchTextField = UITextField()
  private let serviceConnectionEntityKeyTextField = UITextField()
  private let connectionSettingsAccountGroupTextfield = UITextField()

  private lazy var openVaultButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("services.vault.open_vault", comment: "")
    )
    button.addTarget(self, action: #selector(openVault), for: .touchUpInside)
    return button
  }()

  private lazy var openServicesButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("services.list.open_service_list", comment: "")
    )
    button.addTarget(self, action: #selector(openServices), for: .touchUpInside)
    return button
  }()

  private lazy var connectServiceButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("services.service_connection.connect_service", comment: "")
    )
    button.addTarget(self, action: #selector(connectService), for: .touchUpInside)
    return button
  }()

  private lazy var serviceSettingsButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("services.connection_settings.open_connection_settings", comment: "")
    )
    button.addTarget(self, action: #selector(serviceSettings), for: .touchUpInside)
    return button
  }()

  // MARK: - Initialization

  private let debugConsole: DebugConsole

  init(debugConsole: DebugConsole) {
    self.debugConsole = debugConsole
    super.init(nibName: nil, bundle: nil)
    title = NSLocalizedString("services.title", comment: "")
    tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
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

  private let serviceTypes = [
    NSLocalizedString("general.no_selection", comment: ""),
    "bank", "credit_card", "stored_value", "point", "corporate", "stock"
  ]

  private let serviceGroups = [
    NSLocalizedString("general.no_selection", comment: ""),
    "grouping_bank", "grouping_bank_credit_card", "grouping_bank_dc_card",
    "grouping_corporate_credit_card", "grouping_credit_card", "grouping_credit_coop",
    "grouping_credit_union", "grouping_dc_pension_plan", "grouping_debit_card",
    "grouping_digital_money", "grouping_ja_bank", "grouping_life_insurance",
    "grouping_point", "grouping_regional_bank", "grouping_stock", "grouping_testing"
  ]

  @objc
  private func openVault() {
    MTLinkClient.shared.openVault(
      from: self,
      animated: true,
      email: nil
    ) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("services.output.vault_opened", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  @objc
  private func openServices() {
    let selectedTypeIndex = serviceListPicker.selectedRow(inComponent: ServiceListFilters.serviceType.rawValue)
    let selectedGroupIndex = serviceListPicker.selectedRow(inComponent: ServiceListFilters.serviceGroup.rawValue)
    let options = [
      "type": selectedTypeIndex > 0 ? serviceTypes[selectedTypeIndex] : "",
      "group": selectedGroupIndex > 0 ? serviceGroups[selectedGroupIndex] : "",
      "search": serviceSearchTextField.text ?? ""
    ]
    MTLinkClient.shared.openServices(
      from: self,
      animated: true,
      email: nil,
      options: options
    ) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("services.output.service_list_opened", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  @objc
  private func connectService() {
    /// The `entityKey` available values can be found in https://docs.link.getmoneytree.com/reference/institution-list
    guard let entityKey = serviceConnectionEntityKeyTextField.text, !entityKey.isEmpty else {
      self.debugConsole.log(
        message: NSLocalizedString("services.output.entity_key_required", comment: ""),
        style: .negative
      )
      return
    }
    MTLinkClient.shared.connectService(
      from: self,
      animated: true,
      email: nil,
      entityKey: entityKey
    ) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("services.output.service_connection_opened", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }

  @objc
  private func serviceSettings() {
    /// The `accountGroup` available values can be found in https://docs.link.getmoneytree.com/reference/get-link-v1-profile-account-groups
    guard let accountGroup = connectionSettingsAccountGroupTextfield.text, !accountGroup.isEmpty else {
      self.debugConsole.log(
        message: NSLocalizedString("services.output.account_group_required", comment: ""),
        style: .negative
      )
      return
    }
    MTLinkClient.shared.serviceSettings(
      from: self,
      animated: true,
      email: nil,
      credentialId: accountGroup
    ) { error in
      guard let error else {
        self.debugConsole.log(message: NSLocalizedString("services.output.connection_settings_opened", comment: ""))
        return
      }
      self.debugConsole.log(error: error)
    }
  }
}

// MARK: - UI

private extension ServicesViewController {
  private func setupSubviews() {
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    // Description
    let descriptionLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.description", comment: "")
    )

    // Vault
    let vaultLabel = UIComponents.titleLabel(
      title: NSLocalizedString("services.vault.title", comment: "")
    )
    let vaultSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.vault.description", comment: "")
    )

    // Service List
    let serviceListLabel = UIComponents.titleLabel(
      title: NSLocalizedString("services.list.title", comment: "")
    )
    let serviceListSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.list.description", comment: "")
    )
    let serviceListTypeFilterLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.list.select_type", comment: "")
    )
    let serviceListGroupFilterLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.list.select_group", comment: "")
    )

    let serviceListFilterStackView = UIStackView()
    serviceListFilterStackView.distribution = .fillEqually
    serviceListFilterStackView.addArrangedSubview(serviceListTypeFilterLabel)
    serviceListFilterStackView.addArrangedSubview(serviceListGroupFilterLabel)

    serviceListPicker.dataSource = self
    serviceListPicker.delegate = self

    serviceSearchTextField.placeholder = NSLocalizedString("services.list.search_placeholder", comment: "")
    serviceSearchTextField.autocapitalizationType = .none
    serviceSearchTextField.borderStyle = .roundedRect

    // Service Connection
    let serviceConnectionLabel = UIComponents.titleLabel(
      title: NSLocalizedString("services.service_connection.title", comment: "")
    )
    serviceConnectionLabel.numberOfLines = 2
    let serviceConnectionSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.service_connection.description", comment: "")
    )

    serviceConnectionEntityKeyTextField.placeholder = NSLocalizedString(
      "services.service_connection.entity_key_placeholder",
      comment: ""
    )
    serviceConnectionEntityKeyTextField.autocapitalizationType = .none
    serviceConnectionEntityKeyTextField.borderStyle = .roundedRect

    // Connection Settings
    let connectionSettingsLabel = UIComponents.titleLabel(
      title: NSLocalizedString("services.connection_settings.title", comment: "")
    )
    let connectionSettingsSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("services.connection_settings.description", comment: "")
    )

    connectionSettingsAccountGroupTextfield.placeholder = NSLocalizedString(
      "services.connection_settings.account_group_placeholder",
      comment: ""
    )
    connectionSettingsAccountGroupTextfield.autocapitalizationType = .none
    connectionSettingsAccountGroupTextfield.borderStyle = .roundedRect

    let stackView = UIStackView(frame: view.bounds)
    stackView.axis = .vertical
    stackView.spacing = 16.0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(descriptionLabel)
    stackView.setCustomSpacing(48.0, after: descriptionLabel)
    stackView.addArrangedSubview(vaultLabel)
    stackView.addArrangedSubview(vaultSubtitleLabel)
    stackView.addArrangedSubview(openVaultButton)
    stackView.setCustomSpacing(48.0, after: openVaultButton)
    stackView.addArrangedSubview(serviceListLabel)
    stackView.addArrangedSubview(serviceListSubtitleLabel)
    stackView.addArrangedSubview(serviceListFilterStackView)
    stackView.setCustomSpacing(0.0, after: serviceListFilterStackView)
    stackView.addArrangedSubview(serviceListPicker)
    stackView.setCustomSpacing(0.0, after: serviceListPicker)
    stackView.addArrangedSubview(serviceSearchTextField)
    stackView.addArrangedSubview(openServicesButton)
    stackView.setCustomSpacing(48.0, after: openServicesButton)
    stackView.addArrangedSubview(serviceConnectionLabel)
    stackView.addArrangedSubview(serviceConnectionSubtitleLabel)
    stackView.addArrangedSubview(serviceConnectionEntityKeyTextField)
    stackView.addArrangedSubview(connectServiceButton)
    stackView.setCustomSpacing(48.0, after: connectServiceButton)
    stackView.addArrangedSubview(connectionSettingsLabel)
    stackView.addArrangedSubview(connectionSettingsSubtitleLabel)
    stackView.addArrangedSubview(connectionSettingsAccountGroupTextfield)
    stackView.addArrangedSubview(serviceSettingsButton)
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

extension ServicesViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return ServiceListFilters.allCases.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch ServiceListFilters(rawValue: component) {
    case .serviceType:
      return serviceTypes.count
    case .serviceGroup:
      return serviceGroups.count
    case .none:
      fatalError("Unexpected component.")
    }
  }
}

// MARK: - UIPickerViewDelegate

extension ServicesViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView,
                  viewForRow row: Int,
                  forComponent component: Int,
                  reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.adjustsFontSizeToFitWidth = true
    switch ServiceListFilters(rawValue: component) {
    case .serviceType:
      label.text = serviceTypes[row]
    case .serviceGroup:
      label.text = serviceGroups[row]
    case .none:
      fatalError("Unexpected component")
    }
    return label
  }
}

private enum ServiceListFilters: Int, CaseIterable {
  case serviceType
  case serviceGroup
}
