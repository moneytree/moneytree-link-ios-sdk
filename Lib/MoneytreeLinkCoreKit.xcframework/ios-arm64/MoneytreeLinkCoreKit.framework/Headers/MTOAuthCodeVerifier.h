//
//  MTOAuthCodeVerifier.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 16/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 A simple objective class that has the secret pair for PKCE flow. It has both code verifier and the code challenge.

 Initialize with `-init` to generate both code verifier and its derrivative code challenge.

 Both the code verifier and the challenge are immutable after initializations.
 */
@interface MTOAuthCodeVerifier: NSObject <NSCopying>

/**
 A convenient initializer that automatically generates the verifier.
 */
- (instancetype)init;

/**
 The designated initializer
 */
- (instancetype)initWithCodeVerifier:(NSString *)codeVerifier NS_DESIGNATED_INITIALIZER;

/**
 Code verifier for the PKCE flow.

 @see https://tools.ietf.org/html/rfc7636#section-4.1
 */
@property (nonatomic, copy, readonly) NSString *verifier;

/**
 Code challenge for the PKCE flow

 code_challenge = BASE64URL-ENCODE(SHA256(ASCII(code_verifier)))

 @see https://tools.ietf.org/html/rfc7636#section-4.2
 */
@property (nonatomic, copy, readonly) NSString *challenge;

@end

NS_ASSUME_NONNULL_END
