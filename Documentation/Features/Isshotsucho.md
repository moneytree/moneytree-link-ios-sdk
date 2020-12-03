# Moneytree Link iOS SDK - Isshotsucho

- [Launch IsshoTsucho](#launch-isshoTsucho)
- [Push Notifications](#push-notifications)
- [Get Client Token](#get-client-token)

## Launch IsshoTsucho

IsshoTsucho is a UIViewController that you must present in your app.

Import `MoneytreeIsshoTsucho` in the file responsible for presenting it.

**Swift:**

```swift
MTIsshoTsucho.shared.makeViewController { viewController, error in
  guard let viewController = viewController else {
    // Handle the error, if any.
    return
  }
  self.navigationController?.pushViewController(viewController, animated: true)
}
```

**Objective-C:**

```objc
[[MTIsshoTsucho shared] makeViewController:^(UIViewController *_Nullable viewController, NSError *_Nullable error) {
  if (viewController == nil) {
    return;
  }
  [self.navigationController pushViewController:viewController animated:YES];
}];
```

## Push Notifications

Please See [Push Notifications](PushNotification.md) for more details.

## Get Client Token

Please See [Authorization](Authorization.md#get-the-access-token-after-authorization-pkce-only) for more details.

Back to [Available Features](../Features.md)