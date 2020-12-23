//
//  MTMagicLinkSupportedAction.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 07/09/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.

#import "MTCurrentAction.h"

@protocol MTMagicLinkSupportedAction <MTCurrentAction>

/**
 Returns `YES` if this operation is awaiting for handling magic link. Otherwise, returns `NO`.
 */
@property (nonatomic) BOOL isAwaitingForMagicLink;


@end
