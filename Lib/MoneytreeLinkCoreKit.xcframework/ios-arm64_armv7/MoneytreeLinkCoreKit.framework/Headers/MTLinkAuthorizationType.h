//
//  MTLinkAuthorizationType.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 06/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


@import Foundation;

typedef NS_ENUM(NSUInteger, MTLinkAuthorizationType) {
  /**
   Authorize via PKCE
   */
  MTLinkAuthorizationTypePKCE = 0,

  /**
   Authorize via Code Grant
   */
  MTLinkAuthorizationTypeCodeGrant = 1
};
