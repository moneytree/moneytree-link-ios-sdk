# Moneytree Link iOS SDK - Account Management

This documentation contains the list of features that are available in the Moneytree Link iOS SDK related to `Guest Account Management`, and how they can be integrated into your mobile app.

- [Open Account Settings](#open-account-settings)
  - [Using Username and Password](#using-username-and-password)
  - [Using Magic Link API (without password)](#using-magic-link-api)

## Open Account Settings

### Using Username and Password

Open the guest's Moneytree account settings. Here they can manage their account information as well as other apps that are connected to Moneytree Link.

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

### Using Magic Link API
		
Asks the server to send a magic link to the guests' email that takes the guests to Moneytree settings in which they can manage their account information as well as other apps that are connected to Moneytree Link.		
		
**NOTE: Configuring universal link support is required for this feature, please find the details [here](../SDKInitialization.md)**		
		
**Swift:**
		
```swift
MTLinkClient.shared.requestForMagicLink(forEmail: "guest's email", to: .settings) { error in
  // Handle API call result/error if necessary
}
```

**Objective-C:**
		
```objc
[[MTLinkClient sharedClient] requestForMagicLinkForEmail:@"guest's email" 		
                                                      to:MTMagicLinkDestinationSettings 		
                                              completion:^(NSError * _Nullable error) {		
  // Handle the error if necessary		
}];		
```

Back to [Available Features](../Features.md)