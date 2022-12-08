//
//  UIViewController+PresentationHelpers.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree on 17/03/2020.
//  Copyright © 2012-present Moneytree. All rights reserved.


@import UIKit;

@interface UIViewController (PresentationHelpers)

/**
 The top most view controller of the `rootViewController` of the `keyWindow` from the `UIApplication`
 */
@property (class, readonly) UIViewController *_Nullable mt_topmostViewController;

/**
 Returns the top most view controller after recursively look for `presentedViewController`.
 */
@property (readonly) UIViewController *_Nullable mt_topmostViewController;

@end
