# Moneytree Link SDK - Push Notifications

**Available only in [IsshoTsucho][isshotsucho] or [PKCE][pkce]**

- You can register your app to receive notifications from Moneytree Link about large transactions and other important financial events.

- Make sure your app has been properly configured for [IsshoTsucho][isshotsucho] or [PKCE][pkce].

- Please review [Apple's programming guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html) on best practices for setting up devices for push notifications.

## Instructions

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
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
  // Handle permission being granted or not.
}
```

**Objective-C:**

```objc
UNAuthorizationOptions notificationTypes = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
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

Back to [Available Features](../Features.md)

[isshotsucho]: Isshotsucho.md

[pkce]: Authorization.md#pkce
