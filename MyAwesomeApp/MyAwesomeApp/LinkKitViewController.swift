//
//  LinkKitViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/11/29.
//  Copyright © 2012-present Moneytree. All rights reserved.


import UIKit
import MoneytreeLINKKit

final class LinkKitViewController: UIViewController {

  // MARK: - View Properties

  private lazy var linkKitButton: UIButton = {
    let button = UIComponents.button(
      title: NSLocalizedString("link_kit.open_link_kit", comment: "")
    )
    button.addTarget(self, action: #selector(openLinkKit), for: .touchUpInside)
    return button
  }()

  // MARK: - Initialization

  private let debugConsole: DebugConsole

  init(debugConsole: DebugConsole) {
    self.debugConsole = debugConsole
    super.init(nibName: nil, bundle: nil)
    title = NSLocalizedString("link_kit.title", comment: "")
    tabBarItem.image = UIImage(systemName: "uiwindow.split.2x1")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
  }

  // MARK: - Moneytree LINK SDK

  @objc
  private func openLinkKit() {
    MTLinkKit.shared.makeViewController { viewController, error in
      guard let linkKitViewController = viewController else {
        self.debugConsole.log(error: error ?? fatalError("Expecting an error"))
        return
      }
      self.debugConsole.log(message: NSLocalizedString("link_kit.output.opened_link_kit", comment: ""))
      linkKitViewController.modalPresentationStyle = .fullScreen
      self.present(linkKitViewController, animated: true)
    }
  }
}

extension LinkKitViewController {
  private func setupSubviews() {
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    // Link Kit
    let linkKitSubtitleLabel = UIComponents.descriptionLabel(
      title: NSLocalizedString("link_kit.description", comment: "")
    )

    let stackView = UIStackView(frame: view.bounds)
    stackView.axis = .vertical
    stackView.spacing = 16.0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(linkKitSubtitleLabel)
    stackView.addArrangedSubview(linkKitButton)

    view.addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
    ])
  }
}
