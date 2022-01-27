//
//  AppDelegate+Dependencies.swift
//  MyAwesomeApp
//
//  Created by Moneytree on 27/07/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


import Foundation
#if canImport(Firebase)
  import Firebase
#endif

// AppDelegate extension for Third Party Dependency Configurations
extension AppDelegate {
  func configureThirdPartyDependenciesIfPossible() {
    // All Firebase Dependencies are removed by fastlane script when this project is copied to the sample app repository
    #if canImport(Firebase)
      // The plist file is removed by fastlane script when this project is copied to the sample app repository
      if
        let plist = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
        let fbOption = FirebaseOptions(contentsOfFile: plist) {
        FirebaseApp.configure(options: fbOption)
      }
    #endif
  }
}
