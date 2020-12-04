//
//  MLIPartnerConfigService.h
//  MoneytreeIntelligence
//
//  Created by Moneytree KK on 2019/03/12.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@class MLIConfiguration;
#import "MLIEnvironment.h"

NS_ASSUME_NONNULL_BEGIN

extern NSErrorDomain const MLIPartnerConfigErrorDomain;

typedef NS_ENUM(NSInteger, MLIPartnerConfigErrorCode) {
  MLIPartnerConfigErrorInvalidClientId = 1000,
  MLIPartnerConfigErrorUnknown = 2000,
};

/**
 A service to get Moneytree Intelligence configuration from our Partner Config API.
 */
@interface MLIPartnerConfigService : NSObject

- (instancetype)init __attribute__((unavailable("Use -initWithClientId:inEnvironment: instead")));

/**
 Create a Partner Config service with a client ID and environment.

 @param clientId The ID of the client implementing the SDK.
 @param environment The type of environment. Essential for determining the correct resource server.
 @return A Partner Config service.
 */
- (instancetype)initWithClientId:(NSString *)clientId inEnvironment:(MLIEnvironment)environment;

/**
 Get a Moneytree Intelligence configuration.

 @param completion A block to handle response from the Partner Config API. This block can be called from any thread.
 */
- (void)getConfigurationWithCompletion:(void (^)(MLIConfiguration *_Nullable, NSError *_Nullable))completion
NS_SWIFT_NAME(configuration(completion:));

@end

NS_ASSUME_NONNULL_END
