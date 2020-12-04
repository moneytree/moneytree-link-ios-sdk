//
//  MTUrlOpenerHandler.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 23/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import UIKit;

#import "MTLCompletions.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Used internally to handle any URL opened through the `UIApplicationDelegate`.

 `canOpenURL:` is called prior to determine whether the conformed instance can
 handle a URL and then the `handleURL:options:` is called to handle the Url.
 */
@protocol MTUrlOpenerHandler <NSObject>

/**
 Called whether conformed instance is able to handle the URL.

 @param url The url to check.
 @return `YES` if it is able to handle the `url`.
 */
- (BOOL)mt_urlHandlerCanHandleUrl:(NSURL *_Nonnull)url;

/**
 Called to handle the `url` that triggers the opening of the app.

 @param url The url to handle
 @param options A dictionary of URL handling options. For information about the possible keys in this dictionary and
 how to handle them, see `UIApplicationOpenURLOptionsKey`
 @param completion A closure that needs to be called by the client implementing this.
                   It takes an argument to determine whether to dismiss the safari view controller with animation
 */
- (void)mt_urlHandlerToHandleUrl:(NSURL *_Nonnull)url
                         options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *_Nonnull)options
                      completion:(void(^_Nonnull)(BOOL))completion;

/**
Called whether conformed instance is able to handle the universal link url.

@param url The universal link url to be checked.
@return `YES` if it is able to handle the universal link url.
*/
- (BOOL)mt_urlHandlerCanHandleUniversalLink:(NSURL *_Nullable)url;

/**
Called to handle the `universal link url`.

@param url The universal link url to be handled.
@param originalState A state value provided by the MT Link service to mitigate CSRF attacks.
@param viewController The view controller that the universal link should present from.
@param completion A block that is called after the userActivity is handled.
///                   The completion contains a null error if the activity is successfully handled.
///                   The completion contains a non-null error if the activity failed to be handled.
*/
- (void)mt_urlHandlerToHandleUniversalLink:(NSURL *_Nullable)url
                             originalState:(NSString *_Nullable)originalState
                               presentFrom:(UIViewController *_Nonnull)viewController
                                completion:(MTLinkCompletionBlock _Nonnull)completion;

@optional

- (void)mt_urlHandlerDidDismissSafariViewControllerWithError:(NSError *_Nullable)error;

/**
 User cancelled the process.
 */
- (void)mt_urlHandlerUserCancelled;

/**
 SDK Validates State on completion (Safari dismiss).
 Default value is YES.

 In Authorization code grant mode Client server redirects Safari to mtlink<clientid5digit>:// after token exchange.
 That's why SDK doesn't get(or need) final state for validation.

 @return NO to ignore state check on Safari dimiss.
 */
- (BOOL)validateStateOnCompletion;


/// This method should be called when a magic link is sent
/// To allow the url opener handler to perform magic link related logic accordingly
- (void)mt_urlHandlerAwaitingMagicLink;

/// This method should be called when magic link is handled.
/// To restore the operation state to be not expecting magic link anymore.
- (void)mt_urlHandlerDidHandleMagicLink;

/// This method is used to check if the url opener handler is awaiting magic link.
- (BOOL)mt_isAwaitingMagicLink;

@end

/** Url Opener Handler Related Error. */
static NSString *const MTUrlOpenerHandlerErrorDomain = @"MTUrlOpenerHandlerError";

typedef NS_ENUM(NSUInteger, MTUrlOpenerHandlerError) {
  /**
   An unknown error
   */
  MTUrlOpenerHandlerErrorUnknown,

  /**
   Tried to handle an URL that can not be handled by this handler
   */
  MTUrlOpenerHandlerErrorCanNotHandleUrl,

  /**
   Tried to handle an URL while no handler is available
  */
  MTUrlOpenerHandlerErrorNoHandlerAvailable,

  /**
   Tried to handle a universal link without platform or SDK version
  */
  MTUrlOpenerHandlerErrorNoSdkOrPlatformInformation,

  /**
   Tried to handle a universal link while the state value in the link differs from the one that is cached in the SDK
  */
  MTUrlOpenerHandlerErrorInconsistentStateValue,

  /**
   Tried to handle a universal link while the continue value in the link differs from the one that is cached in the SDK
  */
  MTUrlOpenerHandlerErrorInconsistentContinue,

  /**
   Received a callback URL with error
  */
  MTUrlOpenerHandlerErrorUrlWithError,

  /**
   The current url handler cannot handle a magic link operation
  */
  MTUrlOpenerHandlerErrorUnexpectedHandlerForMagicLink
};

NS_ASSUME_NONNULL_END
