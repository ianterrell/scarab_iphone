//
//  LibraryViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "LibraryViewController.h"
#import "IssuePreviewController.h"
#import "Issue.h"
#import "IssueCell.h"

@implementation LibraryViewController

@synthesize issuesInDb, currentIssue, bookshelfIssues, backIssues;

- (id)init {
  if (self = [super init]) {
    self.title = @"Library";

    UIImage* image = [UIImage imageNamed:@"library_icon.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // Set up empty arrays to hold issues
  if (bookshelfIssues == nil)
    self.bookshelfIssues = [NSMutableArray arrayWithCapacity:5];
  if (backIssues == nil)
    self.backIssues = [NSMutableArray arrayWithCapacity:5];
  
  if (issuesInDb == nil)
    [self loadIssuesFromDb];  

  [self setupIssueSections];

  if (!fetchedNewIssues)
    [AppDelegate showHUDWithLabel:nil details:@"Checking for new issues" whileExecuting:@selector(fetchNewIssues) onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark Issue Management

- (void)loadIssuesFromDb {
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
  self.issuesInDb = [Issue fetchWithSortDescriptor:sortDescriptor];
  [sortDescriptor release];
  debugLog(@"There are %d issues in the database", [issuesInDb count]);
}

-(void)setupIssueSections {
  NSMutableArray *issues = [NSMutableArray arrayWithCapacity:[issuesInDb count]];
  [issues addObjectsFromArray:issuesInDb];
  
  self.currentIssue = [issues lastObject];
  if (currentIssue != nil)
    [issues removeLastObject];

  // TODO: separate remaining into bookshelf issues and back issues
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:NO];
  [issues sortUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
  [sortDescriptor release];
  self.bookshelfIssues = issues;

  [(UITableView *)self.view reloadData];
}


-(void)fetchNewIssues {
  int currentIssueNumber = (currentIssue == nil) ? 0 : [currentIssue.number intValue];
  debugLog(@"The number of the last issue in the database is %d", currentIssueNumber);
  NSArray *newIssuesOnServer = [Issue findAllSinceNumber:[NSNumber numberWithInt:currentIssueNumber]];
  debugLog(@"There are %d new issues on the server", [newIssuesOnServer count]);
  
  if ([newIssuesOnServer count] > 0) {
    // TODO:  guarantee order from server, or sort here
    for (Issue *issue in newIssuesOnServer) {
      [AppDelegate.managedObjectContext insertObject:issue];
      [issuesInDb addObject:issue];
    }
    
    NSError *error = nil;
    [AppDelegate save:&error];
    if (error) {
      debugLog(@"Error saving new issues in Library:  %@", [error localizedDescription]);
      // TODO: FIXME BITCH WHAT DO I DO?
    }
  }
  
  [self setupIssueSections];
  fetchedNewIssues = YES;
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  int sections = 0;
  if (currentIssue != nil)
    sections++;
  if ([bookshelfIssues count] > 0)
    sections++;
  if ([backIssues count] > 0)
    sections++;
  debugLog(@"There are %d sections", sections);
  return sections;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      // This will always be the current issue
      return 1;
    case 1:
      // This may be the bookshelf or the back issues
      if ([bookshelfIssues count] > 0)
        return [bookshelfIssues count];
    case 2:
      // This will always be back issues, even from the above fall through
      return [backIssues count];
    default:
      return 0;
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"Current Issue";
    case 1:
      return @"My Bookshelf";
    case 2:
      return @"Back Issues";
    default:
      return nil;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kIssueCellHeight;
}

-(Issue *)issueAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.section) {
    case 0:
      return currentIssue;
    case 1:
      if ([bookshelfIssues count] > 0)
        return [bookshelfIssues objectAtIndex:indexPath.row];
    case 2:
      return [backIssues objectAtIndex:indexPath.row];
    default:
      return nil;
  }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"IssueCell";
  IssueCell *cell = (IssueCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [IssueCell createNewCellFromNib];
  }
  Issue *issue = [self issueAtIndexPath:indexPath];
  
  [cell insertSubview:[issue swatchView] atIndex:0];
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
  //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg_selected.png"]];
  
  cell.number.text = issue.number;
  cell.title.text = issue.title;
  cell.subtitle.text = issue.subtitle;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO:  pick URL based on whether or not we've purchased it yet!
  TTOpenURL([NSString stringWithFormat:@"scarab://issue/%@", [self issueAtIndexPath:indexPath].number]);
  
//	IssuePreviewController *issuePreviewController = [[IssuePreviewController alloc] initWithNibName:@"IssuePreviewController" bundle:nil];
//  issuePreviewController.issue = [self issueAtIndexPath:indexPath];
//	[self.navigationController pushViewController:issuePreviewController animated:YES];
//	[issuePreviewController release];
}


- (void)dealloc {
  [issuesInDb release];
  [currentIssue release];
  [bookshelfIssues release];
  [backIssues release];
  [super dealloc];
}


@end
