//
//  UIComponents.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/11/17.
//  Copyright © 2012-present Moneytree. All rights reserved.


import UIKit

struct UIComponents {
  static func button(title: String) -> UIButton {
    return button(
      title: title,
      titleColor: UIColor(named: "PrimaryButtonFontColor"),
      backgroundColor: UIColor(named: "PrimaryButtonColor")
    )
  }

  static func negativeButton(title: String) -> UIButton {
    return button(
      title: title,
      titleColor: UIColor(named: "PrimaryButtonFontColor"),
      backgroundColor: UIColor(named: "NegativeColor")
    )
  }

  static func titleLabel(title: String) -> UILabel {
    return UIComponents.label(title: title, textStyle: .title1)
  }

  static func descriptionLabel(title: String) -> UILabel {
    let label = UIComponents.label(title: title, textStyle: .callout)
    label.numberOfLines = 0
    return label
  }

  private static func label(title: String, textStyle: UIFont.TextStyle) -> UILabel {
    let label = UILabel()
    label.text = title
    label.textColor = UIColor(named: "PrimaryFontColor")
    label.font = .preferredFont(forTextStyle: textStyle)
    return label
  }

  private static func button(title: String, titleColor: UIColor?, backgroundColor: UIColor?) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.layer.cornerRadius = 20.0
    button.setTitleColor(titleColor, for: .normal)
    button.backgroundColor = backgroundColor
    button.contentEdgeInsets = .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    return button
  }
}
