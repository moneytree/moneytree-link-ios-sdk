//
//  NSBundle+Version.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 16/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


@import Foundation;

@interface NSBundle (Version)

/**
 Returns a string representation of the SDK's version.
 */
@property (class, readonly) NSString *mt_sdkVersion;

@end
