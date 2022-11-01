//
//  MTLinkAuthorizationType.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 06/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


@import Foundation;

typedef NS_ENUM(NSUInteger, MTLinkAuthorizationType) {
  /**
   Authorize via Code Grant with PKCE
   */
  MTLinkAuthorizationTypePKCE = 0,

  /**
   Authorize via Code Grant without PKCE
   */
  MTLinkAuthorizationTypeCodeGrant = 1
} __deprecated_enum_msg("Code Grant without PKCE is not supported anymore. This enum will be removed in the next major version. Migration guide at https://docs.link.getmoneytree.com/docs/migrate-auth-to-pkce");
