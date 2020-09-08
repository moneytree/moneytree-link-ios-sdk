//
//  MTLinkClient_Internal.h
//  MoneytreeIntelligence
//
//  Created by Moneytree on 2019/06/04.
//  Copyright © 2012-present Moneytree. All rights reserved.


#import <MoneytreeLinkCoreKit/MTLinkClientIntelligenceDelegate.h>
#import <MoneytreeLinkCoreKit/MTLinkClient.h>

NS_ASSUME_NONNULL_BEGIN

/**
 See MTAPIComponents_Internal and MTAPIHelpers for similar hacks.
 */
@interface MTLinkClient ()

/**
 Provide access within Moneytree Intelligence to the delegate property added to MTLinkClient.
 Should be refactored to use some sort of subscriber list.
 */
@property (nonatomic, nullable, weak) id<MTLinkClientIntelligenceDelegate> intelligenceDelegate;

/**
 Set the sample ID generated within Moneytree Intelligence in the Moneytree Link Client.

 @param intelligenceSampleId A number generated to decide whether to include a guest in Intelligence or not.
 */
- (void)setIntelligenceSampleId:(NSUInteger)intelligenceSampleId;

@end

NS_ASSUME_NONNULL_END
