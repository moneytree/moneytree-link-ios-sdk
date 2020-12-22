//
//  MTAPIHelpers.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 2019/05/29.
//  Copyright © 2012-present Moneytree. All rights reserved.

@import Foundation;

// This file has been hackily copied from MoneytreeLinkCoreKit, in order to be able to implement an MTAPIRequest
// subclass in Moneytree Intelligence.
//
// See the identically named file in MoneytreeLinkCoreKit for proper documentation.
//
// TODO: Come up with a better way to implement access control for MTAPI. It should probably just be extracted
// into its own module, which can then just never be publicly available to our customers, but would have a good
// interface for internal use. AWE 2019/06/03

NS_ASSUME_NONNULL_BEGIN

@interface MTAPIHelpers : NSObject

+ (NSURL *)baseUrlForResourceServer:(NSString *)resourceServer;
+ (id)jsonResponseFromData:(NSData *_Nullable)data response:(NSHTTPURLResponse *)response;
+ (NSError *_Nullable)errorFromResponseBody:(id _Nullable)responseBody
                               httpResponse:(NSHTTPURLResponse *)response
                                      error:(NSError *_Nullable)error;
+ (NSMutableURLRequest *)requestWithMtHeaders:(NSMutableURLRequest *)request;

@end

NS_ASSUME_NONNULL_END
