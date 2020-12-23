//
//  MTLApplicationDelegate.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 23/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "MTLCompletions.h"

NS_ASSUME_NONNULL_BEGIN

/** Block for restore user activity operations */
typedef void(^MTRestoreUserActivityCompletionBlock)(NSArray<id<UIUserActivityRestoring>> *_Nullable);

/**
 A facade of the `UIApplicationDelegate` in the SDK. It is expected for the client
 to forward any call to the application's `UIApplicationDelegate` to the
 singleton of the `MTLApplicationDelegate`.

 Please make sure `MTLinkClient.shared` is created before initiating this class.
 */
@interface MTLApplicationDelegate: NSObject

- (instancetype)init __attribute__((unavailable("Call shared instance +shared instead")));;

/**
 Shared instance
 */
@property (class, readonly) MTLApplicationDelegate *shared;

/**
 Expected to be called by the SDK's client to let the framework check whether
 the URL is expected for deep links.

 @param app The application that is opened
 @param url The url that triggers the opening of the app
 @param options A dictionary of URL handling options. For information about the
 possible keys in this dictionary and how to handle them, see
 `UIApplicationOpenURLOptionsKey`.
 @return `YES` if the SDK is expecting the URL and handling it.
 */
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;


/// Expected to be called by the SDK's client to let the framework check whether
/// the URL is expected for universal links.
/// @param app The application that is opened
/// @param userActivity The activity object containing the data associated with the task the user was performing.
///                     Use the data to continue the user's activity in your iOS app.
/// @param viewController A view controller where a webview completing the magic link process will be shown.
/// @param completion A block that is called after the userActivity is handled.
///                   If the universal link can not be handled, completion will not be called.
///
///                   For handling magic link, if the link is successfully opened in a webview,
///                   This completion handler will be called once the webview is closed.
///
///                   The completion contains a null error if the activity is successfully handled.
///                   The completion contains a non-null error if the activity failed to be handled.
/// @return `YES` if the SDK is expecting the URL and handling it.
- (BOOL)application:(UIApplication *)app
       userActivity:(NSUserActivity *)userActivity
        presentFrom:(UIViewController *)viewController
         completion:(MTLinkCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
