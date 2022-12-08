//
//  MTLConfiguration.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 5/22/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
#import <MoneytreeLinkCoreKit/MTLEnvironment.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTLConfiguration: NSObject<NSCopying>

/**
 Indicates the development environment. The default is MTLEnvironmentStaging.
 */
@property (nonatomic) MTLEnvironment environment;

/**
 A list of request scopes. Use reserved values in MTLConstants.h that start with MTLClientScope.
 */
@property (nonatomic, copy, nullable) NSArray<NSString *> *scopes;

/**
 The client ID fetched from the Info.plist
 */
@property (nonatomic, copy, readonly) NSString *clientId;

/**
 Set true to restore session.
 */
@property (nonatomic) BOOL stayLoggedIn;

#pragma mark - Deprecated

/**
 Required initializer only for Code Grant without PKCE.

 @param redirectUri Moneytree's server redirects user to given redirect url after authorization

 */
- (instancetype)initWithRedirectUri:(NSString *)redirectUri
DEPRECATED_MSG_ATTRIBUTE("Code Grant without PKCE is not supported anymore. Will be removed in the next major version. Migration guide at https://docs.link.getmoneytree.com/docs/migrate-auth-to-pkce");

/**
 The expected redirect URI for Code grant auth flow. Otherwise it returns nil.
 */
@property (nonatomic, copy, readonly, nullable) NSString *redirectUri
DEPRECATED_MSG_ATTRIBUTE("Code Grant without PKCE is not supported anymore. Will be removed in the next major version. Migration guide at https://docs.link.getmoneytree.com/docs/migrate-auth-to-pkce");

@end

NS_ASSUME_NONNULL_END
