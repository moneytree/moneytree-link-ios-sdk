//
//  MTLAuthenticationOptions.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 2019/03/06.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
#import <MoneytreeLinkCoreKit/MTAuthRegion.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -

/**
 The authentication mode that should initially be displayed to a user.

 - MTLAuthenticationModeSignup: Sign up for a new account
 - MTLAuthenticationModeLogin: Log in to an existing account
 */
typedef NS_ENUM(NSUInteger, MTLAuthenticationMode) {
  MTLAuthenticationModeSignup,
  MTLAuthenticationModeLogin
};

#pragma mark -

@protocol AuthenticationOptions <NSObject>

@property (nonatomic, readonly) MTLAuthenticationMode mode;
@property (nonatomic, readonly) BOOL allowModeChange;
@property (nonatomic, copy, readonly, nullable) MTAuthRegion region;
@property (nonatomic, copy, readonly, nullable) NSString *email;
@property (nonatomic, readonly) BOOL forceLogout;

@end

#pragma mark - 

/**
 A set of configuration options for the authentication process via My Account.
 */
@interface MTLAuthenticationOptions: NSObject <AuthenticationOptions>

/**
 The authentication mode that should be displayed initially. Signup or login.
 */
@property (nonatomic, readonly) MTLAuthenticationMode mode;

/**
 Whether to display UI allowing users to switch from the sign up screen to the log in screen, or vice versa.
 */
@property (nonatomic, readonly) BOOL allowModeChange;

/**
 An ISO_3166-1_alpha-2 region code. If a supported region ("AU" or "JP") is provided, that will be the user's selected
 region, and the region selector UI for the signup mode will not be displayed.
 It is also used to how proper legal content and register to the right server.
 */
@property (nonatomic, copy, nullable, readonly) MTAuthRegion region;

/**
 The email field will be pre-filled with this when provided.
 */
@property (nonatomic, copy, nullable, readonly) NSString *email;

/**
 When set to true, it forces the server to ignore the current login session, if it exists.
 */
@property (nonatomic, readonly) BOOL forceLogout;

/**
 @return Default authentication options. mode = login, allowModeChange = true, region = nil, guestEmail = nil, forceLogout = false
 */
+ (instancetype)defaultOptions;

/**
 @return Your custom configuration options.
 */
+ (instancetype)optionsWithMode:(MTLAuthenticationMode)mode
                allowModeChange:(BOOL)allowModeChange
                          email:(NSString *_Nullable)email
                    forceLogout:(BOOL)forceLogout
                  NS_SWIFT_NAME(options(mode:allowModeChange:email:forceLogout:));

/**
 @return Your custom configuration options.
 */
+ (instancetype)optionsWithMode:(MTLAuthenticationMode)mode
                allowModeChange:(BOOL)allowModeChange
                         region:(NSString *_Nullable)region
                          email:(NSString *_Nullable)email
                    forceLogout:(BOOL)forceLogout
                  NS_SWIFT_NAME(options(mode:allowModeChange:region:email:forceLogout:))
DEPRECATED_MSG_ATTRIBUTE("Please use options(mode:allowModeChange:email:forceLogout) instead.");

/**
 @return Your custom configuration options.
 */
+ (instancetype)optionsWithMode:(MTLAuthenticationMode)mode
                allowModeChange:(BOOL)allowModeChange
                     regionType:(MTAuthRegion _Nullable)region
                          email:(NSString *_Nullable)email
                    forceLogout:(BOOL)forceLogout
                  NS_SWIFT_NAME(options(mode:allowModeChange:regionType:email:forceLogout:))
DEPRECATED_MSG_ATTRIBUTE("Please use options(mode:allowModeChange:email:forceLogout) instead.");

- (instancetype)init __attribute__((unavailable("Call +defaultOptions or +optionsWithMode:::: instead.")));

@end

NS_ASSUME_NONNULL_END
