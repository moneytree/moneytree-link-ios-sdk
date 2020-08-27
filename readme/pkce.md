# Moneytree Link SDK - PKCE

- [Moneytree Link SDK - PKCE](#moneytree-link-sdk---pkce)
  - [Installation and Configuration](#installation-and-configuration)
  - [Initialization](#initialization)
  - [Features available](#features-available)
    - [Authorization with PKCE](#authorization-with-pkce)
    - [Push Notifications](#push-notifications)
    - [Client Token](#client-token)
  - [Common Features](#common-features)

We've provided an example application integrating PKCE functionality. Please see `MyAwesomeApp/MyAwesomeApp.xcodeproj`.

**All code snippets provided here are examples for your convenience.**

## Installation and Configuration

**Make sure to follow every step in [Common Installation & Configuration](../README.md#Installation).**

## Initialization

Create your configuration and initialize the MoneytreeLink SDK in your app delegate.

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

let configuration = MTLConfiguration()

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

MTLConfiguration * const configuration = [[MTLConfiguration alloc] init];

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

PKCE mode presents its user interface in a SFSafariViewController presented from a viewController.

PKCE mode provides the following functionality:

### Authorization with PKCE

You can authorize your app to connect to the Moneytree Link API server via OAuth. This enables you to retrieve the guest's account information, their registered financial institutions, and transaction data via a REST API.

**Swift:**

```swift
MTLinkClient.shared.authorize(from: self, animated: true) { credential, error in
  // Store the credential, if available.
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] authorizeFrom:self animated:YES completion:^(MTOAuthCredential * _Nullable credential, NSError * _Nullable error) {
  // Store the credential, if available.
  // Handle the error, if any.
}];
```

### Push Notifications

See [Push Notifications](pushnotifications.md) for detail.

### Client Token

You can get client access token to query MTLink API using MTOAuthCredential.

**Swift:**

```swift
MTLinkClient.shared.getTokenAndRefreshAsNeeded { clientCredential: MTOAuthCredential, error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[MTLinkClient.sharedClient getTokenAndRefreshAsNeeded:^(MTOAuthCredential *clientCredential, NSError *error) {
  // Handle the error, if any.
}];
```

## Common Features

See [Common Features](common.md) available in all modes.

Back to [README Home](../README.md)
