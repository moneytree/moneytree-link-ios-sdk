// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneytreeLinkSDK",
    products: [
        .library(
            name: "MoneytreeLinkSDK",
            targets: [
              "MoneytreeIntelligence",
              "MoneytreeIsshoTsucho",
              "MoneytreeKeychainUtils",
              "MoneytreeLinkCoreKit"
            ]
        )
    ],
    targets: [
      .binaryTarget(name: "MoneytreeIntelligence", path: "Lib/MoneytreeIntelligence.xcframework"),
      .binaryTarget(name: "MoneytreeIsshoTsucho", path: "Lib/MoneytreeIsshoTsucho.xcframework"),
      .binaryTarget(name: "MoneytreeKeychainUtils", path: "Lib/MoneytreeKeychainUtils.xcframework"),
      .binaryTarget(name: "MoneytreeLinkCoreKit", path: "Lib/MoneytreeLinkCoreKit.xcframework")
    ]
)
