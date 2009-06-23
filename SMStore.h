//
//  SMStore.h
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Issue;

@interface SMStore : NSObject <SKPaymentTransactionObserver> {

}

+ (SMStore *)defaultStore;

- (void)purchaseIssue:(Issue *)issue;

- (void)completeTransaction:(SKPaymentTransaction *)transaction;
- (void)failedTransaction:(SKPaymentTransaction *)transaction;
- (void)restoreTransaction:(SKPaymentTransaction *)transaction;

@end
