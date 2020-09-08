//
//  MTAPIComponents+Internal.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 21/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

#import <MoneytreeLinkCoreKit/MTAPIComponents.h>

// This file has been hackily copied from MoneytreeLinkCoreKit, in order to be able to implement an MTAPIRequest
// subclass in Moneytree Intelligence.
//
// See the identically named file in MoneytreeLinkCoreKit for proper documentation.
//
// TODO: Come up with a better way to implement access control for MTAPI. It should probably just be extracted
// into its own module, which can then just never be publicly available to our customers, but would have a good
// interface for internal use. AWE 2019/06/03

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MTAPIConfiguration

@interface MTAPIConfiguration ()
@property (nonatomic, copy, readwrite) NSString *clientId;
@property (nonatomic, readwrite) id<MTOAuthCredentialProvider> credentialProvider;
@property (nonatomic, readwrite) BOOL testEnvironment;
@end

#pragma mark - MTAPIRequest

@interface MTAPIRequest ()

@property (nonatomic, nullable, readonly) id requestBody_;
@property (nonatomic, nullable, readonly) void(^completionBlock_)(id _Nullable, NSHTTPURLResponse *_Nullable, NSError *_Nullable);

- (NSMutableURLRequest *)makeUrlRequestWithConfiguration:(MTAPIConfiguration *)configuration
                                          resourceServer:(NSString *)resourceServer;

- (void)completeRequestWith:(NSData *_Nullable)data
                   response:(NSHTTPURLResponse *_Nullable)response
                      error:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
