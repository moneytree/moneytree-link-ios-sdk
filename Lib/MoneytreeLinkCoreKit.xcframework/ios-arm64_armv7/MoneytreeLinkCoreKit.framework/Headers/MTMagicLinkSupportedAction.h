//
//  MTMagicLinkSupportedAction.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 07/09/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.

#import "MTCurrentAction.h"

@protocol MTMagicLinkSupportedAction <MTCurrentAction>

/**
 Returns `YES` if this operation is waiting for a Login Link to be handled. Otherwise, returns `NO`.
 */
@property (nonatomic) BOOL isAwaitingLoginLink;

@end
