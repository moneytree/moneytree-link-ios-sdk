//
//  MTAPIComponents.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 21/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@class MTOAuthCredential;

NS_ASSUME_NONNULL_BEGIN

/**
 A protocol for OAuth credential providers. Any credential provider must be able to handle getting
 access tokens from the API and refreshing them if they are expired.
 */
@protocol MTOAuthCredentialProvider<NSObject>
/**
 Only supported when the authentication type is PKCE.
*/
- (void)getTokenAndRefreshAsNeeded:(void(^)(MTOAuthCredential *_Nullable, NSError *_Nullable))completionBlock
NS_SWIFT_NAME(getTokenAndRefreshAsNeeded(_:));
@end

/**
 A configuration object for the Moneytree Link API client.
 */
@interface MTAPIConfiguration: NSObject

- (instancetype)init __attribute__((unavailable("Call initWithBaseUrl:clientId:credentialProvider")));

/**
 The configuration object should be created with all of its properties.

 @param clientId The ID of the customer using this SDK.
 @param credentialProvider An OAuth credential provider.
 @param testEnvironment Whether to use a test or production environment.
 @return A configuration object for the Moneytree Link API client.
 */
- (instancetype)initWithClientId:(NSString *)clientId
              credentialProvider:(id<MTOAuthCredentialProvider>)credentialProvider
              forTestEnvironment:(BOOL)testEnvironment NS_DESIGNATED_INITIALIZER;

/**
 The ID of the customer using this SDK.
 */
@property (nonatomic, copy, readonly) NSString *clientId;

/**
 Whether to use a test or production environment.
 */
@property (nonatomic, readonly) BOOL testEnvironment;

/**
 An OAuth credential provider.
 */
@property (nonatomic, readonly) id<MTOAuthCredentialProvider> credentialProvider;

@end

/**
 A base class for requests for the Moneytree Link API.

 This class must be subclassed. The subclass should specialize their request body and response body classes where
 possible. However, if the particular API resource does not require a request or response body, just use NSObject.

 See `MTAPIComponents_Internal.h` for methods that must be implemented on the subclass.
 */
@interface MTAPIRequest<RequestBodyType, ResponseBodyType>: NSObject

- (instancetype)init __attribute__((unavailable("Call initWithRequestBody:completionBlock:")));

/**
 Create a request for the Moneytree Link API, with a request body and a block that can handle the response body.

 @param requestBody The body of the request.
 @param completionBlock A block that can process the response to the request or any errors.
 @return An MTAPIRequest that can be executed by an MTAPI.
 */
- (instancetype)initWithRequestBody:(RequestBodyType _Nullable)requestBody
                    completionBlock:(void(^)(ResponseBodyType _Nullable,
                                             NSHTTPURLResponse *_Nullable,
                                             NSError *_Nullable))completionBlock NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
