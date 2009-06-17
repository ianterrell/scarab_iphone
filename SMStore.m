//
//  SMStore.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMStore.h"

@implementation SMStore

- (void) requestProductData { 
//    NSSet *myID = [NSSet setWithObject: @"com.myapp.subscriptionApp"]; 
//    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: myID];
  SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:@"1_Issue", @"6_Month_Subscription",@"12_Month_Subscription",nil]]; 
  request.delegate = self;
  [request start]; 
}
 
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response { 
  NSArray *myProducts = response.products; 
  // populate UI 
  
  NSLog(@"Hey yo");
  for (SKProduct *product in myProducts) {
    NSLog(@"Product: %@", product);
  }
} 


@end
