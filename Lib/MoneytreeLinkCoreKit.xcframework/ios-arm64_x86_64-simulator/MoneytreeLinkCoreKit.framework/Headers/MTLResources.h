//
//  MTLResources.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 5/22/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@class MTOAuthCodeVerifier;

#import <MoneytreeLinkCoreKit/MTLConfiguration.h>
#import <MoneytreeLinkCoreKit/MTLAuthenticationOptions.h>
#import <MoneytreeLinkCoreKit/MTAuthRegion.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTLResources: NSObject<NSCopying>

/**
 The factory for MTLResources.
 @param configuration A configuration file.
 */
+ (instancetype)resourcesWithConfiguration:(MTLConfiguration *)configuration;

/**
 Provides the configuration class.
 */
@property (nonatomic, readonly) MTLConfiguration *configuration;

@property (nonatomic, readonly) NSString *sdkClientId;

@property (nonatomic, readonly) NSString *redirectUrlForMTToken;

@property (nonatomic, readonly) NSString *redirectUrlForAuth;

/**
 Provides URL to open the upgrade authorization page for LinkKit.

 @param codeVerifier to configure url
 @param mtToken The MT token (from previous ISTC use) to upgrade.
 @return An absolute url that can be used for any browsers
 */
- (NSURL *)upgradeTokenURL:(MTOAuthCodeVerifier *)codeVerifier
                   mtToken:(NSString *)mtToken;

/**
 Provides URL to open the authorization page

 @param codeVerifier to configure url
 @param authOptions to configure parameters of the authorization flow
 @return An absolute url that can be used for any browsers
 */
- (NSURL *)authorizationUrl:(MTOAuthCodeVerifier *)codeVerifier
                authOptions:(id<AuthenticationOptions>)authOptions;

/**
 Provides URL to open the fastonboarding page

 @param codeVerifier to configure url
 @param email the user's email to be pre-filled on the onboarding page
 @return An absolute url that can take the user to the onboarding flow
*/
- (NSURL *)onboardUrl:(MTOAuthCodeVerifier *_Nonnull)codeVerifier
                email:(NSString *_Nonnull)email;

/**
 Provides URL to open the vault

 @param accessToken to open the vault
 @return An absolute url that can be used for any browsers
 */
- (NSURL *)vaultUrlWithAccessToken:(NSString *)accessToken relativePath:(NSString *_Nullable)relativePath parameters:(NSDictionary *_Nullable)parameters;

/**
 Provides URL to open the settings page, including an email address to pre-fill.

 @param email The guest's email address
 @return An absolute url that can be used for any browsers
 */
- (NSURL *)settingsUrlWithPrefilledEmail:(NSString *_Nullable)email;

- (NSURL *_Nullable)authUrlWithBaseUrl:(NSURL *)baseUrl
                          codeVerifier:(MTOAuthCodeVerifier *)code;

/// Checks if the url is an account service url based on the current environment
/// @param url the url to be checked
-(BOOL)mt_isAccountServiceUrl:(NSURL *_Nullable)url;

@end

NS_ASSUME_NONNULL_END
