# Moneytree Link iOS SDK - Connected Services (Vault)

This documentation contains the list of features that are available in the Moneytree Link iOS SDK related to `Connected Services (Vault)`, and how they can be integrated into your mobile app.

- [Open Vault Homepage](#open-vault-homepage)
- [Open Vault - Services that meet the options](#vault---services-that-meet-the-options)
- [Open Vault - Specific Service](#vault---connect-to-a-specific-service)
- [Open Vault - Settings for Specific Service](#vault---settings-for-specific-service)
- [Open Vault - Customer Support](#vault---customer-support)

## Open Vault Homepage

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

Back to [Available Features](../Features.md)