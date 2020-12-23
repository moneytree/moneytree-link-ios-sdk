# Using the SDK

This documentation contains the list of features that are available in the Moneytree LINK iOS SDK, and how they can be integrated into your mobile app.

Please make sure you have followed the steps in the [integration guide](../README.md#integration-guide) to configure your project and initialize the SDK before using any features of the SDK.

- [Authorization](#authorization)
  - [Authorizing your app](#authorizing-your-app)
  - [Authorizing with Onboarding and Magic Link](#authorizing-with-onboarding-and-magic-link)
  - [Getting an Access Token](#getting-an-access-token)
  - [Check Login Status](#check-login-status)
  - [Removing authorization or logging out](#removing-authorization-or-logging-out)
- [Connected Services (Vault)](#connected-services-vault)
  - [Vault home page](#vault-home-page)
  - [Filter services](#filter-services)
  - [Connect to a service](#connect-to-a-service)
  - [Navigate to a connected service](#navigate-to-a-connected-service)
  - [Customer support](#customer-support)
- [Account Management](#account-management)
  - [Open Account Settings](#open-account-settings)
  - [Navigate to settings using Magic Link](#navigate-to-a-specific-setting-using-magic-link) 
- [LINK Kit](#link-kit)
- [Push Notification](#push-notification)

# Authorization

The first step to using the SDK is for your user to authorize your app to access their Moneytree data. They must log into Moneytree or register a new account, and grant consent to your app for the requested scopes, which will provide you with an access token.

## Authorizing your app

First, create an instance of `MTLinkAuthOptions`. Here you decide whether you want to show the sign up or log in page, and can provide your customer's email address to help speed up the process. 

You can also optionally force a log out of all existing sessions before logging in the user, if you are encountering caching issues.

**Swift:**

```swift
let authOption = MTLinkAuthOptions.authOption(showSignUp: false, guestEmail: "your-email@example.com")

// Optional:
authOption.useForceLogout = true
```

**Objective-C:**

```objc
MTLinkAuthOption *authOption = [MTLinkAuthOptions authOptionWithShowSignUp:NO guestEmail:@"your-email@example.com"];

// Optional:
authOption.useForceLogout = YES;
```

You can authorize your app to connect to the Moneytree LINK API server via PKCE or Code Grant OAuth flows. This enables you to retrieve the guest's account information, their registered financial institutions, and transaction data via Moneytree LINK REST APIs.

The OAuth flow is presented in an `SFSafariViewController`.

### PKCE

**Swift:**

```swift
MTLinkClient.shared.authorizeUsingPkce(from: self, authOptions: authOption, animated: true) { credential, error in
  // Store the credential, if available.
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] authorizePkceFrom:self authOptions: authOption animated:YES completion:^(MTOAuthCredential * _Nullable credential, NSError * _Nullable error) {
  // Store the credential, if available.
  // Handle the error, if any.
}];
```

### Code Grant

Similar to PKCE flow above, but the authorization method also requires a state string for the OAuth process. This state needs to be unique per request. For more information refer to [the OAuth guidelines](https://www.oauth.com/oauth2-servers/server-side-apps/authorization-code/).

**Swift:**

```swift
MTLinkClient.shared.authorizeUsingCodeGrant(
  from: self,
  state: "<your-random-state-string>",
  authOptions: authOption,
  animated: true
) { error in
  // Handle the error, if any.
} 
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] 
    authorizeUsingCodeGrantFrom:self 
    state: @"<your-random-state-string>" 
    authOptions: authOption 
    animated:YES 
    completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Authorizing with Onboarding and Magic Link

Onboarding and Magic Link are new features offered in v6 in order to allow your customers easier access to Moneytree services. If you plan to take advantage of these features, please contact us to support you in configuring these features.

These features are email based. When Onboarding is requested, the user will receive a one-time url capable of creating an account. When a Magic Link is requested, will receive a one-time url that can log them in or navigate to their account settings.

> :warning: Configuring universal link support is required for these features. Please refer to [the documentation for universal link configuration](../../README.md#configuring-universal-links-for-navigation).

### Onboarding

Onboarding is similar to [authorizing your app normally](#authorizing-your-app) except that it allows guests to sign up for a Moneytree account **without a password**. Only an email address is required.    

#### PKCE

**Swift:**    

```swift    
MTLinkClient.shared.onboard(
  from: self,
  authorizationType: .PKCE,
  email: "guest's email",
  state: nil,
  region: .japan,
  animated: true
) { credential, error in
  // Handle credential or error if necessary    
}    
```

Objective-C:    

```objc    
[[MTLinkClient sharedClient] onboardFrom:self
                      authorizationType:MTLinkAuthorizationTypePKCE
                                  email:@"guest's email"
                                  state:nil
                                region:MTAuthRegionJapan
                              animated:YES
                            completion:^(MTOAuthCredential *_Nullable credential, NSError *_Nullable error) {
  // Handle credential or error if necessary
}];    
```

#### Code Grant

**Swift:**

```swift    
MTLinkClient.shared.onboard(
  from: self,
  authorizationType: .codeGrant,
  email: "guest's email",
  state: "random Genenrated state",
  region: .japan,
  animated: true
) { _, error in
  // Handle result/error if necessary
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] onboardFrom:self
                       authorizationType:MTLinkAuthorizationTypeCodeGrant
                                   email:@"guest's email"
                                   state:@"random Genenrated state"
                                  region:MTAuthRegionJapan
                                animated:YES
                              completion:^(MTOAuthCredential *_Nullable credential, NSError *_Nullable error) {
  // Handle the error, if any.
}];
```

### Magic Link

Your users may choose to use the Magic Link to log into an existing account after you have requested authorization via the SDK. If your app supports universal links from the SDK, as noted above, no additional code is necessary to support this. You may also wish to support [navigating to Account Settings via Magic Link](./MyAccount.md/#magic-link-api). 

## Getting an Access Token

> :warning: This functionality is only available when using the PKCE OAuth flow.

Once you have authorized via PKCE, you can obtain an access token to query data from the Moneytree LINK REST API depending on what scopes you have configured.

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

## Check Login Status

**Swift:**

```swift
MTLinkClient.shared.isLoggedIn
```

**Objective-C:**

```objc
MTLinkClient.sharedClient.isLoggedIn;
```

## Removing authorization or logging out

You might need to logout your user from the Moneytree services or clear the tokens the SDK is holding. For that we provide the following functions:

`removeAllTokens` removes any saved tokens from encrypted storage.
`logoutFromViewController:completion:`/`logout(from:completion:)` launches an in-app browser flow calling our services to log out and clear all browser sessions. It then calls `removeAllTokens` internally.

> :warning: `removeAllTokens` does not clear the user's logged in state from the browser session. It simply deletes the access token the SDK holds. If you try to authorize again and the browser session has not expired you will not go through the login page. A new token will be provided for the SDK to store.

# Connected Services (Vault)

This documentation contains the list of features that are available in the Moneytree LINK iOS SDK related to `Connected Services (Vault)`, and how they can be integrated into your mobile app.

**NOTE:** If the user chooses to add a new credential in the vault that requires a redirection to the financial institution's website (3rd party oauth), the vault closes itself and the SDK redirects the user in an external browser. Once the user completes adding the credential, a `newCredentialAddedViaThirdPartyOauth` state is sent via a callback to the [`MTLinkClientDelegate`](../README.md#configuring-the-mtlinkclientdelegate-optional). Your app can react as you see fit. For example, refresh the data or open the vault again.

## Vault home page

The list of financial institutions that your user has registered with Moneytree.

Users can register additional financial institutions from within the Vault.

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

## Filter services

Shows a list of services available in the Vault that meet the filter options. The options are a dictionary that may contain the following keys and values:

| key | values |
| :----: | :----: |
| group | grouping_bank, grouping_bank_credit_card, grouping_bank_dc_card, grouping_corporate_credit_card, grouping_credit_card, grouping_credit_coop, grouping_credit_union, grouping_dc_pension_plan, grouping_debit_card, grouping_digital_money, grouping_ja_bank, grouping_life_insurance, grouping_point, grouping_regional_bank, grouping_stock, grouping_testing |
| type | bank (personal bank), credit_card (personal credit card), stored_value (electronic money), point (loyalty point), corporate (corporate bank or corporate card) |
| search | a string to search against |

The Vault will show an localized error message if the options supplied are not valid.

**Swift:**

```swift
MTLinkClient.shared.openServices(from: self, animated: true, email: "sample@email.com", options: options) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] openServicesFromViewController:self animated:YES email:"sample@email.com" options: options completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Connect to a service

This opens a page for connecting to a specific service. Please consult with us if you need help getting the correct entity key for an institution.

If the `entityKey` is invalid, it will just navigate to the home page of the Vault.

**Swift:**

```swift
MTLinkClient.shared.connectService(from: self, animated: true, email: "sample@email.com", entityKey: "key") { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] connectServiceFromViewController:self animated:YES email: @"sample@email.com" entityKey: @"service entity key" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Navigate to a connected service

This opens the settings for a specific service that the user has already connected to. Please consult with us if you need help getting the correct credential ID for a connected service.

If the `credentialId` is invalid, it will just navigate to the home page of the Vault.

**Swift:**

```swift
MTLinkClient.shared.serviceSettings(from: self, animated: true, email: "sample@email.com", credentialId: id) { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] serviceSettingsFromViewController:self animated:YES email: @"sample@email.com" credentialId: @"service credential id" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

## Customer support

Navigates to Moneytree Customer Support.

**Swift:**

```swift
MTLinkClient.shared.openCustomerSupport(from: self, animated: true, email: "sample@email.com") { error in
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
[[MTLinkClient sharedClient] openCustomerSupportFromViewController:self animated:YES email: @"sample@email.com" completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

# Account Management

This documentation contains the list of features that are available in the Moneytree Link iOS SDK related to `User Account Management`, and how they can be integrated into your mobile app.

## Open Account Settings

Open the user's Moneytree account settings. Here they can manage their account information as well as other apps that are connected to Moneytree Link.

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

## Navigate to settings using Magic Link

Asks the server to send a magic link to the guests' email that navigates the user to the specified destination in Moneytree settings. 
    
> :warning: Configuring universal link support is required for this feature. Please refer to [the documentation for universal link configuration](../../README.md#configuring-universal-links-for-navigation).

| Destination | Objective-C | Swift |
| :----: | :---: | :---: |
| Main settings page | MTMagicLinkDestinationSettings | .settings |
| Select the language to use in Moneytree services | MTMagicLinkDestinationChangeLanguage | .changeLanguage |
| Delete Moneytree account | MTMagicLinkDestinationDeleteAccount | .deleteAccount |
| View and edit applications authorized to connect to Moneytree services | MTMagicLinkDestinationAuthorizedApplications | .authorizedApplications |
| View and edit preferences for receiving emails from Moneytree | MTMagicLinkDestinationEmailPreferences | .emailPreferences |
| Update email address for Moneytree services | MTMagicLinkDestinationUpdateEmail | .updateEmail |
| Update password for Moneytree services | MTMagicLinkDestinationUpdatePassword | .updatePassword |
    
**Swift:**
    
```swift
MTLinkClient.shared.requestForMagicLink(forEmail: "email@addr.ess", to: .settings) { error in
  // Handle the error if necessary
}
```

**Objective-C:**
    
```objc
[[MTLinkClient sharedClient] requestForMagicLinkForEmail:@"email@addr.ess"     
                                                      to:MTMagicLinkDestinationSettings     
                                              completion:^(NSError * _Nullable error) {    
  // Handle the error if necessary    
}];    
```

# LINK Kit

LINK Kit is hosted in a UIViewController that you can present in your app. If you are using LINK Kit, [you must be using PKCE for authorization](./Authorization.md/#pkce).

Import `MoneytreeLinkKit` in the file responsible for presenting it.

Please make sure the scope configuration matches what is mentioned [here](../../README.md#configuring-scopes).

> :warning: Currently LINK Kit **does not** support Onboarding.

**Swift:**

```swift
MTLinkKit.shared.makeLinkKitViewController { viewController, error in
  guard let viewController = viewController else {
    // Handle the error, if any.
    return
  }
  self.navigationController?.pushViewController(viewController, animated: true)
}
```

**Objective-C:**

```objc
[[MTLinkKit shared] makeLinkKitViewController:^(UIViewController *_Nullable viewController, NSError *_Nullable error) {
  if (viewController == nil) {
    return;
  }
  [self.navigationController pushViewController:viewController animated:YES];
}];
```

## Get Client Token

If your use case includes fetching data directly from the Moneytree LINK API, please review [how to get the client token](Authorization.md#get-the-access-token-after-authorization-pkce-only) for more details.

# Push Notifications

> :warning: Available only via PKCE authorization flow.

You can register your app to receive notifications from Moneytree Link about large transactions and other important financial events.

Make sure your app has been [configured for PKCE](../README.md#initializing-the-sdk).

Please review [Apple's programming guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html) on best practices for setting up devices for push notifications.

1. Register the app in order to be able to get a device token.

**Swift:**

```swift
UIApplication.shared.registerForRemoteNotifications()
```

**Objective-C:**

```objc
[[UIApplication shared] registerForRemoteNotifications];
```

2. Ask the guest for permission.

Import `UserNotifications` in the file where you will be asking for notification permissions.

**Swift:**

```swift
UNUserNotificationCenter.current().requestAuthorization(options: [/* your notification types */]) { granted, error in
  // Handle permission being granted or not.
}
```

**Objective-C:**

```objc
UNAuthorizationOptions notificationTypes = /* your notification types */;
[[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:notificationTypes completionHandler:^(BOOL granted, NSError *_Nullable error) {
  // Handle permission being granted or not.
}];
```

3. Implement the callback method in UIApplicationDelegate.

**Swift:**

```swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  // Store the `deviceToken`. If it is new, or has changed, please sync it to our server.
}
```

**Objective-C:**

```objc
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  // Store the `deviceToken`. If it is new, or has changed, please sync it to our server.
}
```

4. Register and deregister device tokens

Assuming that you have stored the deviceToken from the step above,

**Swift:**

```swift
let deviceTokenRequest = MTRegisterDeviceTokenAPI(requestBody: deviceToken as NSData) { object, response, error in
  // Handle the error, if any.
}

MTLinkClient.shared.api.sendAuthenticatedRequest(deviceTokenRequest)
```

**Objective-C:**

```objc
MTRegisterDeviceTokenAPI *deviceTokenRequest = [[MTRegisterDeviceTokenAPI alloc] initWithRequestBody:deviceToken completionBlock:^(id body, NSHTTPURLResponse *res, NSError *error) {
  // Handle the error, if any.
}];

[[MTLinkClient sharedClient].api sendAuthenticatedRequest: deviceTokenRequest];
```

Deregistration uses `MTDeregisterDeviceTokenAPI` instead.
