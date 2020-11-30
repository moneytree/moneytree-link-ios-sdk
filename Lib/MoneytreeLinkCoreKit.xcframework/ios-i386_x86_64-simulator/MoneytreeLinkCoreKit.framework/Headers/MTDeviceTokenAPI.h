//
//  MTDeviceTokenAPI.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 21/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

#import "MTAPIComponents.h"

typedef NSData * MTDeviceToken;

/**
 A service to register a device for push notifications.
 */
@interface MTRegisterDeviceTokenAPI: MTAPIRequest<MTDeviceToken, NSObject *>
@end

/**
 A service to de-register a device so that it no longer receives push notifications.
 */
@interface MTDeregisterDeviceTokenAPI: MTAPIRequest<MTDeviceToken, NSObject *>
@end
