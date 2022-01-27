//
//  MTLConfiguration.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 5/22/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
#import "MTLEnvironment.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTLConfiguration: NSObject<NSCopying>

/**
 Required initializer only for authorizaton code grant

 @param redirectUri moneytree server redirects user to given redirect url after authorization

 */
- (instancetype)initWithRedirectUri:(NSString *)redirectUri;

/**
 A boolean value indicates environment. Default is true so make sure to set false if production.
 */
@property (nonatomic) MTLEnvironment environment;


/**
 A list of request scopes. Use reserved values in MTLConstants.h that start with MTLClientScope.
 */
@property (nonatomic, copy, nullable) NSArray<NSString *> *scopes;

/**
 The expected redirect URI for Code grant auth flow. Otherwise it returns nil.
 */
@property (nonatomic, copy, readonly, nullable) NSString *redirectUri;

/**
 The client ID fetched from the Info.plist
 */
@property (nonatomic, copy, readonly) NSString *clientId;

/**
 Set true to restore session.
 */
@property (nonatomic) BOOL stayLoggedIn;

@end

NS_ASSUME_NONNULL_END
