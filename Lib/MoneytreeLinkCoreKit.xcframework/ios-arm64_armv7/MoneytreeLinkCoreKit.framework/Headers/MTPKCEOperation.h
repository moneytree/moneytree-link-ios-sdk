//
//  MTPKCEOperation.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 18/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

@class MTOAuthCodeVerifier;
@class MTOAuthCredential;
#import "MTMagicLinkSupportedAction.h"

NS_ASSUME_NONNULL_BEGIN

/**
 POOO (Plain Old Objective-C Object) to hold the state for ongoing PKCE operation, including its
 1-time use secret, instance of `MTOAuthCodeVerifier` that gets generated when this class is instantiated.
 */
@interface MTPKCEOperation: NSObject<MTMagicLinkSupportedAction>

- (instancetype)init __attribute__((unavailable("Call initWithClientId: instead")));

- (instancetype)initWithClientId:(NSString *_Nonnull)clientId NS_DESIGNATED_INITIALIZER;

/**
 Hold the PKCE code-pair. The code verifier and its code challenge that can be used in this PKCE auth flow
 */
@property (nonatomic, copy, readonly) MTOAuthCodeVerifier *codeVerifier;

/**
 Can be used as a `client_id` parameter when doing token exchange. Either app id or partner id.
 */
@property (nonatomic, copy, readonly) NSString *clientId;

/**
 Can be used to hold the credential that is the output of the operation.
 */
@property (nonatomic, copy, nullable) MTOAuthCredential *credential;

/**
 An optional closure for any client to use.
 */
@property (nonatomic, copy, nullable) void(^completion)(MTOAuthCredential *_Nullable, NSError *_Nullable);

/**
 Returns `YES` if this operation is awaiting for handling Login Link. Otherwise, returns `NO`.
*/
@property (nonatomic) BOOL isAwaitingLoginLink;

@end

NS_ASSUME_NONNULL_END
