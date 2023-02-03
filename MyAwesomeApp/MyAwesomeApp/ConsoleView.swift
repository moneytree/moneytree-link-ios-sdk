//
//  ConsoleView.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/11/17.
//  Copyright © 2012-present Moneytree. All rights reserved.


import UIKit
import MoneytreeLinkCoreKit

final class ConsoleView: UIView {
  static let height: CGFloat = 100.0

  private let messageLabel = UILabel()
  private let dateFormatter = DateFormatter()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupSubviews() {
    backgroundColor = UIColor(named: "SecondaryBackgroundColor")

    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.text = NSLocalizedString("general.output.title", comment: "")
    titleLabel.font = .preferredFont(forTextStyle: .callout)
    titleLabel.textColor = UIColor(named: "PrimaryFontColor")

    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.font = .preferredFont(forTextStyle: .callout)
    messageLabel.textColor = UIColor(named: "PrimaryFontColor")
    messageLabel.adjustsFontSizeToFitWidth = true
    messageLabel.numberOfLines = 0
    messageLabel.accessibilityIdentifier = "outputBody"

    addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.0)
    ])

    addSubview(messageLabel)

    NSLayoutConstraint.activate([
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
      messageLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20.0),
      messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0)
    ])
  }
}

extension ConsoleView: DebugConsole {

  func log(message: String) {
    messageLabel.textColor = UIColor(named: "PrimaryFontColor")
    messageLabel.text = formatString(message)
  }

  func log(message: String, style: DebugConsoleMessageStyle) {
    switch style {
    case .negative:
      messageLabel.textColor = UIColor(named: "NegativeColor")
    }
    messageLabel.text = formatString(message)
  }

  func log(error: Error) {
    messageLabel.textColor = UIColor(named: "PrimaryFontColor")
    let nsError = error as NSError
    guard let linkError = MTLinkClientError(rawValue: nsError.code) else {
      messageLabel.text = formatString(error.localizedDescription)
      return
    }
    let errorMessage: String
    switch linkError {
    case .errorGuestCancelledAuthorization:
      errorMessage = "User cancelled authorization process."
    case .authorizationInProgress:
      errorMessage = "Authorization is in progress."
    case .errorGuestNotLinked:
      errorMessage = NSLocalizedString("error.unauthorized", comment: "")
    case .errorUnavailableInPKCEMode,
        .errorUnavailableInAuthorizationCodeGrantMode:
      errorMessage = "That operation is unavailable in this auth mode."
    case .errorUnknown:
      errorMessage = "Unknown error. Probably user closed WebView."
    @unknown default:
      errorMessage = "Unknown callback. Probably user closed WebView and it's not an issue."
    }
    messageLabel.text = formatString("\(errorMessage)\nMTLinkClientError - \(linkError.rawValue)")
  }

  private func formatString(_ message: String) -> String {
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    let timestamp = dateFormatter.string(from: Date())
    return "[\(timestamp)] \(message)"
  }
}
