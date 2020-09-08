//
//  MTLConstants.h
//  MoneytreeLinkCoreKit
//
//  Created by Moneytree KK on 23/5/17.
//  Copyright © 2012-present Moneytree KK. All rights reserved.
//

@import Foundation;

#pragma mark - Macros

/** Assert that this is executed in main thread */
#define MTL_ASSERT_MAIN_THREAD NSAssert([[NSThread currentThread] isMainThread],\
@"%s[:%d] - Should be called from main thread. (%@)", __PRETTY_FUNCTION__, __LINE__, [NSThread currentThread]);

#define MTL_SUBCLASSES_MUST_IMPLEMENT\
  @throw [NSException exceptionWithName:@"MTAbstractBaseClass" reason:@"Subclasses must implement." userInfo:nil];

/** Casts, but returns nil if the object is not of a compatible class */
#define MTL_SAFE_CAST(object, Class) (Class *)([(object) isKindOfClass:[Class class]] ? (object) : nil)

/** Runs the block if defined, otherwise does nothing. Saves a lot of if statements. */
#define MTL_RUN_BLOCK(block, ...) (block ? block(__VA_ARGS__) : nil)

#pragma mark - Constants

extern NSString *const MTLClientScopeGuestRead;
extern NSString *const MTLClientScopeAccountsRead;
extern NSString *const MTLClientScopeTransactionsRead;
extern NSString *const MTLClientScopeTransactionsWrite;
extern NSString *const MTLClientScopeCategoriesRead;
extern NSString *const MTLClientScopeInvestmentAccountsRead;
extern NSString *const MTLClientScopeInvestmentTransactionsRead;
extern NSString *const MTLClientScopeRequestRefresh;
extern NSString *const MTLClientScopePointsRead;
extern NSString *const MTLClientScopePointTransactionsRead;
extern NSString *const MTLClientScopeNotificationsRead;

extern NSString *const MTLAPIDomain;

extern BOOL const MTLForceLogoutDefault;

//! Project version number for MoneytreeLinkCoreKit.
FOUNDATION_EXPORT double MoneytreeLinkCoreKitVersionNumber;

//! Project version string for MoneytreeLinkCoreKit.
FOUNDATION_EXPORT const unsigned char MoneytreeLinkCoreKitVersionString[];
