//
//  LibraryViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Issue;

@interface LibraryViewController : UITableViewController {
  BOOL fetchedNewIssues;
  
  NSMutableArray *issuesInDb;
  Issue *currentIssue;
  NSMutableArray *bookshelfIssues;
  NSMutableArray *backIssues;
}

@property(nonatomic,retain) NSMutableArray *issuesInDb;
@property(nonatomic,retain) Issue *currentIssue;
@property(nonatomic,retain) NSMutableArray *bookshelfIssues;
@property(nonatomic,retain) NSMutableArray *backIssues;

- (void)loadIssuesFromDb;
- (void)setupIssueSections;
- (void)fetchNewIssues;

@end
