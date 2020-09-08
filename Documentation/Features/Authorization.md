# Moneytree Link iOS SDK - Authorization

This documentation contains the information about:
- [Perform Authorization with Moneytree](#perform-authorization-with-moneytree)
  - [Code Grant](#code-grant)
  - [PKCE](#pkce)
- [Get the Access Token After Authorization (PKCE Only)](#get-the-access-token-after-authorization-pkce-only)
- [Check Login Status](#check-login-status)
- [Remove All Tokens](#remove-all-tokens)
- [Logout](#logout)

## Perform Authorization with Moneytree

You can authorize your app to connect to the Moneytree Link API server via the following two SDK-server OAuths. This enables you to retrieve the guest's account information, their registered financial institutions, and transaction data via Moneytree Link REST APIs.

The OAuth flow is presented in an `SFSafariViewController`.

### Code Grant

**Swift:**

```swift
// Create an AuthOption with 
// 1. Preferred default authorization page (sign up/log in)
// 2. Default email address to show on the authorization page.
let authOption = MTLinkAuthOptions.authOption(
  showSignUp: false,
  guestEmail: "your-email@example.com"
)

// Optional: force logout all existing sessions before logging in the user
authOption.useForceLogout = true

// Perform the Authorization
MTLinkClient.shared.authorizeUsingCodeGrant(
  from: self,
  state: "Provide_A_RandomState__See_Api_Description",
  authOptions: authOption,
  animated: true
) { error in
  // Handle the error, if any.
} 
```

**Objective-C:**

```objc
// Create an AuthOption with 
// 1. Preferred default authorization page (sign up/log in)
// 2. Default email address to show on the authorization page.
MTLinkAuthOption *authOption = [MTLinkAuthOptions authOptionWithShowSignUp:NO guestEmail:@"your-email@example.com"];

// Optional: force logout all existing sessions before logging in the user
authOption.useForceLogout = YES;

// Perform the Authorization
[[MTLinkClient sharedClient] authorizeUsingCodeGrantFrom:self 
state: @"Provide_A_RandomState__See_Api_Description" authOptions: authOption animated:YES completion:^(NSError * _Nullable error) {
  // Handle the error, if any.
}];
```

### PKCE

**Swift:**

```swift
// Create an AuthOption with 
// 1. Preferred default authorization page (sign up/log in)
// 2. Default email address to show on the authorization page.
let authOption = MTLinkAuthOptions.authOption(
  showSignUp: true,
  guestEmail: "your-email@example.com"
)

// Optional: force logout all existing sessions before logging in the user
authOption.useForceLogout = true

// Perform the authorization
MTLinkClient.shared.authorizeUsingPkce(from: self, authOptions: authOption, animated: true) { credential, error in
  // Store the credential, if available.
  // Handle the error, if any.
}
```

**Objective-C:**

```objc
// Create an AuthOption with 
// 1. Preferred default authorization page (sign up/log in)
// 2. Default email address to show on the authorization page.
MTLinkAuthOption *authOption = [MTLinkAuthOptions authOptionWithShowSignUp: YES guestEmail: @"your-email@example.com"];

// Optional: force logout all existing sessions before logging in the user
authOption.useForceLogout = YES;

// Perform the authorization
[[MTLinkClient sharedClient] authorizePkceFrom:self authOptions: authOption animated:YES completion:^(MTOAuthCredential * _Nullable credential, NSError * _Nullable error) {
  // Store the credential, if available.
  // Handle the error, if any.
}];
```

## Get the Access Token After Authorization (PKCE Only)

The access token to query Moneytree Link REST API is availble after the user is authorized via `PKCE`.

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

Remove login session token and authorization token from the SDK.

**Swift:**

```swift
MTLinkClient.shared.removeAllTokens()

```

**Objective-C:**

```objc
[MTLinkClient.sharedClient removeAllTokens];
```

## Logout

Launches Safari and logout the guest completely by clearing the browser cookies and stored tokens.

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

Back to [Available Features](../Features.md)