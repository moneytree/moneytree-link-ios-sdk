//
//  MTOAuthHelpers.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 12/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 Helpers class for OAuth. Including generating code verifier, code challenge or nounce.
 */
@interface MTOAuthHelpers: NSObject

- (instancetype)init __attribute__((unavailable("This class is not meant to be initialized.")));;

+ (NSString *)encodeBase64UrlNoPadding:(NSData *)data;

+ (NSString *_Nullable)makeNonce;

+ (NSString *_Nullable)makeCodeVerifier;

+ (NSData *)sha265:(NSString *)inputString;

@end

NS_ASSUME_NONNULL_END
