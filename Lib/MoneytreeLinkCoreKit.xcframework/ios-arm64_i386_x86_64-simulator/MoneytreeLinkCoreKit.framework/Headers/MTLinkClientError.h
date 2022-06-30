//
//  MTLinkClientError.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 12/7/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

/** MT Link Client Related Error. */
extern NSString *const MTLinkClientErrorDomain;

typedef NS_ENUM(NSInteger, MTLinkClientError) {
  /**
   * Moneytree LINK has returned an unexpected value.
   *
   * Some cases in which this may occur are:
   * - The redirect URL is missing expected parameters
   * - The redirect URL is not a valid URL
   * - The OAuth credential is not returned as expected
   *
   * Note that this is does not cover all possible cases.
   *
   * If you encounter this error, please contact Moneytree.
   */
  MTLinkClientErrorUnknown = 0,

  /**
   * The user did not complete the authorization process.
   *
   * This error is triggered when the user closes the in-app browser, or if the user cancels authorization of your app on the screen that lists the scopes your app is requesting.
   */
  MTLinkClientErrorGuestCancelledAuthorization = 1,

  /**
   * Another authorization process is currently in progress.
   *
   * This happens if a user has initiated Passwordless Login, and then the client calls `authorize`.
   *
   * The Passwordless Login process can be overridden by setting `MTLAuthenticationOptions.forceLogout` to `true`.
   */
  MTLinkClientAuthorizationInProgress = 2,

  /**
   * The user has not yet authorized your app to access Moneytree LINK on their behalf.
   */
  MTLinkClientErrorGuestNotLinked = 888,

  /**
   * This functionality is not available to configurations authenticating via PKCE.
   *
   * Currently, there is no functionality that is only available in Code Grant without PKCE mode, so clients should never see this error.
   *
   * If you encounter this error, please contact Moneytree.
   */
  MTLinkClientErrorUnavailableInPKCEMode = 901,

  /**
   * This functionality is not available to configurations authenticating via Code Grant without PKCE.
   *
   * Functionality limited to authenticating via PKCE configurations include:
   * - Registering and unregistering a device for push notifications
   * - LINK Kit
   *
   * If you intended to use PKCE, please ensure that your `MTLConfiguration.redirectURI` is `nil`.
   * If your use case requires Code Grant without PKCE, as well as this functionality, please contact Moneytree.
   */
  MTLinkClientErrorUnavailableInAuthorizationCodeGrantMode = 902
};
