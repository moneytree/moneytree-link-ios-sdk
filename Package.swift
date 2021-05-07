// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoneytreeLinkSDK",
    products: [
        .library(
            name: "MoneytreeLinkSDK",
            targets: [
              "MoneytreeLINKKit",
              "MoneytreeKeychainUtils",
              "MoneytreeLinkCoreKit"
            ]
        )
    ],
    targets: [
      .binaryTarget(name: "MoneytreeLINKKit", path: "Lib/MoneytreeLINKKit.xcframework"),
      .binaryTarget(name: "MoneytreeKeychainUtils", path: "Lib/MoneytreeKeychainUtils.xcframework"),
      .binaryTarget(name: "MoneytreeLinkCoreKit", path: "Lib/MoneytreeLinkCoreKit.xcframework")
    ]
)
