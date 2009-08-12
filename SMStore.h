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
  int count;
}

@property(nonatomic,assign) int count;

+ (SMStore *)defaultStore;

- (void)purchaseIssue:(Issue *)issue;
- (void)restoreAllTransactions;

- (void)failedTransaction:(SKPaymentTransaction *)transaction;
- (void)completeOrRestoreTransaction:(SKPaymentTransaction *)transaction isRestore:(BOOL)isRestore;

@end
