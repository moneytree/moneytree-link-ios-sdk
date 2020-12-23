//
//  MTOAuthCredential.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 25/7/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 `MTOAuthCredential` models the credentials returned from an OAuth provider.

 Instance of `MTOAuthCredential` conforms to `NSCoding` for serialising or
 deserialising the receiver to be stored in a file, keychain, etc.

 @see RFC 6749 The OAuth 2.0 Authorization Framework: http://tools.ietf.org/html/rfc6749
 */
@interface MTOAuthCredential: NSObject <NSCoding, NSCopying>

/** @name Accessible Properties */

/** The OAuth access token. */
@property (readonly) NSString *accessToken;

/** The OAuth refresh token. */
@property (readonly, nullable) NSString *refreshToken;

/** The Oauth expiration date. */
@property (readonly) NSDate *expirationDate;

/** The resource server. Specifically, https://resource-server.base-url/endpoint */
@property (readonly) NSString *resourceServer;

/** The CSRF Token */
@property (readonly, nullable) NSString *state;

/** Returns whether the token is expired. */
@property (readonly) BOOL isExpired;

/** True if token is expired or will do so in the next 3 minutes */
@property (readonly) BOOL isAboutToExpire;

/** @name Creating and Initializing Credentials */

- (instancetype)init __attribute__((unavailable("Call initWithAccessToken:refreshToken:expiresIn:resourceServer:")));

- (instancetype)initWithAccessToken:(NSString *)accessToken
                       refreshToken:(NSString *_Nullable)refreshToken
                          expiresIn:(NSTimeInterval)expiredIn
                     resourceServer:(NSString *)resourceServer;

/** Designated Initialiser. */
- (instancetype)initWithAccessToken:(NSString *)accessToken
                       refreshToken:(NSString *_Nullable)refreshToken
                          createdAt:(NSDate *_Nullable)createdAt
                          expiresIn:(NSTimeInterval)expiresIn
                     resourceServer:(NSString *)resourceServer
                              state:(NSString *_Nullable)state NS_DESIGNATED_INITIALIZER;

/**
 Factory method to create an `MTOAuthCredential` object based on query strings

 @param queryStrings  The array of NSURLQueryItem that contains all of the
 important data to initialize a token
 @return A credential object but null if the data is insufficient
 */
+ (instancetype _Nullable)credentialFromQueryStrings:(NSArray<NSURLQueryItem *> *)queryStrings;

@end

NS_ASSUME_NONNULL_END
