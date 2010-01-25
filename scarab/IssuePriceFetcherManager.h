//
//  IssuePriceFetcherManager.h
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Issue;
@class IssuePreviewController;

@interface IssuePriceFetcherManager : NSObject {
  NSMutableDictionary *fetchers;
}

@property(nonatomic,retain) NSMutableDictionary *fetchers;

+ (IssuePriceFetcherManager *)defaultManager;

- (void)fetchPriceForIssue:(Issue *)issue previewController:(IssuePreviewController *)controller;
- (void)doneWithFetchForIssue:(Issue *)issue;

@end
