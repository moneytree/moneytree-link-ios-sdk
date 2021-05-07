
//
//  MTKeychain.h
//  Keychain
//
//  Created by Moneytree KK on 9/15/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 Acts as a facade for adding/remove or query the Keychain item given a associated key.

 For all possible status returned as `OSStatus`, see the links below:
 @see https://developer.apple.com/documentation/security/1542001-security_framework_result_codes
 */
@interface MTKeychain: NSObject

#if !DEBUG
- (instancetype)init NS_UNAVAILABLE;
#endif

/* Singleton instance */
@property (class, readonly) MTKeychain *shared;

/**
 Add an objects with key. It overwrites if it exists.

 @param data The stored value
 @param key An unique key to identify an item in keychain
 @return A status from the operation
 */
- (OSStatus)addData:(NSData *)data forKey:(NSString *)key;

/**
 Removes any associated value with the `key`

 @param key The associated key
 @return A status from the operation
 */
- (OSStatus)removeDataForKey:(NSString *)key;

/**
 Get an object ties to a specifc key.

 @param key An unique key to identify an item in keychain
 */
- (NSData *_Nullable)dataForKey:(NSString *)key;

/**
 Add a string associated with the key. It overwrites if it exists.

 @param string The stored value
 @param key An unique key to identify an item in keychain
 @return A status from the operation
 */
- (OSStatus)addString:(NSString *)string forKey:(NSString *)key;

/**
 Get an object ties to a specifc key.

 @param key An unique key to identify an item in keychain
 */
- (NSString *_Nullable)stringForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
