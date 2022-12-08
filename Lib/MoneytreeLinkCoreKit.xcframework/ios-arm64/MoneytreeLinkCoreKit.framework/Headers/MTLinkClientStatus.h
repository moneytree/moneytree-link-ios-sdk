//
//  MTLinkClientStatus.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 03/06/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


typedef NS_ENUM(NSUInteger, MTLinkClientStatus) {
  /**
   A status that represents an error. Please check the error passed in the delegate callback for more information.
   */
  MTLinkClientStatusError = 0,

  /**
   A status that represents a vault close event, value: 1
   */
  MTLinkClientStatusVaultDidClose = 1,

  /**
   A status that represents an event where the user has successfully added a new credential through a 3rd party oauth flow
   value: 2
  */
  MTLinkClientStatusNewCredentialAddedViaThirdPartyOauth = 2
};
