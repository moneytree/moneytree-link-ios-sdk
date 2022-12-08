//
//  MTLinkKit.h
//  MoneytreeLINKKit
//
//  Created by Moneytree KK on 14/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/// This class is the entry point for Moneytree LINK Kit's PFM web app.
@interface MTLinkKit: NSObject

- (instancetype)init __attribute__((unavailable("Call shared instance +sharedClient instead")));;

/**
 A shared instance of the LINK Kit entry point.
 */
@property (class, readonly) MTLinkKit *sharedClient NS_SWIFT_NAME(shared);

/// The scopes required for LINK Kit.
@property (class, readonly) NSArray<NSString *>* linkKitScopes;

/// Make a new LINK Kit view controller instance asynchronously and provide it to a completion handler.
/// @param completion A closure that gets called with the created view controller after the process of getting the token and link is succesful.
- (void)makeLinkKitViewController:(void(^)(UIViewController *_Nullable, NSError *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
