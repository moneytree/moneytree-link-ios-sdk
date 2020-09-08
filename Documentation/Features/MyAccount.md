# Moneytree Link iOS SDK - Account Management

This documentation contains the list of features that are available in the Moneytree Link iOS SDK related to `Guest Account Management`, and how they can be integrated into your mobile app.

- [Open Account Settings](#open-account-settings)

## Open Account Settings

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

Back to [Available Features](../Features.md)