//
//  MLIntelligence.h
//  MoneytreeIntelligence
//
//  Created by Moneytree KK on 2019/02/28.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface MLIntelligence : NSObject

- (instancetype)init __attribute__((unavailable("Use singleton instance +shared instead")));

/**
 A singleton instance of Moneytree Intelligence. Your MTLinkClient must already be initialized, otherwise
 this method will throw an exception.

 @return A singleton instance of Moneytree Intelligence.
 */
+ (instancetype)shared;

/**
 Begin logging events to Moneytree Intelligence. Your MTLinkClient must already be initialized, otherwise
 this method will throw an exception.
 */
+ (void)start;

/**
 Record a custom event to Moneytree Intelligence.

 @param eventKey The name of the event.
 */
- (void)recordEvent:(NSString *)eventKey;

/**
 Record a custom event, with segmentation, to Moneytree Intelligence.

 @param eventKey The name of the event.
 @param segments Additional segmentation, if any.
 */
- (void)recordEvent:(NSString *)eventKey segments:(NSDictionary<NSString *, NSString *> * _Nullable)segments;

@end

NS_ASSUME_NONNULL_END
