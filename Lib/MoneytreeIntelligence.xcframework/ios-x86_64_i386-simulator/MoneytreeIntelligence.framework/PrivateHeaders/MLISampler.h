//
//  MLISampler.h
//  MoneytreeIntelligence
//
//  Created by Moneytree on 2019/06/18.
//  Copyright © 2012-present Moneytree. All rights reserved.


@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 Decides whether Intelligence should be enabled for a given guest or device.
 */
@interface MLISampler : NSObject

@property (nonatomic, readonly) NSUInteger samplingId;
@property (nonatomic, readonly) NSUInteger samplePercentage;

- (instancetype)init __attribute__((unavailable("Use -initWithSamplePercentage: instead")));

/**
 Create a sampler with a percentage.

 @param samplePercentage The percentage of guests to sample.
 */
- (instancetype)initWithSamplePercentage:(NSUInteger)samplePercentage;

/**
 Should Intelligence be enabled?
 */
- (BOOL)shouldSample;

@end

NS_ASSUME_NONNULL_END
