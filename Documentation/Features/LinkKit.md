# Moneytree Link iOS SDK - LINK Kit

- [Launch LINK Kit](#launch-link-kit)
- [Get Client Token](#get-client-token)

## Launch LINK Kit

LINK Kit is a UIViewController that you must present in your app.

Import `MoneytreeLinkKit` in the file responsible for presenting it.

Please make sure the scope configuration matches what is mentioned [here](../SDKInitialization.md#scope-configuration).

**NOTE:** LINK Kit **DOES NOT** support fast onboarding.

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

Please See [Authorization](Authorization.md#get-the-access-token-after-authorization-pkce-only) for more details.

Back to [Available Features](../Features.md)