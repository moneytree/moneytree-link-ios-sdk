//
//  MTLoginLinkServiceManager_Internal.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 17/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


#import "MTLoginLinkServiceManager.h"

@interface MTLoginLinkServiceManager ()

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, copy, nullable) MTLoginLinkOperation *currentAction_;

- (NSURLRequest *)makeRequestWithQueryMap_:(NSDictionary<NSString *, NSString *> *)queryMap
                           andParameterMap:(NSDictionary<NSString *, NSString *> *)parameterMap;

NS_ASSUME_NONNULL_END

@end
