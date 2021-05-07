//
//  Extensions.swift
//  MyAwesomeApp
//
//  Created by Moneytree KK on 8/8/18.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

import Foundation

extension Data {
  var hexEncodedString: String {
    return map { String(format: "%02x", $0) }.joined(separator: "")
  }
}
