//
//  MTLConfiguration.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 5/22/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
#import <MoneytreeLinkCoreKit/MTLEnvironment.h>
#import <MoneytreeLinkCoreKit/MTLAuthenticationMethod.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTLConfiguration: NSObject<NSCopying>


/// Indicates the development environment. The default is MTLEnvironmentStaging.
@property (nonatomic) MTLEnvironment environment;

/// The authentication method to be used during login.
///
/// The Moneytree server will check feature availability and fall back as needed.
/// Please make sure that your Client ID supports the available features.
/// If the parameter is not provided the server will fall back to backwards compatibility mode,
/// selecting Passwordless or OTP if configured, otherwise presenting the Credentials flow.
@property (nonatomic, copy, nullable) MTLAuthenticationMethod authenticationMethod;


/// A list of request scopes. Use reserved values in MTLConstants.h that start with MTLClientScope.
@property (nonatomic, copy, nullable) NSArray<NSString *> *scopes;


/// The client ID fetched from the Info.plist
@property (nonatomic, copy, readonly) NSString *clientId;

/// Set true to restore session.
@property (nonatomic) BOOL stayLoggedIn;

@end

NS_ASSUME_NONNULL_END
