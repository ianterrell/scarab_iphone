//
//  IssueViewController.m
//  Scarab
//
//  Created by Ian Terrell on 7/29/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "IssueViewController.h"
#import "Work.h"
#import "WorkCell.h"

@implementation IssueViewController

@synthesize issue;

-(id)initWithNumber:(NSString *)number {
  if (self = [super init]) {
    self.issue = [Issue issueWithNumber:number];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kWorkCellHeight;
}

-(Work *)workAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"WorkCell";
  WorkCell *cell = (WorkCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [WorkCell createNewCellFromNib];
  }
  
  //Work *work = [self workAtIndexPath:indexPath];
  
//  [cell insertSubview:[issue swatchView] atIndex:0];
//  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
//  //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg_selected.png"]];
//  cell.number.text = issue.number;
//  cell.title.text = issue.title;
//  cell.subtitle.text = issue.subtitle;

  [UIHelpers addRoundedImageNamed:@"brian.jpg" toView:cell];
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO:  pick URL based on whether or not we've purchased it yet!
  //TTOpenURL([NSString stringWithFormat:@"scarab://work/%@", [self workAtIndexPath:indexPath].workId]);
  TTOpenURL(@"scarab://work");  
}


- (void)dealloc {
  [issue release];
  [super dealloc];
}


@end


