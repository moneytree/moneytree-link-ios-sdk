//
//  MTLCompletions.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 11/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

#import <MoneytreeLinkCoreKit/MTOAuthCredential.h>

NS_ASSUME_NONNULL_BEGIN

/** Block for any completed operation after trying to fetch for credential */
typedef void(^MTLinkClientCredentialFetchCompletionBlock)(MTOAuthCredential *_Nullable, NSError *_Nullable);

/** Block for any completed operation that can return error or no error when completed without any error */
typedef void(^MTLinkCompletionBlock)(NSError *_Nullable);

NS_ASSUME_NONNULL_END
