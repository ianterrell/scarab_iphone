//
//  Transaction.m
//  Scarab
//
//  Created by Ian Terrell on 6/22/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

@synthesize transactionId, receipt;

+ (BOOL)saveOnServer:(SKPaymentTransaction *)paymentTransaction {
  Transaction *transaction = [[Transaction alloc] init];
  transaction.receipt = [paymentTransaction.transactionReceipt base64Encoding];
  debugLog(@"saving!");
  return [transaction saveRemote];  // if YES then it passed the Rails validations, which include validating with Apple
}

- (void)dealloc {
  [transactionId release];
  [receipt release];
  [super dealloc];
}


@end
