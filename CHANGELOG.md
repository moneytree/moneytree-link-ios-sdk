# Changelog

All notable changes to the Moneytree Link iOS SDK will be documented in this file.

## v6.0.0

### Breaking Changes

- From 6.0.0, our SDK is packaged using `xcframework` which only supports Xcode 11 and above.
- From 6.0.0, our SDK is distributed through `Swift Package Manager` and `Cocoapods`. Please refer to [readme](README.md#Installation) for the updated integration guide.

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

### Added

- Added LINK Kit support under the Isshotsucho Module. Please refer to [IsshoTsucho Documentation](readme/isshotsucho.md#link-kit).
- Added more `MTLClientScope`, please find the list of the supported scopes below
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

- A type of `completion` in `openVaultFromViewController:animated:completion:` changed to `MTLinkCompletionBlock` from `MTLinkClientCredentialFetchCompletionBlock`. You have to call `getTokenAndRefreshAsNeeded` whenever you want an `accessToken`.
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

- Supported [Authorization code grant](readme/authorizationcode.md) flow

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