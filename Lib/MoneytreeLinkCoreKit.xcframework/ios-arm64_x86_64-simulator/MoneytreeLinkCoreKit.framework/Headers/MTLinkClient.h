//
//  MTLinkClient.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 15/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;
@import UIKit;
@class MTAPI;

#import <MoneytreeLinkCoreKit/MTLinkClientDelegate.h>

#import <MoneytreeLinkCoreKit/MTAPIComponents.h>
#import <MoneytreeLinkCoreKit/MTLConfiguration.h>
#import <MoneytreeLinkCoreKit/MTLCompletions.h>
#import <MoneytreeLinkCoreKit/MTLAuthenticationOptions.h>
#import <MoneytreeLinkCoreKit/MTLinkAuthorizationType.h>
#import <MoneytreeLinkCoreKit/MTMagicLinkDestination.h>



NS_ASSUME_NONNULL_BEGIN

/**
 Responsible for the configuration of the Moneyrtee Link's SDK
 */
@interface MTLinkClient: NSObject <MTOAuthCredentialProvider>

- (instancetype)init __attribute__((unavailable("Call static instance +initWithConfiguration: instead")));

/**
 @abstract
 SDK should be intialized using this method.

 @discussion
 Use MTLinkClient.sharedClient after configuring SDK once.
 Calling this method twice throws exception @"MTLinkClient Already Configured", .

 @param configuration MTLConfiguration to initialize SDK
 @return A singleton instance for Moneytree Link Client.
 */
+ (instancetype)clientWithConfiguration:(MTLConfiguration *)configuration;

/**
 A singleton instance for Moneytree Link Client.
 Make sure clientWithConfiguration has been already called before using sharedClient.
 */
@property (class, readonly) MTLinkClient *sharedClient;

/**
A delegate object which provides some changes that you might be interest in inside the SDK
*/
@property (nonatomic, weak) id<MTLinkClientDelegate> delegate;

/**
 The enum that represents the current SDK environment.
 Make sure to set MTLEnvironmentProduction/.production for production in MTLConfiguration during SDK initialization
 */
@property (nonatomic, readonly) MTLEnvironment currentEnvironment;

/**
 Returns the current configuration that is used by the client.
 */
@property (nonatomic, copy, readonly) MTLConfiguration *currentConfiguration;

/**
 Check whether stay logged in true or false
 */
@property (nonatomic, readonly) BOOL stayLoggedIn;

/// Presents an `SFSafariViewController` for signing up or logging in to Moneytree LINK.
///
/// Behavior can be configured via `MTLAuthenticationOptions`.
///
/// Upon completion, you will receive an `MTOAuthCredential`. If you have a server component that uses access tokens, please see our guides at https://docs.link.getmoneytree.com/ for best practices how to manage this credential.
///
/// @param viewController A view controller from which to present the SFSafariViewController.
/// @param options Configuration options for the authorization process.
/// @param animated Present the SFSafariViewController with standard system animation.
/// @param completion A closure that contains either the OAuth credential, or an error in case of failure or cancellation by the user.
- (void)authorizeFrom:(UIViewController *)viewController
              options:(id<AuthenticationOptions>)options
             animated:(BOOL)animated
           completion:(MTLinkClientCredentialFetchCompletionBlock)completion
NS_SWIFT_NAME( authorize(_:options:animated:completion:) );

/// Present an instance of `SFSafariViewController` for Passwordless Signup to Moneytree LINK, pre-filled with the specified email address.
///
/// @param viewController A view controller from which to present the SFSafariViewController.
/// @param email The user's email address.
/// @param animated Present the SFSafariViewController with standard system animation.
/// @param completion A closure that contains either the OAuth credential, or an error in case of failure or cancellation by the user.
- (void)onboardFrom:(UIViewController *)viewController
              email:(NSString *)email
           animated:(BOOL)animated
         completion:(MTLinkClientCredentialFetchCompletionBlock)completion
NS_SWIFT_NAME(onboard(_:email:animated:completion:));

/**
 Present an instance of `SFSafariViewController` to open Universal Vault homepage

 If guest is not logged in then it will show login screen, after successfull login it will show vault.
 When guest didn't authorize partner then it will also show Authorize dialog

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param animated An option to present with animation
 @param email The email to be populated on the login screen if the guest needs to be authorized
 @param completion A closure that is always called when Safari is dismissed.
                   Closure contains client MTCredential on successful authorization, or error if there is any.
                   (credential only exists in closure when sdk is in pkce mode and authorization screen is shown,
                   credential is always nil when authorization code grant mode is in use).
*/
- (void)openVaultFromViewController:(UIViewController *)viewController
                           animated:(BOOL)animated
                              email:(NSString *_Nullable)email
                         completion:(MTLinkCompletionBlock)completion;

/**
 Present an instance of `SFSafariViewController` to open Universal Vault's services page. The list of services displayed can be customized by the `options` parameter

 If guest is not logged in then it will show login screen, after successfull login it will show vault.
 When guest didn't authorize partner then it will also show Authorize dialog

 The vault will show an localised error message if the options supplied are not valid.

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param animated An option to present with animation
 @param email The email to be populated on the login screen if the guest needs to be authorized
 @param options Dictionary of parameters `type`, `group` and `search`
 @param completion A closure that is always called when Safari is dismissed.
 Closure contains client MTCredential on successful authorization, or error if there is any.
 (credential only exists in closure when sdk is in pkce mode and authorization screen is shown,
 credential is always nil when authorization code grant mode is in use).
*/
- (void)openServicesFromViewController:(UIViewController *)viewController
                              animated:(BOOL)animated
                                 email:(NSString *_Nullable)email
                               options:(NSDictionary<NSString *, NSString*> *_Nullable)options
                            completion:(MTLinkCompletionBlock)completion;

/**
 Present an instance of `SFSafariViewController` to open Universal Vault at a specific service page.

 If guest is not logged in then it will show login screen, after successfull login it will show vault.
 When guest didn't authorize partner then it will also show Authorize dialog

 The root of the vault would show if the `entityKey` is invalid.

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param animated An option to present with animation
 @param email The email to be populated on the login screen if the guest needs to be authorized
 @param entityKey The service's Entity Key
 @param completion A closure that is always called when Safari is dismissed.
 Closure contains client MTCredential on successful authorization, or error if there is any.
 (credential only exists in closure when sdk is in pkce mode and authorization screen is shown,
 credential is always nil when authorization code grant mode is in use).
*/
- (void)connectServiceFromViewController:(UIViewController *)viewController
                                animated:(BOOL)animated
                                   email:(NSString *_Nullable)email
                               entityKey:(NSString *)entityKey
                              completion:(MTLinkCompletionBlock)completion;

/**
 Present an instance of `SFSafariViewController` to open Universal Vault at a specific connection settings page

 If guest is not logged in then it will show login screen, after successfull login it will show vault.
 When guest didn't authorize partner then it will also show Authorize dialog

 The root of the vault would show if the `credentialId` is invalid.

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param animated An option to present with animation
 @param email The email to be populated on the login screen if the guest needs to be authorized
 @param credentialId The credential's ID
 @param completion A closure that is always called when Safari is dismissed.
 Closure contains client MTCredential on successful authorization, or error if there is any.
 (credential only exists in closure when sdk is in pkce mode and authorization screen is shown,
 credential is always nil when authorization code grant mode is in use).
*/
- (void)serviceSettingsFromViewController:(UIViewController *)viewController
                                 animated:(BOOL)animated
                                    email:(NSString *_Nullable)email
                             credentialId:(NSString *)credentialId
                               completion:(MTLinkCompletionBlock)completion;

/**
 Present an instance of `SFSafariViewController` to open the Customer Support page on Universal Vault

 If guest is not logged in then it will show login screen, after successfull login it will show vault.
 When guest didn't authorize partner then it will also show Authorize dialog

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param animated An option to present with animation
 @param email The email to be populated on the login screen if the guest needs to be authorized
 @param completion A closure that is always called when Safari is dismissed.
 Closure contains client MTCredential on successful authorization, or error if there is any.
 (credential only exists in closure when sdk is in pkce mode and authorization screen is shown,
 credential is always nil when authorization code grant mode is in use).
*/
- (void)openCustomerSupportFromViewController:(UIViewController *)viewController
                                     animated:(BOOL)animated
                                        email:(NSString *_Nullable)email
                                   completion:(MTLinkCompletionBlock)completion;

/**
 Present an instance of `SFSafariViewController` to open a settings page for a guest of Moneytree.

 @param viewController The view controller that is used to present the Settings screen
 @param animated To present with or without animation
 @param completion A closure that contains error when SDK could not open settings
 */
- (void)openSettingsFromViewController:(UIViewController *)viewController
                              animated:(BOOL)animated
                            completion:(MTLinkCompletionBlock)completion;

/**
 Present an instance of `SFSafariViewController` to open a settings page for a guest of Moneytree,
 with their email address pre-filled.

 @param viewController The view controller that is used to present the Settings screen
 @param email The guest's email address
 @param animated To present with or without animation
 @param completion A closure that contains error when SDK could not open settings
 */
- (void)openSettingsFromViewController:(UIViewController *)viewController
                                 email:(NSString *_Nullable)email
                              animated:(BOOL)animated
                            completion:(MTLinkCompletionBlock)completion;

/**
  Request for a Login Link to be sent to a given email address.

  @param email The guest's email address
  @param destination The destination in Moneytree LINK that the link will redirect to
  @param completion A closure that is called on the main thread once the request is completed.
                    Closure contains a null NSError on successful responses.
                    Closure contains a non-null NSError on failure responses.
*/
- (void)requestForLoginLinkForEmail:(NSString *)email
                                 to:(MTMagicLinkDestination)destination
                         completion:(MTLinkCompletionBlock)completion;

/** @name Token Management */

/**
  Checks whether guest is logged into SDK or NOT.
  Returns true if guest is logged in.
  When stayLoggedIn is set to false then return value is based on token is expired or not.
 */
@property (nonatomic, readonly) BOOL isLoggedIn;

/// Remove all tokens from Keychain storage. Note that this does not invalidate or revoke tokens.
- (void)removeAllTokens;

/**
 Logout guest from SDK, Presents SFSafariViewController to logout Guest session inside SFSafariViewController.
 SFSafariViewController is automatically dismissed after logout url loading finished.

 @param viewController to present SFSafariViewController
 @param completion A closure to be called when logout finish.
 */
- (void)logoutFromViewController:(UIViewController *)viewController completion:(MTLinkCompletionBlock)completion;

/** @name API */

/**
 @abstract
 Only for PKCE authorization flow.
 Nil when using Code Grant authorization flow.

 @discussion
 Returns an API instance that can be used to execute api requests.
 */
@property (nonatomic, copy, readonly, nullable) MTAPI *api;

#pragma mark - Deprecated

/**
 @abstract
 Only for General Auth flow

 @discussion
 Present an instance of `SFSafariViewController` to open authorize screen where a guest has credentials

 If not logged in then it will show login and authorize screen.
 If logged in already then it will show authorize screen.

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param authOptions to configure authorization process
 @param animated An option to present with animation
 @param completion A closure that contains partner credential, or error when authrorization or login failed.
        A closure that is always called when Safari is dismissed (either guest dismiss it or sdk dismiss it on auth completion)
 */
- (void)authorizeUsingPkceFrom:(UIViewController *)viewController
                   authOptions:(id<AuthenticationOptions>)authOptions
                      animated:(BOOL)animated
                    completion:(MTLinkClientCredentialFetchCompletionBlock)completion
DEPRECATED_MSG_ATTRIBUTE("Please use authorizeFrom:options:animated:completion: instead.");

/**
 @abstract
 Only for AuthorizationCodeGrant flow

 @discussion
 Present an instance of `SFSafariViewController` to open authorize screen where a guest has credentials

 If not logged in then it will show login and authorize screen.
 If logged in already then it will show authorize screen.

 This must be use only when using AuthorizationCodeGrant

 The whole process is redirected back to the main app through:
 `UIApplicationDelegate`'s method `- application:openURL:options:`

 @param viewController The view controller that is used to present the vault
 @param state will be appended in redirect url for mitigating CSRF attacks
 @param authOptions to configure authorization process
 @param animated An option to present with animation
 @param completion A closure that contain error when authorization or login failed.
        A closure that is always called when Safari is dismissed (either guest dismiss it or sdk dismiss it on auth completion)
 */
- (void)authorizeUsingCodeGrantFrom:(UIViewController *)viewController
                              state:(NSString *)state
                        authOptions:(id<AuthenticationOptions>)authOptions
                           animated:(BOOL)animated
                         completion:(MTLinkCompletionBlock)completion
DEPRECATED_MSG_ATTRIBUTE("Code Grant without PKCE is not supported anymore. Will be removed in the next major version. Migration guide at https://docs.link.getmoneytree.com/docs/migrate-auth-to-pkce");

/**
 Present an instance of `SFSafariViewController` to open the onboarding authorization page pre-filled with
 the specified email address.

 @param viewController The view controller that is used to present the onboarding screen.
 @param authorizationType The authorization type you wish to go with. (PKCE or Code Grant).
 @param email The user's email address.
 @param state will be appended in redirect url for mitigating CSRF attacks,
              this parameter should NOT be nil for Code Grant authorization type.
 @param region An extensible enum that represents the region of the authorization process
 @param animated An option to present with animation.
 @param completion A closure that is always called when Safari is dismissed.
                   Closure contains non-null MTCredential on successful authorization via PKCE.
                   Closure contains null MTCredential on successful authorization via Code Grant.
                   Closure contains an error if the authorization errors out.
*/
- (void)onboardFrom:(UIViewController *)viewController
  authorizationType:(MTLinkAuthorizationType)authorizationType
              email:(NSString *)email
              state:(NSString *_Nullable)state
             region:(MTAuthRegion)region
           animated:(BOOL)animated
         completion:(MTLinkClientCredentialFetchCompletionBlock)completion
DEPRECATED_MSG_ATTRIBUTE("Use onboardFrom:email:animated:completion instead. Code Grant without PKCE is not supported anymore. It will be removed in the next major version. Migration guide at https://docs.link.getmoneytree.com/docs/migrate-auth-to-pkce");

- (void)requestForMagicLinkForEmail:(NSString *)email
                                 to:(MTMagicLinkDestination)destination
                         completion:(MTLinkCompletionBlock)completion
DEPRECATED_MSG_ATTRIBUTE("Use requestForLoginLinkForEmail:to:completion instead.");

#pragma mark - Internal - Do not use

/// This is currently reserved for internal usage. Please do not use it as it may be deprecated without warning.
- (void)upgradeTokenFrom:(UIViewController *)viewController
             authOptions:(id<AuthenticationOptions>)authOptions
                animated:(BOOL)animated
              completion:(MTLinkClientCredentialFetchCompletionBlock)completion;

/// This is currently reserved for internal usage. Please do not use it as it may be deprecated without warning.
- (void)openVaultFromViewController:(UIViewController *)viewController
                           animated:(BOOL)animated
                               path:(NSString *_Nullable)path
                            options:(NSDictionary <NSString *, NSString *> *)options
                              email:(NSString *_Nullable)email
                         completion:(MTLinkCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
