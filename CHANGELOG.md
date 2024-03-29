# Changelog

All notable changes to the Moneytree Link iOS SDK will be documented in this file.

## v6.4.5

- Added Privacy Manifests to each SDK module, per [Apple's requirements for Spring 2024](https://developer.apple.com/news/?id=r1henawx) 

## v6.4.4

- No changes to the SDK.
- Made corrections to text in our sample application, "AwesomeApp."

## v6.4.3

- No changes to the SDK.
- Made corrections to text in our sample application, "AwesomeApp."

## v6.4.2

Fixed an issue that generated network warning logs when fetching a token.

## v6.4.1

This version fixes an issue where exiting the Vault while using a LINK Kit session would not update the LINK Kit screen.

## v6.4.0

We have introduced a new authentication configuration parameter that will allow you to choose your authentication method (Authentication, Passwordless, Single Sign On) when the Moneytree authentication web page shows. This configuration does _not_ guarantee that the selected mode will be the one presented as the feature relies on the configuration of the client ID provided to you.

If you do not provide the new configuration, the default order of available methods configured in you client ID will be used.

For more on the feature and how it works, please refer to [Choosing your Authentication method](./Documentation/Features.md#choosing-your-authentication-method).

### Added

- `MTLAuthenticationMethod`
- `MTLConfiguration.authenticationMethod`

### Deprecated

`MTLinkAuthOptions` - Please use MTLAuthenticationOptions instead, which supports new features, including setting your authentication method.

`MTLAuthenticationOptions.options(mode:allowModeChange:region:email:forceLogout:)`
`MTLAuthenticationOptions.options(mode:allowModeChange:regionType:email:forceLogout:)`

Please use `MTLAuthenticationOptions.options(mode:allowModeChange:email:forceLogout:)` instead. Setting the region is no longer necessary.

## v6.3.2

- Added additional scope, MTLClientScopeRequestRefresh, to LINK Kit.

## v6.3.1

- Improved handling of app revocation for LINK Kit. If an end user has revoked authorization for your application, instead of returning an error, LINK Kit will automatically give the user an opportunity to re-authenticate and re-authorize. This reduces the need for error handling for LINK Kit implementations.

## v6.3.0

- Code Grant without PKCE is not supported anymore. It will be removed in the next major version. Please see the migration guide at https://docs.link.getmoneytree.com/docs/migrate-auth-to-pkce  

### Added

`MTLinkClient -authorizeFrom:options:animated:completion:`
`MTLinkClient -onboardFrom:email:animated:completion:`
`MTAPI -sendRequest:`
`MTAPI -sendRequestForSwift:`

### Deprecated

`MTLinkClient -authorizeUsingPkceFrom:options:animated:completion:`
`MTLinkClient -authorizeUsingCodeGrantFrom:options:animated:completion:`
`MTLinkClient -onboardFrom:authorizationType:email:state:region:animated:completion:`
`MTAPI -sendAuthenticatedRequest:`
`MTAPI -sendAuthenticatedRequestForSwift:`

## v6.2.1
- Remove unnecessary Core Data model file from sample app.
- Fix an issue where passwordless features would not be enabled for applications built with Xcode 13.

## v6.2.0
- Support upgrading from Issho Tsucho (SDKs v4, v5) to LINK Kit without user needing to log in again. It will only ask for the new consent scopes required.
- Small improvements to documentation and sample app.

## v6.1.2

- Support running the sample app with Xcode 13.
- Cleaned up some unnecessary files and configuration from the sample app.

## v6.1.1

- Improved documentation around Settings feature, fixed broken documentation link.
- Fixes an issue with token storage when using LINK API.
- Fixes an issue with OAuth including unnecessary parameters.
- Fixes an issue with token storage when migrating from an earlier version of the SDK.
- Discontinued unused Cocoapods distribution.

## v6.1.0

- Improved documentation
- Renamed "Magic Link" feature to "Login Link"

### Added

`MTLinkClient -requestForLoginLinkForEmail:to:completion`

### Deprecated

`MTLinkClient -requestForMagicLinkForEmail:to:completion`

### Changed

The `MTLinkClientError` enum is now of type `NSInteger`, rather than `NSUInteger`, to match the standard convention of error codes. 

## v6.0.2

### Breaking Changes

- Discontinued the `MoneytreeIntelligence` framework. This has no impact on clients who were not using the framework.

## v6.0.0

### Breaking Changes

- Please use Xcode 12.0 or above.
- The SDK is now packaged using `xcframework`. It is no longer necessary to strip framework architectures built for the simulator from the SDK.
- The SDK is now distributed through `Swift Package Manager` and `Cocoapods`. Please refer to the README file for the updated integration guide.
- Discontinued the  `MoneytreeIsshoTsucho` framework in favor of a new framework, `MoneytreeLINKKit`. The class `MTIsshoTsucho` has similarly been renamed to `MTLinkKit`.

### Removed

- Removed `openVaultFromViewController:animated:completion:` in the MTLinkClient. 
  - Please call `openVaultFromViewController:animated:email:completion:` instead.
- Removed `openServicesFromViewController:animated:options:completion:` in the MTLinkClient.
  - Please call `openServicesFromViewController:animated:email:options: completion:` instead.
- Removed `connectServiceFromViewController:animated:entityKey:completion:` in the MTLinkClient.
  - Please call `connectServiceFromViewController:animated:email:entityKey:completion:` instead.
- Removed `serviceSettingsFromViewController:animated:credentialId:completion:` in the MTLinkClient.
  - Please call `serviceSettingsFromViewController:animated:email:credentialId:completion:` instead.
- Removed `openCustomerSupportFromViewController:animated:completion:` in the MTLinkClient.
  - Please call `openCustomerSupportFromViewController:animated:email:completion:` instead.
- Removed `isTestEnvironment` in `MTLConfiguration`.
  - Please use `environment` in `MTLConfiguration` instead.
- Removed `hasAccessToken` in the MTLinkClient.
  - Please use `isLoggedIn` instead.
- Removed `isTestEnvironment` in the MTLinkClient.
  - Please use `currentEnvironment` instead.
- Removed `makeViewControllerWithCompletion:` from MTLinkKit. (Formerly MTIsshoTsucho.)
  - Please use `makeLinkKitViewController:` instead.

### Added

- Added support for our new product, LINK Kit, which replaces Issho Tsucho. Please refer to the LINK Kit documentation.
- Added additional `MTLClientScope`s, listed here:
  - MTLClientScopeGuestRead
  - MTLClientScopeAccountsRead
  - MTLClientScopeTransactionsRead
  - MTLClientScopeTransactionsWrite
  - MTLClientScopeCategoriesRead
  - MTLClientScopeInvestmentAccountsRead
  - MTLClientScopeInvestmentTransactionsRead
  - MTLClientScopeRequestRefresh
  - MTLClientScopePointsRead
  - MTLClientScopePointTransactionsRead
  - MTLClientScopeNotificationsRead
- Added Onboarding and Magic Link features to simplify the sign up and login process.

## v5.3.1

### Fixed

- Fix crash on `openServices(viewController:animated:email:options:completion)` where `options` value contains characters that are not URL safe.

## v5.3.0

### Added

- Added `MTLinkClientDelegate` to notify the client app about SDK internal state changes (vault closed event only for now, more to come)
- Added email pre-fill capability when opening the vault

## v5.2.0

### Added

- Added `openCustomerSupport()` to open Vault page and trigger Customer Support
- Added `openServices()` to show the list of services on Vault
- Added `connectService()` to open the Connect Service page for a specified service on Vault.
- Added `serviceSettings()` to open the service Connection Settings page on Vault

## v5.1.0

- Bug fixes and performance improvements

## v5.0.0

### Added

- Show renewed Vault page when calling `openVault`
- Show renewed Account settings page when calling `openSettings`

### Breaking changes

- Changed the type of `completion` in `openVaultFromViewController:animated:completion:` from `MTLinkClientCredentialFetchCompletionBlock` to `MTLinkCompletionBlock`. In case the `access token` is needed, please call `getTokenAndRefreshAsNeeded`.
- Changed the behavior of the completion handler of `openVaultFromViewController:animated:completion:`. It now triggers when the vault is `opened` rather than `closed`. Please utilise MTLinkClientDelegate if your application needs to be notified when the vault is closed.
- A login state at the new Account Settings page depends on cookies Safari has. So guests might see login screen when Safari doesn't have a valid session cookie.
- Use `MTLAuthenticationOptions` instead of `MTLinkAuthOptions`. This class adds support for:
  - Pre-selecting a user's country
  - Disabling the button to switch between Login and Sign Up

## v4.1.3

### Fixed

- Handle login or signup email correctly

## v4.1.2

### Fixed

- Sign up page is shown when `signup = true`
- Login page back button shows correct URL

## v4.1.1

### Added

- Supports prefilling email for login or signup using ```MTLinkAuthOptions```

### Removed

- Connect Institution API is removed

## v4.1.0

- Release skipped due to technical issues.

## v4.0.0

### Added

- Supported Authorization code grant flow.

### Breaking changes for clients using PKCE

- SDK must be initialized using ```MTLinkClient.clientWithConfiguration```
  - ```MTLinkClient.clientWithConfiguration``` must be called only once in a session.
  - Use ```MTLinkClient.sharedClient``` afterwards
- ```MTLinkClient.sharedClient.isLoggedIn``` only checks if the login session exists. It doesn't guarantee that the guest has successfully authorized.
- ```MTLinkClient.sharedClient.delegate``` is no longer available.
- ```MTLinkClient.sharedClient.datasource``` is no longer available.
- ```MTLinkClient.sharedClient.removeAllTokens``` only removes all tokens from the Keychain that are stored by the SDK. It no longer deregisters the push notification token. Please deregister the push token before calling ````removeAllTokens```` using ```MTLinkClient.sharedClient.api```.
- Since ```MTLinkClient.sharedClient.delegate``` is no longer available, Clients should always check login status inside closures, which are always called when Safari is dismissed. This is because the guest might logout while Safari is open.

```swift
    MTLinkClient.shared.openVault(from: self, animated: true) { _, _ in
      if MTLinkClient.shared.isLoggedIn == false {
        // Show logout state
      }
    }

    MTLinkClient.shared.openSettings(from: self, animated: true) { _ in
      if MTLinkClient.shared.isLoggedIn == false {
        // Show logout state
      }
    }
```
