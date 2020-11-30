//
//  MTLog.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 22/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@import os.log;

NS_ASSUME_NONNULL_BEGIN

#define MT_LOG(LEVEL, MESSAGE, ...) \
do { \
  NSString *const stringMessage = [NSString stringWithFormat:(MESSAGE), ##__VA_ARGS__]; \
  [MTLog log:stringMessage level:LEVEL]; \
} while (0)

/**
 A simple log wrapper for the `os_log`.
 */
@interface MTLog: NSObject

/**
 Calls `log:category:level:` with a default category and a default level.

 @param message The message to log.
 */
+ (void)log:(NSString *)message;

/**
 Calls `log:category:level:` with a default category.

 @param message The message to log.
 @param level The severity (debug, verbose) level for the message.
 */
+ (void)log:(NSString *)message level:(os_log_type_t)level;

/**
 Calls `log:category:level:` with a default level.

 @param message The message to log.
 @param category Category for the logged message.
 */
+ (void)log:(NSString *)message category:(NSString *_Nullable)category;

/**
 Log using the new xcode 8+ and iOS 10's unified logging.
 https://developer.apple.com/reference/os/logging

 @param message The message to log.
 @param category Category for the logged message.
 @param level The severity (debug, verbose) level for the message.
 */
+ (void)log:(NSString *)message category:(NSString *_Nullable)category level:(os_log_type_t)level;

@end

NS_ASSUME_NONNULL_END
