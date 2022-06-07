//
//  MTLinkAuthOptions.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 10/16/18.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
#import <MoneytreeLinkCoreKit/MTLAuthenticationOptions.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This class is meant to use together with authorization process.
 Only initializing this class won't configure login or email.
 Please MTLinkClient.authorize for more detail.

 This class will be deprecated in favor of MTLAuthenticationOptions in a future release.
 */
@interface MTLinkAuthOptions: NSObject <NSCopying>

/**
 When set to true sign up page is shown. Default false.
 */
@property (nonatomic) BOOL showSignUp;

/**
 Login and sing up is pre filled with email when provided, default nil.
 */
@property (nonatomic, copy, nullable) NSString *guestEmail;

/**
 Force to use new session when Authorize api is called
 */
@property (nonatomic) BOOL useForceLogout;

- (instancetype)init __attribute__((unavailable("Call custom initializer instead")));;

+ (instancetype)authOptionWithShowSignUp:(Boolean)showSignUp
                              guestEmail:(NSString *_Nullable)guestEmail
     NS_SWIFT_NAME(authOption(showSignUp:guestEmail:));

@end

@interface MTLinkAuthOptions (AuthenticationOptions) <AuthenticationOptions>

@property (nonatomic, readonly) MTLAuthenticationMode mode;
@property (nonatomic, readonly) BOOL allowModeChange;
@property (nonatomic, copy, readonly, nullable) MTAuthRegion region;
@property (nonatomic, copy, readonly, nullable) NSString *email;

@end

NS_ASSUME_NONNULL_END
