//
//  MTLinkClientStatusDelegate.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 03/06/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.

#import "MTLinkClientStatus.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A protocol for listeners to authorization and logout events.

 NOTE: Not currently supported for external clients.
 */
@protocol MTLinkClientDelegate

/**
 The guest has successfully done something that requires the guest to be logged in to the Moneytree platform.
 */
- (void)clientStatusDidChangeTo:(MTLinkClientStatus)status withError:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
