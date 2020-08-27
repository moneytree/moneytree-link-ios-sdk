//
//  MLIEvent.h
//  MoneytreeIntelligence
//
//  Created by Moneytree KK on 2019/04/12.
//  Copyright © 2012-present Moneytree. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface MLIEvent : NSObject

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly, nullable) NSDictionary<NSString *, NSString *> *segments;

- (instancetype)initWithKey:(NSString *)key
                 segments:(NSDictionary<NSString *, NSString *> *_Nullable)segments;
- (instancetype)init __attribute__((unavailable("Use -initWithKey:segments: instead")));

@end

NS_ASSUME_NONNULL_END
