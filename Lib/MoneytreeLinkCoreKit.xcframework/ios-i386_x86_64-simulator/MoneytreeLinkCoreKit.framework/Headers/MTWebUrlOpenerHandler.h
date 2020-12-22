//
//  MTWebUrlOpenerHandler.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 25/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@import WebKit;

@protocol MTOAuthCredentialProvider;

#import "MTUrlOpenerHandler.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MTWebRunActionMethodName;
extern NSString *const MTWebRunActionKeyAction;
extern NSString *const MTWebRunActionKeyGoto;
extern NSString *const MTWebRunActionKeyActionRevokeApplication;
extern NSString *const MTWebRunActionKeyActionLogout;
extern NSString *const MTWebRunActionKeyActionDeleteAccount;
extern NSString *const MTWebRunActionKeyActionCloseForMagicLink;
extern NSString *const MTWebRunActionKeyActionOpenExternalBrowser;
extern NSString *const MTWebRunActionKeyActionExternalOauthCompleted;

extern NSString *const MTWebRunActionKeyError;
extern NSString *const MTWebRunActionKeyErrorAccessDenied;

/**
 Handles most of the communication between the web and the native side.

 @see https://github.com/moneytree/mt-link-ios-sdk/wiki/VaaS-&-IT-and--Native-Communications#scenarios
 */
@interface MTWebUrlOpenerHandler: NSObject
<WKScriptMessageHandler, WKNavigationDelegate, MTUrlOpenerHandler>

- (instancetype)init
__attribute__((unavailable("Call -initWithViewControllerForPresentation:credentialProvider instead")));;

- (instancetype)initWithViewControllerForPresentation:(UIViewController *)viewController
                                          accessToken:(NSString *)accessToken NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, nullable) void(^closeHandler)(void);

@property (nonatomic, copy, nullable) void(^logoutHandler)(void);

@property (nonatomic, copy, nullable) void(^completion)(void);

@end

NS_ASSUME_NONNULL_END
