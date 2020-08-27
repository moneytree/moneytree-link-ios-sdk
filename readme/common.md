# Moneytree Link SDK - Common Features

- [Moneytree Link SDK - Common Features](#moneytree-link-sdk---common-features)
  - [SDK Status Change](#sdk-status-change)
  - [Vault](#vault)
  - [Vault - Services that meet the options](#vault---services-that-meet-the-options)
  - [Vault - Specific Service](#vault---connect-to-a-specific-service)
  - [Vault - Settings for Specific Service](#vault---settings-for-specific-service)
  - [Vault - Customer Support](#vault---customer-support)
  - [Settings](#settings)
  - [Check Login Status](#check-login-status)
  - [Remove All Tokens](#remove-all-tokens)
  - [Logout](#logout)

## SDK Status Change

The following SDK internal status changes are communicated through this API.

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

## Vault

The guest's current balances and positions at the financial institutions they have registered with Moneytree.

Guests can register additional financial institutions.

**Swift:**

```swift
MTLinkClient.shared.openVault(from: self, animated: true, email: "sample@email.com") { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] openVaultFromViewController:self animated:YES email: @"sample@email.com" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Vault - Services that meet the options

The options should be a hashmap that contains the following
| key | sample value |
| :----: | :----: |
| group | grouping_bank |
| type | bank |
| search | aeon |

The vault will show an localised error message if the options supplied are not valid.

**Swift:**

```swift
MTLinkClient.shared.openServices(
  from: self,
  animated: true,
  email: "sample@email.com",
  options: options
) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] openServicesFromViewController:self animated:YES email:"sample@email.com" options: options completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Vault - Connect to a Specific Service

This method opens a page for connecting to a specific service.
The root of the vault would show if the `entityKey` is invalid.

**Swift:**

```swift
MTLinkClient.shared.connectService(
  from: self,
  animated: true,
  email: "sample@email.com",
  entityKey: "service entity key"
) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] connectServiceFromViewController:self animated:YES email: @"sample@email.com" entityKey: @"service entity key" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Vault - Settings for Specific Service

This method opens the settings for a specific service.
The root of the vault would show if the `credentialId` is invalid.

**Swift:**

```swift
MTLinkClient.shared.serviceSettings(
  from: self,
  animated: true,
  email: "sample@email.com",
  credentialId: credentialId.text ?? ""
) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] serviceSettingsFromViewController:self animated:YES email: @"sample@email.com" credentialId: @"service credential id" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Vault - Customer Support

**Swift:**

```swift
MTLinkClient.shared.openCustomerSupport(
  from: self,
  animated: true,
  email: "sample@email.com"
) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] openCustomerSupportFromViewController:self animated:YES email: @"sample@email.com" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Settings

The guest's Moneytree settings. Here they can manage their account information as well as other apps that are connected to Moneytree Link.

**Swift:**

```swift
MTLinkClient.shared.openSettings(from: self, animated: true) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] openSettingsFromViewController:self animated:YES completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Check Login Status

Check if a Guest is currently logged in.

**Swift:**

```swift
MTLinkClient.shared.isLoggedIn
```

**Objective-C:**

```objc
MTLinkClient.sharedClient.isLoggedIn;
```

## Remove All Tokens

Remove login session token and authorization token from Keychain if they exist.

**Swift:**

```swift
MTLinkClient.shared.removeAllTokens()

```

**Objective-C:**

```objc
[MTLinkClient.sharedClient removeAllTokens];
```

## Logout

This launches Safari to logout the guest in order to clear the cookies.

**Swift:**

```swift
MTLinkClient.shared.logout(from: self) { error in
  // Handle error if any
}
```

**Objective-C:**

```objc
[MTLinkClient.sharedClient logoutFromViewController:self completion:^(NSError * error) {
  // Handle error if any
}];
```

Back to [README Home](../README.md)
