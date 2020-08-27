# Moneytree Link SDK - IsshoTsucho

- [Moneytree Link SDK - IsshoTsucho](#moneytree-link-sdk---isshotsucho)
  - [Installation and Configuration](#installation-and-configuration)
    - [Add the Issho Tsucho framework to your project](#add-the-issho-tsucho-framework-to-your-project)
    - [Initialization](#initialization)
  - [Features available](#features-available)
  - [IsshoTsucho](#isshotsucho)
    - [Push Notifications](#push-notifications)
    - [Client Token](#client-token)
  - [Common Features](#common-features)

We've provided an example application integrating Issho Tsucho functionality. Please see `MyAwesomeApp/MyAwesomeApp.xcodeproj`.

**All code snippets provided here are examples for your convenience.**

## Installation and Configuration

### Add the Issho Tsucho framework to your project

1. **Make sure to follow every step in [Common Installation & Configuration](../README.md#Installation).**
2. Make sure the ```MoneytreeIsshoTsucho.framework``` file is located in either the same directory as the Xcode project file or a subdirectory.
3. Open your application's Xcode project.
4. Drag the ```MoneytreeIsshoTsucho.framework``` file into the Frameworks group of Xcode's Project Navigator. In the displayed dialog, choose Create groups for any added folders and deselect Copy items into destination group's folder. This references the SDK where you installed it rather than copying the SDK into your app.
5. Open up the Project's build phases and select MoneytreeIsshoTsucho.framework in `Copy Files`

### Initialization

Create your configuration and initialize the MoneytreeLink SDK in your app delegate.

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

let configuration = MTLConfiguration()

// Set environment to `.staging` for development builds or `.production` for production builds.
configuration.environment = .staging

// If you are using Issho Tsucho, do _not_ configure scopes.

// Initialize MTLinkClient with configuration
MTLinkClient(configuration: configuration)
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

MTLConfiguration *const configuration = [[MTLConfiguration alloc] init];

// Set environment to `MTLEnvironmentStaging` for development builds or `MTLEnvironmentProduction` for production builds.
configuration.environment = MTLEnvironmentStaging;

// If you are using Issho Tsucho, do _not_ configure scopes.

// Initialize MTLinkClient with configuration
[MTLinkClient clientWithConfiguration:configuration];
```

## Features available

IsshoTsucho SDK provides the following functionality:

- [IsshoTsucho](#isshotsucho)
- [LINK Kit](#link-kit)
- [Push Notifications](#push-notifications)
- [Client Token](#client-token)
- [Common Features](#common-features)

## IsshoTsucho

IsshoTsucho is a UIViewController that you must present in your app.

Import `MoneytreeIsshoTsucho` in the file responsible for presenting it.

**Swift:**

```swift
MTIsshoTsucho.shared.makeViewController { viewController, error in
  guard let viewController = viewController else {
    // Handle the error, if any.
    return
  }
  self.navigationController?.pushViewController(viewController, animated: true)
}
```

**Objective-C:**

```objc
[[MTIsshoTsucho shared] makeViewController:^(UIViewController *_Nullable viewController, NSError *_Nullable error) {
  if (viewController == nil) {
    return;
  }
  [self.navigationController pushViewController:viewController animated:YES];
}];
```

## LINK Kit

LINK Kit is a UIViewController that you must present in your app.

Import `MoneytreeIsshoTsucho` in the file responsible for presenting it.

**Swift:**

```swift
MTIsshoTsucho.shared.makeLinkKitViewController { viewController, error in
  guard let viewController = viewController else {
    // Handle the error, if any.
    return
  }
  self.navigationController?.pushViewController(viewController, animated: true)
}
```

**Objective-C:**

```objc
[[MTIsshoTsucho shared] makeLinkKitViewController:^(UIViewController *_Nullable viewController, NSError *_Nullable error) {
  if (viewController == nil) {
    return;
  }
  [self.navigationController pushViewController:viewController animated:YES];
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

See also [Common Features](common.md) available in all modes.

Back to [README Home](../README.md)
