//
//  MTMagicLinkDestination.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 20/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.

@import Foundation;

// Extensible enum which is used to specify the destination of a magic link
typedef NSString *MTMagicLinkDestination NS_EXTENSIBLE_STRING_ENUM;

extern MTMagicLinkDestination const MTMagicLinkDestinationSettings;
extern MTMagicLinkDestination const MTMagicLinkDestinationChangeLanguage;
extern MTMagicLinkDestination const MTMagicLinkDestinationDeleteAccount;
extern MTMagicLinkDestination const MTMagicLinkDestinationAuthorizedApplications;
extern MTMagicLinkDestination const MTMagicLinkDestinationEmailPreferences;
extern MTMagicLinkDestination const MTMagicLinkDestinationUpdateEmail;
extern MTMagicLinkDestination const MTMagicLinkDestinationUpdatePassword;
