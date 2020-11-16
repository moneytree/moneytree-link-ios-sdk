//
//  MTIsshoTsucho.h
//  MoneytreeIsshoTsucho
//
//  Created by Moneytree KK on 14/9/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/// This class is the entry point for Moneytree LINK Kit's PFM web app.
///
/// Version one was known as Issho Tsucho. Version two is known as LINK Kit.
@interface MTIsshoTsucho: NSObject

- (instancetype)init __attribute__((unavailable("Call shared instance +sharedClient instead")));;

/**
 A shared instance of the LINK Kit entry point.
 */
@property (class, readonly) MTIsshoTsucho *sharedClient NS_SWIFT_NAME(shared);

/// The scopes required for LINK Kit.
@property (nonatomic, copy) NSArray<NSString *>* linkKitScopes;

/**
 Make a new Issho Tsucho view controller instance and call the `completion` with the view controller
 after the whole process of getting token and linked is successful.

 @param completion A closure that gets called with the created view controller
                   after the process of getting token and link is successful.
 */
- (void)makeViewControllerWithCompletion:(void(^)(UIViewController *_Nullable, NSError *_Nullable))completion;


/// Make a new LINK Kit view controller instance asynchronously and provide it to a completion handler.
/// @param completion A closure that gets called with the created view controller after the process of getting the token and link is succesful.
- (void)makeLinkKitViewController:(void(^)(UIViewController *_Nullable, NSError *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
