//
//  NSUrlRequest+Extensions.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 16/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.

@import Foundation;

@interface NSURLRequest (Extensions)

#ifdef DEBUG
/**
 Returns a string representation of the curl command of the request.
 */
- (NSString *_Nonnull)curlRepresentation;
#endif

@end
