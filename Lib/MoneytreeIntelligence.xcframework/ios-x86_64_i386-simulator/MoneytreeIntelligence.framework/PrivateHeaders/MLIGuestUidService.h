//
//  MLIGuestUidService.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 2019/05/29.
//  Copyright © 2012-present Moneytree. All rights reserved.

@import Foundation;
#import <MoneytreeLinkCoreKit/MTAPIComponents.h>
#import "MLIGuestUid.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A service to retrieve the Guest UID from the Moneytree Link API. It is used in order to link Intelligence
 events with a Moneytree guest.
 */
@interface MLIGuestUidService : MTAPIRequest<NSNull *, MLIGuestUid *>

@end

NS_ASSUME_NONNULL_END
