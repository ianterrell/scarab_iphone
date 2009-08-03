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

+ (SMStore *)defaultStore {
  static SMStore *singleton = nil;
  if (singleton == nil)
    singleton = [[SMStore alloc] init];
  return singleton;
}

- (void)purchaseIssue:(Issue *)issue {
  [[SKPaymentQueue defaultQueue] addPayment:[SKPayment paymentWithProductIdentifier:issue.productIdentifier]];   
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
  debugLog(@"store updated transactions");
  int numberInProgress = 0;
  for (SKPaymentTransaction *transaction in transactions) {
    switch (transaction.transactionState) { 
      case SKPaymentTransactionStatePurchased: 
        [self completeTransaction:transaction]; 
        break; 
      case SKPaymentTransactionStateFailed: 
        [self failedTransaction:transaction]; 
        break; 
      case SKPaymentTransactionStateRestored: 
        [self restoreTransaction:transaction]; 
        break;
      case SKPaymentTransactionStatePurchasing:
        numberInProgress++;
        break;
    } 
  }
  debugLog(@"store done with switch, number in progress: %d", numberInProgress);
  // TODO: This might need tweaked once I do restoring transactions, hard to say how many times this will get called
  if (numberInProgress > 0)
    [AppDelegate showHUDWithLabel:nil details:@"Purchasing" animated:YES];
  else
    [AppDelegate hideHUDUsingAnimation:YES];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
  // We just bought an issue.
  
  if ([Transaction saveOnServer:transaction]) {  
    debugLog(@"Transaction saved on server.");
    // Update issue in database to have transaction identifier that purchased it
    Issue *issue = [Issue issueWithProductIdentifier:transaction.payment.productIdentifier];
    issue.transactionIdentifier = transaction.transactionIdentifier;
    NSError *error = nil;
    [AppDelegate save:&error];
    if (error) {
      debugLog(@"Error saving new issues in Library:  %@", [error localizedDescription]);
      // TODO: FIXME BITCH WHAT DO I DO?
    }
    
    TTOpenURL([NSString stringWithFormat:@"scarab://issues/%@", issue.number]);
        
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction]; 
  } else {
    debugLog(@"Transaction not saved on server.");
    // Alert the user that the next time the app starts up we'll try again.
    // We're pretty much assuming that they're not hacking here.
  }
  


  debugLog(@"complete transaction");
  debugLog(@"transaction: %@", transaction);
  debugLog(@"date: %@", transaction.transactionDate);
  debugLog(@"identifier: %@", transaction.transactionIdentifier);
  debugLog(@"receipt: %@", [transaction.transactionReceipt base64Encoding]);
  
  
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
  
  debugLog(@"original...");
  debugLog(@"date: %@", transaction.originalTransaction.transactionDate);
  debugLog(@"identifier: %@", transaction.originalTransaction.transactionIdentifier);
  debugLog(@"receipt: %@", [transaction.originalTransaction.transactionReceipt base64Encoding]);
}

- (void)test {
  debugLog(@"starting test...");
  //
  [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
  
//  SKPayment *payment = [SKPayment paymentWithProductIdentifier:@"12_Month_Subscription"]; 
//  SKPayment *payment = [SKPayment paymentWithProductIdentifier:@"issue_test_nonconsumable"]; 
//  [[SKPaymentQueue defaultQueue] addPayment:payment];   
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
