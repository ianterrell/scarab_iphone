//
//  IssueViewController.m
//  Scarab
//
//  Created by Ian Terrell on 7/29/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "IssueViewController.h"
#import "Issue.h"
#import "Author.h"
#import "Work.h"
#import "WorkCell.h"

@implementation IssueViewController

@synthesize issue;

-(id)initWithNumber:(NSString *)number {
  if (self = [super init]) {
    self.issue = [Issue issueWithNumber:[NSNumber numberWithInt:[number intValue]]];
    if (![issue hasBeenPurchased]) {
      TTAlertViewController *alert = [[TTAlertViewController alloc] initWithTitle:@"Oops!" message:@"This issue has not been purchased."];
      [alert addCancelButtonWithTitle:@"Cancel" URL:[NSString stringWithFormat:@"scarab://previewIssue/%@", issue.number]];
      [alert showInView:self.view animated:YES];
      [alert release];
    } else {
      if (![issue hasBeenDownloaded]) {
        [AppDelegate showHUDWithLabel:nil details:@"Downloading Issue" animated:YES];
        
        // Download authors in issue
        NSArray *authorsInIssue = [Author findAllInIssue:issue];
        
        // insert author into DB unless they already exist -- TODO: update authors?
        for (Author *author in authorsInIssue)
          if ([Author authorWithId:author.authorId] == nil)
            [AppDelegate.managedObjectContext insertObject:author];      
        
        // download works
        NSArray *worksInIssue = [Work findAllInIssue:issue];
        for (Work *work in worksInIssue) {
          // Could have been a free work and is already in DB, but won't be linked to issue
          Work *workInDb = [Work workWithId:work.workId];
          if (workInDb == nil) {
            [AppDelegate.managedObjectContext insertObject:work];
            work.issue = issue;
            work.author = [Author authorWithId:work.authorId];  
          } else {
            workInDb.issue = issue;
          }
        }
        
        self.issue.downloaded = [NSNumber numberWithBool:YES];
        
        NSError *error = nil;
        [AppDelegate save:&error];
        if (error) {
          debugLog(@"Error saving new authors and works:  %@", [error localizedDescription]);
          [AppDelegate showSaveError];
        }
        [AppDelegate hideHUDUsingAnimation:YES];
      }
      self.works = [NSMutableArray arrayWithArray:[issue.works allObjects]];
      [self.works sortUsingSelector:@selector(compareByPosition:)];
    }
  }
  return self;
}

- (void)downloadIssue {

}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Add analytics for viewing issue
  [[Beacon shared] startSubBeaconWithName:[NSString stringWithFormat:@"Issue %d - %@", [self.issue.issueId intValue], self.issue.title] timeSession:NO];
}


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  self.title = self.issue.title; //[NSString stringWithFormat:@"Issue %@", issue.number];
  // Downloaded the content?
  // display.
  // else download, HUD up, display
  
  
//  if (issuesInDb == nil)
//    [self loadIssuesFromDb];  
//
//  [self setupIssueSections];
//
//  if (!fetchedNewIssues)
//    [AppDelegate showHUDWithLabel:nil details:@"Checking for new issues" whileExecuting:@selector(fetchNewIssues) onTarget:self withObject:nil animated:YES];
}

- (void)dealloc {
  [issue release];
  [super dealloc];
}


@end


