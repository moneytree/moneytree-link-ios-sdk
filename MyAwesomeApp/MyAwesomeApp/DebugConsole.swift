//
//  DebugConsole.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 2022/11/17.
//  Copyright © 2012-present Moneytree. All rights reserved.


import Foundation

enum DebugConsoleMessageStyle {
  case `negative`
}

protocol DebugConsole {
  func log(message: String)
  func log(message: String, style: DebugConsoleMessageStyle)
  func log(error: Error)
}
