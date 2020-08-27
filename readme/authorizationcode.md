# Moneytree Link SDK - Authorization Code

- [Moneytree Link SDK - Authorization Code](#moneytree-link-sdk---authorization-code)
  - [Installation and Configuration](#installation-and-configuration)
    - [Initialization](#initialization)
  - [Features available](#features-available)
    - [Authorization API Code Grant](#authorization-api-code-grant)
  - [Common Features](#common-features)

We've provided an example application `MyAwesomeApp/MyAwesomeApp.xcodeproj` integrating Authorization code grant mode functionality.
Example app runs in PKCE authorization mode as default. However we can change following line to check Authorization code grant demo.
Find following code in Sample app `ViewController.swift`

```swift
let demoMode: DemoMode = .pkce
```

change above line to following:

```swift
let demoMode: DemoMode = .authCodeGrant
```

**All code snippets provided here are examples for your convenience.**

## Installation and Configuration

**Make sure to follow every step in [Common Installation & Configuration](../README.md#Installation).**

### Initialization

Create your configuration and initialize the MoneytreeLink SDK in your app delegate.

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

let configuration = MTLConfiguration(redirectUri: "https://your.server.com/token-exchange-endpoint")

// Set environment to `.staging` for development builds or `.production` for production builds.
configuration.environment = .staging

configuration.scopes = [
  MTLClientScopeGuestRead,
  MTLClientScopeAccountsRead,
  MTLClientScopeTransactionsRead
]

// Initialize MTLinkClient with configuration
MTLinkClient(configuration: configuration)
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

MTLConfiguration * const configuration = [[MTLConfiguration alloc] initWithRedirectUri:@"https://your.server.com/token-exchange-endpoint"];

// Set environment to `MTLEnvironmentStaging` for development builds or `MTLEnvironmentProduction` for production builds.
configuration.environment = MTLEnvironmentStaging;

configuration.scopes = @[
  MTLClientScopeGuestRead,
  MTLClientScopeAccountsRead,
  MTLClientScopeTransactionsRead
];

// Initialize MTLinkClient with configuration
[MTLinkClient clientWithConfiguration: configuration];
```

## Features available

Authorization code grant mode presents its user interface in a SFSafariViewController presented from a viewController.

Authorization code grant mode provides the following functionality:

### Authorization API Code Grant

You can authorize your app to connect to the Moneytree Link API server via sdk-clientServer OAuth. This enables you to retrieve the guest's account information, their registered financial institutions, and transaction data via a REST API.

**Swift:**

```swift
let mtLinkClient = MTLinkClient.shared
mtLinkClient.authorize(
  from: self,
  presentSignUp: false,
  state: MTOAuthHelpers.makeNonce() ?? "Provide Random state",
  animated: true
) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] authorizeFrom:self
                             presentSignUp:NO
                                     state:@"random Genenrated state"
                                  animated:YES completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Common Features

See also [Common Features](common.md) available in all modes.

Back to [README Home](../README.md)
