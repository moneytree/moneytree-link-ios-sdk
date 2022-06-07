//
//  MTLinkPkceAuthOptions.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 10/25/18.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
#import <MoneytreeLinkCoreKit/MTLinkAuthOptions.h>
#import <MoneytreeLinkCoreKit/MTOAuthCodeVerifier.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTLinkPkceAuthOptions : NSObject <NSCopying>

/**
 accessToken to avoid showing login twice.
 */
@property (nonatomic, copy, readonly) NSString *accessToken;

/**
 CodeVerifier to appends to url when using PKCE.
 */
@property (nonatomic, copy, readonly) MTOAuthCodeVerifier *codeVerifier;

- (instancetype)init __attribute__((unavailable("Call custom initializer instead")));

- (instancetype)initWithWithAccessToken:(NSString *)accessToken
                           codeVerifier:(MTOAuthCodeVerifier *)codeVerifier NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
