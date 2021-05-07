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
   An unknown error
   */
  MTLinkClientErrorUnknown = 0,

  /**
   Error when guest is cancelling authorization (manually closes the `SFSafariViewController`)
   */
  MTLinkClientErrorGuestCancelledAuthorization = 1,

  /**
   Error when trying to authorize while there is one authorization in progress
   */
  MTLinkClientAuthorizationInProgress = 2,

  /**
   Error when trying to open either vault or pfm (IT) but the guest has not linked yet.
   */
  MTLinkClientErrorGuestNotLinked = 888,

  /**
   Error when trying to call SDK API Interface which is not available in PKCE mode
   */
  MTLinkClientErrorUnavailableInPKCEMode = 901,

  /**
   Error when trying to call SDK API Interface which is not available in Authorization code grant mode
   */
  MTLinkClientErrorUnavailableInAuthorizationCodeGrantMode = 902
};
