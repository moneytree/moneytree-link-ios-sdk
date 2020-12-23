//
//  MLIConfiguration.h
//  MoneytreeIntelligence
//
//  Created by Moneytree KK on 2019/03/12.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface MLIConfiguration : NSObject

/**
 The app key for the Moneytree Intelligence instance.
 */
@property (nonatomic, copy, readonly) NSString *key;

/**
 The URL for the Moneytree Intelligence instance.
 */
@property (nonatomic, copy, readonly) NSString *url;

/**
 The percentage (0-100) of guests that should send data to Moneytree Intelligence.
 */
@property (nonatomic, readonly) NSUInteger samplePercentage;

- (instancetype)initWithKey:(NSString *)key url:(NSString *)url samplePercentage:(NSUInteger)samplePercentage;

- (nullable instancetype)initWithJson:(id)json;

@end

NS_ASSUME_NONNULL_END
