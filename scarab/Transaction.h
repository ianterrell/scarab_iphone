//
//  Transaction.h
//  Scarab
//
//  Created by Ian Terrell on 6/22/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject {
  NSNumber *transactionId;
  NSString *receipt;
}

@property(nonatomic,retain) NSNumber *transactionId;
@property(nonatomic,retain) NSString *receipt;

+(BOOL)saveOnServer:(SKPaymentTransaction *)transaction;

@end