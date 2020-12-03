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
1. [Universal Link Configuration](#universal-link-configuration)
1. [Delegate Configuration(optional)](#delegate-configuration-optional)

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
### All Available Scopes
| Scope | Description |
| :---: | :---:|
| MTLClientScopeGuestRead | Access to basic account information. |
| MTLClientScopeAccountsRead | Access to read personal account balances and information. |
| MTLClientScopeTransactionsRead | Access to read personal account transactions. |
| MTLClientScopeTransactionsWrite | Access to write personal account transactions. |
| MTLClientScopeCategoriesRead | Access to read transaction categories. |
| MTLClientScopeInvestmentAccountsRead | Access to read investment account balances and information. |
| MTLClientScopeInvestmentTransactionsRead | Access to read investment account transactions. |
| MTLClientScopeRequestRefresh | Allows your application to manually request Moneytree to retrieve up-to-date user data from financial institutions. |
| MTLClientScopePointsRead | Access to read point account information. |
| MTLClientScopePointTransactionsRead | Access to read point account transactions. |
| MTLClientScopeNotificationsRead | Access to read notification information. |

### Recommended Scopes for features
| Feature | Recommended Scopes |
| :---: | :---:|
| Vault Access | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead |
| Customer Support | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead |
| IsshoTsucho | MTLClientScopeGuestRead, MTLClientScopeAccountsRead, MTLClientScopeTransactionsRead |

### Required Scopes for features
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

# Universal Link Configuration

This allows the SDK to handle the universal links sent from the Moneytree Link server. This feature is currently used for 		
- Handling magic links for Moneytree Link log in.
- Opening Moneytree Link Account setting. 
  
**NOTE:** Please make sure you `apple-app-site-association` is properly hosted, if you are not sure, please contact Moneytree.		
  
Import `MoneytreeLinkCoreKit` into your App Delegate and add the following:

**Swift:**
  
```swift
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
  let canMoneytreeHandleUserActivity = MTLApplicationDelegate.shared.application(application, userActivity: userActivity) { error in
    // Handle universal link handling result/error if necessary
  }
  
  // If Moneytree cannot handle this user activity, check if other party can
  return canMoneytreeHandleUserActivity
}
```
  
**Objective-C:**

```objc
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
  BOOL canMoneytreeHandleUserActivity = [[MTLApplicationDelegate shared] application:application userActivity:userActivity completion:^(NSError *_Nullable error) {
    // Handle universal link handling result/error if necessary
  }];
  
  // If Moneytree cannot handle this user activity, check if other party can
  return canMoneytreeHandleUserActivity
}
```

# Delegate Configuration (optional)

Please implement this delegate if your app is interested in the following SDK internal status changes.

| Status | Value | Error |
| :----: | :---: | :---: |
| error | 0 | contains error  |
| vaultDidClose | 1 | doesn't contain error (always nil) |
| newCredentialAddedViaThirdPartyOauth | 2 | doesn't contain error (always nil) |

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