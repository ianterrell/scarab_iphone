//
//  IssuePriceFetcher.m
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "IssuePriceFetcher.h"

#import "Issue.h"
#import "IssuePreviewController.h"
#import "IssuePriceFetcherManager.h"

@implementation IssuePriceFetcher

@synthesize controller, issue;

- (IssuePriceFetcher *)initWithIssue:(Issue *)_issue controller:(IssuePreviewController *)_controller {
  if (self == [super init]) {
    debugLog(@"issue is %@", _issue);
    self.issue = _issue;
    self.controller = _controller;
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.issue.productIdentifier]]; 
    request.delegate = self;
    [request start]; 
  }
  return self;
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response { 
  if ([response.products count] > 0) {
    SKProduct *product = [response.products objectAtIndex:0];
    [controller updatePurchaseButtonWithPrice:[product localizedPrice]];
  } else {
    TTAlert(@"Oops! The AppStore doesn't have this issue in it yet. Sometimes it can take a few days to propagate through their servers. Please be patient and try again tomorrow! Sorry!");
  }
} 

- (void)requestDidFinish:(SKRequest *)request {
  [[IssuePriceFetcherManager defaultManager] doneWithFetchForIssue:issue];
}

- (void)dealloc {
  debugLog(@"Deallocing price fetcher");
  [issue release];
  [controller release];
  [super dealloc];
}


@end
