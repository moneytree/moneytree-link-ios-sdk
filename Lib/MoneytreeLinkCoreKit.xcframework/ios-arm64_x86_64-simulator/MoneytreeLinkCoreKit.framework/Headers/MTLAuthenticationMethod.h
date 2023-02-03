//
//  MTLAuthenticationMethod.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 2022/11/15.
//  Copyright © 2012-present Moneytree. All rights reserved.


@import Foundation;

/// Use MTLAuthenticationMethod to specify the authentication method you would prefer to present to your users.
/// Note that some methods require your client ID to be appropriately configured before it is possible to successfully present them.
/// If there is configuration missing, the authentication method presented will fall back to the next correctly configured method.
/// - Single Sign On will fall back to Passwordless, if it is configured; otherwise, it will fall back to Credentials.
/// - Passwordless will fall back to Credentials.
/// - Credentials is always available.
typedef NSString *MTLAuthenticationMethod NS_EXTENSIBLE_STRING_ENUM;

extern MTLAuthenticationMethod const MTLAuthenticationMethodCredentials;
extern MTLAuthenticationMethod const MTLAuthenticationMethodPasswordless;
extern MTLAuthenticationMethod const MTLAuthenticationMethodSingleSignOn;
