//
//  IssuePriceFetcherManager.m
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "IssuePriceFetcherManager.h"

#define kInitialFetchersCapacity 2

#import "Issue.h"
#import "IssuePreviewController.h"
#import "IssuePriceFetcher.h"

@implementation IssuePriceFetcherManager

@synthesize fetchers;

+ (IssuePriceFetcherManager *)defaultManager {
  static IssuePriceFetcherManager *singleton = nil;
  if (singleton == nil)
    singleton = [[IssuePriceFetcherManager alloc] init];
  return singleton;
}

- (IssuePriceFetcherManager *)init {
  if ([super init] == self)
    self.fetchers = [NSMutableDictionary dictionaryWithCapacity:kInitialFetchersCapacity];
  return self;
}

- (void)fetchPriceForIssue:(Issue *)issue previewController:(IssuePreviewController *)controller {
  IssuePriceFetcher *fetcher = [fetchers objectForKey:issue.productIdentifier];
  if (fetcher == nil) {
    fetcher = [[IssuePriceFetcher alloc] initWithIssue:issue controller:controller];
    [fetchers setObject:fetcher forKey:issue.productIdentifier];
    [fetcher release];
  } else {
    fetcher.controller = controller;
  }
}

- (void)doneWithFetchForIssue:(Issue *)issue {
  [fetchers removeObjectForKey:issue.productIdentifier];
}

@end
