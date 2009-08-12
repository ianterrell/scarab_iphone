//
//  SMStore.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMStore.h"
#import "Issue.h"
#import "Transaction.h"

@implementation SMStore

@synthesize count;

+ (SMStore *)defaultStore {
  static SMStore *singleton = nil;
  if (singleton == nil)
    singleton = [[SMStore alloc] init];
  return singleton;
}

- (void)purchaseIssue:(Issue *)issue {
  [[SKPaymentQueue defaultQueue] addPayment:[SKPayment paymentWithProductIdentifier:issue.productIdentifier]];   
}

- (void)restoreAllTransactions {
  [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
  debugLog(@"store updated transactions");
  self.count = [transactions count];
  int numberInProgress = 0;
  for (SKPaymentTransaction *transaction in transactions) {
    self.count--;
    switch (transaction.transactionState) { 
      case SKPaymentTransactionStatePurchased: 
        [self completeOrRestoreTransaction:transaction isRestore:NO]; 
        break; 
      case SKPaymentTransactionStateFailed: 
        [self failedTransaction:transaction]; 
        break; 
      case SKPaymentTransactionStateRestored: 
        [self completeOrRestoreTransaction:transaction isRestore:YES]; 
        break;
      case SKPaymentTransactionStatePurchasing:
        numberInProgress++;
        break;
    } 
  }
  debugLog(@"store done with switch, number in progress: %d", numberInProgress);
  if (numberInProgress == 0)
    [AppDelegate hideHUDUsingAnimation:YES];
}

- (void)completeOrRestoreTransaction:(SKPaymentTransaction *)transaction isRestore:(BOOL)isRestore {
  // Logging
  debugLog(@"complete or restore transaction (is restore: %d)", isRestore);
  debugLog(@"transaction: %@", transaction);
  debugLog(@"date: %@", transaction.transactionDate);
  debugLog(@"identifier: %@", transaction.transactionIdentifier);
  debugLog(@"receipt: %@", [transaction.transactionReceipt base64Encoding]);
  if (isRestore) {  
    debugLog(@"original...");
    debugLog(@"date: %@", transaction.originalTransaction.transactionDate);
    debugLog(@"identifier: %@", transaction.originalTransaction.transactionIdentifier);
    debugLog(@"receipt: %@", [transaction.originalTransaction.transactionReceipt base64Encoding]);
  }
  
  Issue *issue = [Issue issueWithProductIdentifier:transaction.payment.productIdentifier];
  
  // Don't restore ones that are already recorded as purchased
  if (isRestore && [issue hasBeenPurchased]) {
    debugLog(@"We've already purchased this issue to restore, returning.");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    return;
  }
  
  if ([Transaction saveOnServer:transaction]) {  
    debugLog(@"Transaction saved on server.");
    issue.transactionIdentifier = transaction.transactionIdentifier;
    NSError *error = nil;
    [AppDelegate save:&error];
    if (error) {
      debugLog(@"Error saving new issues in Library:  %@", [error localizedDescription]);
      // TODO: FIXME BITCH WHAT DO I DO?
    } else {
      [[SKPaymentQueue defaultQueue] finishTransaction:transaction]; 
      
      if (!isRestore)
        TTOpenURL([NSString stringWithFormat:@"scarab://issues/%@", issue.number]); 
      else if (self.count == 0)
        TTOpenURL(@"scarab://library");
    }    
  } else {
    debugLog(@"Transaction not saved on server.");
    // TODO: Alert the user that the next time the app starts up we'll try again.
    // We're pretty much assuming that they're not hacking here.
  }
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
  debugLog(@"failed transaction");
  debugLog(@"transaction: %@", transaction);
  debugLog(@"error: %@", transaction.error);
  debugLog(@"error desc: %@, failure reason: %@, suggestion: %@", transaction.error.localizedDescription, transaction.error.localizedFailureReason, transaction.error.localizedRecoverySuggestion);
  debugLog(@"date: %@", transaction.transactionDate);
  debugLog(@"identifier: %@", transaction.transactionIdentifier);
//  if (transaction.error != SKErrorPaymentCancelled) { 
//    debugLog(@"other error");
//  } else {
//    debugLog(@"payment canceled");
//  }
  [[SKPaymentQueue defaultQueue] finishTransaction: transaction]; 
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
  debugLog(@"restore transaction");
  debugLog(@"transaction: %@", transaction);
  debugLog(@"date: %@", transaction.transactionDate);
  debugLog(@"identifier: %@", transaction.transactionIdentifier);
  debugLog(@"receipt: %@", [transaction.transactionReceipt base64Encoding]);
  
}

//- (void) requestProductData { 
////    NSSet *myID = [NSSet setWithObject: @"com.myapp.subscriptionApp"]; 
////    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: myID];
//  SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:@"1_Issue", @"6_Month_Subscription",@"12_Month_Subscription",nil]]; 
//  request.delegate = self;
//  [request start]; 
//}
// 
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response { 
//  NSArray *myProducts = response.products; 
//  // populate UI 
//  
//  NSLog(@"Hey yo");
//  for (SKProduct *product in myProducts) {
//    NSLog(@"Product: %@", product);
//  }
//} 


@end
