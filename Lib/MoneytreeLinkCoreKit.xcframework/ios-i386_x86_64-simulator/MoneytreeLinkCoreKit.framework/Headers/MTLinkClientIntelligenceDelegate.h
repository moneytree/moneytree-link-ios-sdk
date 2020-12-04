//
//  MTLinkClientIntelligenceDelegate.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 2019/06/04.
//  Copyright © 2012-present Moneytree. All rights reserved.


#import "MTLinkClient.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A protocol for listeners to authorization and logout events.

 NOTE: Not currently supported for external clients.
 */
@protocol MTLinkClientIntelligenceDelegate <NSObject>

/**
 The guest has successfully done something that requires the guest to be logged in to the Moneytree platform.
 */
- (void)clientDidAuthorize:(MTLinkClient *)client;

/**
 The guest has successfully logged out from the Moneytree platform.
 */
- (void)clientDidLogout:(MTLinkClient *)client;

@end

NS_ASSUME_NONNULL_END
