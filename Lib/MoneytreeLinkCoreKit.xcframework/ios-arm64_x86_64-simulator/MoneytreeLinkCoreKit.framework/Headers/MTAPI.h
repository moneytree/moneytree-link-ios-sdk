//
//  MTAPI.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 21/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@class MTAPIRequest;
@class MTAPIConfiguration;

NS_ASSUME_NONNULL_BEGIN

/** 'Authorization' key for the HTTP Request Header */
extern NSString *const MTHTTPHeaderAuthorizationKey;

/** 'Content-Type' key for the HTTP Request Header */
extern NSString *const MTHTTPHeaderContentTypeKey;

/** 'application/json' value as one of the options for the HTTP Request Header */
extern NSString *const MTHTTPHeaderContentTypeJSONValue;

/** MT API Related Error */
extern NSString *const MTAPIErrorDomain;

typedef NS_ENUM(NSUInteger, MTAPIError) {
  /**
   An unknown error
   */
  MTAPIErrorUnknown = 0,

  /**
   The server is not satisfy with the request parameters.
   Please check the request parameter.
   */
  MTAPIBadRequest = 400,

  /**
   Not authorized to make this call. This can also mean the token is somehow NG (or revoked)?
   Please reauthorize.
   */
  MTAPIUnauthorized = 401
};

/**
 MTAPI acts as a client to the Moneytree Link API. It ensures that any necessary authorization is performed before
 getting any resources from the Moneytree Link API.

 Any services that need to be implemented against the Moneytree Link API must subclass MTAPIRequest. 
 */
@interface MTAPI: NSObject

- (instancetype)init __attribute__((unavailable("Call initWithConfiguration:")));

- (instancetype)initWithConfiguration:(MTAPIConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 Send a request to the Moneytree Link API. Any necessary authorization will be performed before getting any resources
 from the Moneytree Link API.

 This method is unavailable to Swift clients because `MTAPIRequest` has associated generics that do not work in Swift.
 Use `sendRequestForSwift:` instead.

 @param apiRequest The API Request object.
 */
- (void)sendRequest:(MTAPIRequest *)apiRequest NS_SWIFT_UNAVAILABLE("Not Available");

/**
 Send a request to the Moneytree Link API. Any necessary authorization will be performed before getting any resources
 from the Moneytree Link API.

 Use this method only if you are using Swift.

 @param genericRequest The API Request object.
 */
- (void)sendRequestForSwift:(id)genericRequest NS_SWIFT_NAME(sendRequest(_:));


#pragma mark - Deprecated

/**
 Send a request to the Moneytree Link API. Any necessary authorization will be performed before getting any resources
 from the Moneytree Link API.

 This method is unavailable to Swift clients because `MTAPIRequest` has associated generics that do not work in Swift.
 Use `sendAuthenticatedRequestForSwift:` instead.

 @param apiRequest The API Request object.
 */
- (void)sendAuthenticatedRequest:(MTAPIRequest *)apiRequest
NS_SWIFT_UNAVAILABLE("Not Available")
DEPRECATED_MSG_ATTRIBUTE("Use sendRequest: instead.");

/**
 Send a request to the Moneytree Link API. Any necessary authorization will be performed before getting any resources
 from the Moneytree Link API.

 Use this method only if you are using Swift.

 @param genericRequest The API Request object.
 */
- (void)sendAuthenticatedRequestForSwift:(id)genericRequest
NS_SWIFT_NAME(sendAuthenticatedRequest(_:))
DEPRECATED_MSG_ATTRIBUTE("Use sendRequestForSwift: instead.");

@end

NS_ASSUME_NONNULL_END
