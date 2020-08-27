# Moneytree Link SDK for iOS

- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
  - [CocoaPods](#cocoapods)
  - [Manual](#manual)
- [Configuration](#configuration)
  - [Configure your Xcode project](#configure-your-xcode-project)
  - [Sample XML](#sample-xml)
  - [Configure your App Delegate to handle Moneytree DeepLinks](#configure-your-app-delegate-to-handle-moneytree-deeplinks)
  - [Specific configuration per use-case](#specific-configuration-per-use-case)
- [Common Features](#common-features)
- [Change log](#change-log)
- [Migration guides](#migration-guides)

**All code snippets provided here are examples for your convenience.**

## Requirement
- The minimum iOS version supported by your app should be iOS 9.0.
- The minimum Xcode version supported for development is 11.0.

## Installation

### Swift Package Manager
**Note:** available on `Xcode 12` and above

1. In Xcode, select `File > Swift Packages > Add Package Dependency`.
1. Follow the prompts using the URL for this repository with a minimum version of v6.0.0.
1. Add the framework to the project.

### CocoaPods
**Note:** available on `Xcode 11` and above

1. At the root of your project, run `pod init`, it creates a `Podfile`.
1. Add the following to the `Podfile` and save it:

        pod 'MoneytreeLinkSDK'

1. Run the following command at the root of your project

        pod install --repo-update

1. Open `<project>`.xcworkspace.

### Manual

1. Download the latest XCFrameworks from the latest v6.0.0 release [here](https://github.com/moneytree/moneytree-link-ios-sdk/releases).
1. Drag the downloaded `.xcframework` files into your app target.
![Import XCFrameworks](./readme/images/import-xcframeworks.png)

## Configuration

### Configure your Xcode project

1. Open your project's Info.plist file
1. Add these two entries: `MoneytreeLinkClientId` and `MoneytreeLinkDevClientId`. 
    1. Both should be the type of `String`. 
    1. The values are your **Production** and **Development** Client ID respectively.
    1. The **Production** Client ID is used to connect to the `production` environment of Moneytree Link, when the SDK is configured in `production` mode. More details can be found [here]((#specific-configuration-per-use-case)).
    1. The **Development** Client ID is used to connect to the `staging` environment of Moneytree Link, when the SDK is configured in `staging` mode. More details can be found [here]((#specific-configuration-per-use-case)).
1. Add `URL types` (CFBundleURLTypes) entry **if** it is not there
1. Add 2 entries under `URL types` (CFBundleURLTypes), 1 for **Production** environment and the other one is **Development**. The URL scheme follows this convention `mtlink<#clientId#>`
1. Replace `{your-dev-client-id-first-5}` with the first 5 characters of your **Development** Client ID.
1. Replace `{your-client-id-first-5}`with the first 5 characters of your **Production** Client ID.

### Sample XML

```xml
<key>MoneytreeLinkDevClientId</key>
<string>{your-dev-client-id}</string>
<key>MoneytreeLinkClientId</key>
<string>{your-client-id}</string>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>mtlink{your-dev-client-id-first-5}</string>
    </array>
  </dict>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>mtlink{your-client-id-first-5}</string>
    </array>
  </dict>
</array>
```

### Configure your App Delegate to handle Moneytree DeepLinks

This sends OAuth redirects from the Moneytree Link authorization servers to the Moneytree Link SDK.

Import `MoneytreeLinkCoreKit` into your App Delegate and add the following:

Swift:

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
  let moneytreeLinkOpenedURL = MTLApplicationDelegate
    .shared
    .application(app, open: url, options: options)

  if moneytreeLinkOpenedURL {
    return true
  }
  // Your custom logic, if any, for handling other URL schemes goes here.
}
```

Objective-C:

```objc
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
                                         options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
  BOOL moneytreeLinkOpenedURL = [[MTLApplicationDelegate shared] application:app openURL:url options:options];

  if (moneytreeLinkOpenedURL) {
    return YES;
  }

  // Your custom logic, if any, for handling other URL schemes goes here.
```

### Specific configuration per use-case

Moneytree Link SDK has three different use cases. Please read more details about getting started for appropriate case.

- [IsshoTsucho](readme/isshotsucho.md)

  For Clients who want to use IsshoTsucho from MTLink.
- [PKCE](readme/pkce.md)

  For Clients who want to use core features from MTLink without managing authorization token. SDK manages authorization token internally.

- [Authorization code grant](readme/authorizationcode.md)

  For clients who want to manage guest authorization token on their own server. Authorization token can be used by client server to get more data from MTLink.

## Common Features
Please find the complete list of common features [here.](readme/common.md)

## Change Log
Please find the complete change logs [here.](CHANGELOG.md)

## Migration guides

### v5.x.x to v6.x.x

#### Manual integration

- Remove the imported `Moneytree*.framework`s.
- Follow the [manual steps above.](#manual)

#### Third party dependency management

- Remove the imported `Moneytree*.framework`s.
- You can use either:
  - CocoaPods, follow [these instructions.](#cocoapods)
  - Swift Package Manager, follow [these instructions.](#swift-package-manager)