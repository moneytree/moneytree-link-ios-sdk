//
//  MainViewController.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/10/18.
//  Copyright © 2012-present Moneytree. All rights reserved.


import UIKit

final class MainViewController: UITabBarController {

  // MARK: - View Properties

  private let consoleView: ConsoleView

  // MARK: - Initialization

  init(consoleView: ConsoleView) {
    self.consoleView = consoleView
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupSubviews()
  }
}

// MARK: - UI

extension MainViewController {

  private func setupTabBar() {
    viewControllers = [
      UINavigationController(rootViewController: MoneytreeIdViewController(debugConsole: consoleView)),
      UINavigationController(rootViewController: ServicesViewController(debugConsole: consoleView)),
      UINavigationController(rootViewController: LinkKitViewController(debugConsole: consoleView)),
      UINavigationController(rootViewController: OtherFunctionsViewController(debugConsole: consoleView))
    ]
    selectedIndex = 0
    tabBar.tintColor = UIColor(named: "PrimaryButtonColor")
  }

  private func setupSubviews() {
    let tabBarHeight = tabBar.frame.size.height
    consoleView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(consoleView)

    NSLayoutConstraint.activate([
      consoleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      consoleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      consoleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -tabBarHeight),
      consoleView.heightAnchor.constraint(equalToConstant: ConsoleView.height)
    ])
  }
}
