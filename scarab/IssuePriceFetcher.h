//
//  IssuePriceFetcher.h
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Issue;
@class IssuePreviewController;

@interface IssuePriceFetcher : NSObject <SKProductsRequestDelegate> {
  Issue *issue;
  IssuePreviewController *controller;
}

@property(nonatomic,retain)Issue *issue;
@property(nonatomic,retain) IssuePreviewController *controller;

- (IssuePriceFetcher *)initWithIssue:(Issue *)issue controller:(IssuePreviewController *)controller ;

@end
