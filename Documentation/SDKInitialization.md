# Moneytree Link iOS SDK - SDK Initialization

**All code snippets provided here are examples for your convenience.**

Please follow the steps below to initialize the Moneytree Link iOS SDK.

1. [Initialize the SDK](#initialize-the-sdk)
    1. [Create SDK Configuration (PKCE or Code Grant)](#create-sdk-configuration-pkce-or-code-grant)
        1. [PKCE](#pkce)
        2. [Code Grant](#code-grant)
    1. [Add Environment Configuration](#add-environment-configuration)
    1. [Scope Configuration](#scope-configuration)
    1. [Spin up the SDK Instance](#spin-up-the-sdk-instance)
1. [Deeplink Configuration](#deeplink-configuration)
1. [Delegate Configration(optional)](#delegate-configration-optional)

# Initialize the SDK

## Create SDK Configuration (PKCE or Code Grant)

### PKCE

Create your configuration without any argument in your app delegate.

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

// Create configration object
let configuration = MTLConfiguration()
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

// Create configration object
MTLConfiguration * const configuration = [[MTLConfiguration alloc] init];
```

### Code Grant

Create your configuration with the `redirectUri` of your code grant server as an argument in your app delegate.

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

// Create configration object
let configuration = MTLConfiguration(redirectUri: "https://your.server.com/token-exchange-endpoint")
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

// Create configration object
MTLConfiguration * const configuration = [[MTLConfiguration alloc] initWithRedirectUri:@"https://your.server.com/token-exchange-endpoint"];
```

## Add Environment Configuration

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

// Create configration object
let configuration = MTLConfiguration()

// Set environment to `.staging` for development builds or `.production` for production builds.
configuration.environment = .staging
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

// Create configration object
MTLConfiguration * const configuration = [[MTLConfiguration alloc] init];

// Set environment to `MTLEnvironmentStaging` for development builds or `MTLEnvironmentProduction` for production builds.
configuration.environment = MTLEnvironmentStaging;
```

## Scope Configuration

Recommended Scopes for features
| Feature | Recommended Scopes |
| :---: | :---:|
| Vault Access | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead |
| Customer Support | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead |
| IsshoTsucho | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead |

| Feature | Required Scopes |
| :---: | :---:|
| LINK Kit | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead, MTLClientScopeTransactionsWrite, MTLClientScopePointsRead, MTLClientScopeInvestmentAccountsRead, MTLClientScopeInvestmentTransactionsRead |

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

// Create configration object
let configuration = MTLConfiguration()

// Set environment to `.staging` for development builds or `.production` for production builds.
configuration.environment = .staging

// Configure the OAuth Scopes, below are the sample scopes
// Please refer to the table above for the recommended scopes for a specific feature
configuration.scopes = [
  MTLClientScopeGuestRead,
  MTLClientScopeAccountsRead,
  MTLClientScopeTransactionsRead
]
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

// Create configration object
MTLConfiguration * const configuration = [[MTLConfiguration alloc] init];

// Set environment to `MTLEnvironmentStaging` for development builds or `MTLEnvironmentProduction` for production builds.
configuration.environment = MTLEnvironmentStaging;

// Configure the OAuth Scopes, below are the sample scopes
// Please refer to the table above for the recommended scopes for a specific feature
configuration.scopes = @[
  MTLClientScopeGuestRead,
  MTLClientScopeAccountsRead,
  MTLClientScopeTransactionsRead
];
```

## Spin up the SDK Instance

**Swift:**

```swift
import MoneytreeLinkCoreKit

// Inside application(_:didFinishLaunchingWithOptions:)

// Create configration object
let configuration = MTLConfiguration()

// Set environment to `.staging` for development builds or `.production` for production builds.
configuration.environment = .staging

// Configure the OAuth Scopes, below are the sample scopes
configuration.scopes = [
  MTLClientScopeGuestRead,
  MTLClientScopeAccountsRead,
  MTLClientScopeTransactionsRead
]

// Spin up MTLinkClient with configuration
MTLinkClient(configuration: configuration)
```

**Objective-C:**

```objc
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

// Inside -application:didFinishLaunchingWithOptions:

// Create configration object
MTLConfiguration * const configuration = [[MTLConfiguration alloc] init];

// Set environment to `MTLEnvironmentStaging` for development builds or `MTLEnvironmentProduction` for production builds.
configuration.environment = MTLEnvironmentStaging;

// Configure the OAuth Scopes, below are the sample scopes
configuration.scopes = @[
  MTLClientScopeGuestRead,
  MTLClientScopeAccountsRead,
  MTLClientScopeTransactionsRead
];

// Spin up MTLinkClient with configuration
[MTLinkClient clientWithConfiguration: configuration];
```

# Deeplink Configuration

Configure your App Delegate to handle Moneytree DeepLinks.
This forwards the deeplink callbacks from the Moneytree Link servers to the SDK.

Swift:

```swift
import MoneytreeLinkCoreKit

//...

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
#import <MoneytreeLinkCoreKit/MoneytreeLinkCoreKit.h>

//...

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
                                         options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
  BOOL moneytreeLinkOpenedURL = [[MTLApplicationDelegate shared] application:app openURL:url options:options];

  if (moneytreeLinkOpenedURL) {
    return YES;
  }

  // Your custom logic, if any, for handling other URL schemes goes here.
```

# Delegate Configration (optional)

Please implement this delegate if your app is interested in the following SDK internal status changes.

| Status | Value |
| :----: | :---: |
| vaultDidClose | 1 |

**Swift:**

```swift
class AppDelegate: MTLinkClientDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let mtLinkClient = MTLinkClient(configuration: <your SDK configuration>)
    mtLinkClient.delegate = self

    return true
  }


  func clientStatusDidChange(to status: MTLinkClientStatus) {
    // Handle status change
  }
}
```

**Objective-C:**

```objc
// In .h file
@interface AppDelegate : UIResponder <UIApplicationDelegate, MTLinkClientDelegate>

// In .m file
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  MTLinkClient *client = [MTLinkClient clientWithConfiguration: configuration];
  client.delegate = self;

  return YES;
}

-(void)clientStatusDidChangeToStatus:(MTLinkClientStatus)status {
  // Handle status change
}
```