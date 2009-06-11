//
//  LibraryViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "LibraryViewController.h"
#import "Issue.h"

@implementation LibraryViewController

@synthesize currentIssue, bookshelfIssues, backIssues;

- (void)viewDidLoad {
  [super viewDidLoad];

  
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if (bookshelfIssues == nil)
    self.bookshelfIssues = [NSMutableArray arrayWithCapacity:5];
  if (backIssues == nil)
    self.backIssues = [NSMutableArray arrayWithCapacity:5];
  
  if (!fetchedNewIssues)
    [self fetchNewIssues];
}

#pragma mark -
#pragma mark Check for Issues

-(void)fetchNewIssues {
  // Fetch issues in the database
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
  NSMutableArray *issuesInDb = [Issue fetchWithSortDescriptor:sortDescriptor];
  [sortDescriptor release];
  debugLog(@"There are %d issues in the database", [issuesInDb count]);
  
  self.currentIssue = [issuesInDb lastObject];
  int currentIssueNumber = (currentIssue == nil) ? 0 : [currentIssue.number intValue];
  debugLog(@"The number of the last issue in the database is %d", currentIssueNumber);
  NSArray *newIssuesOnServer = [Issue findAllSinceNumber:[NSNumber numberWithInt:currentIssueNumber]];
  debugLog(@"There are %d new issues on the server", [newIssuesOnServer count]);
  
  if ([newIssuesOnServer count] > 0) {
    // TODO: Check if new issues are paid for by a subscription (this view is cached) -- Rails metal? -- update accordingly
    
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
    
    self.currentIssue = [issuesInDb lastObject];
  }
  
  // Set up view
  
  if (currentIssue != nil)
    [issuesInDb removeLastObject];

  // TODO: separate remaining into bookshelf issues and back issues
  self.bookshelfIssues = issuesInDb;
  
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
  return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return (currentIssue == nil) ? 0 : 1;
    case 1:
      return [bookshelfIssues count];
    case 2:
      return [backIssues count];
    default:
      return 0;
  }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.textLabel.text = @"hi";
// Configure the cell.

  return cell;
}



/*
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}
*/


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
  [currentIssue release];
  [bookshelfIssues release];
  [backIssues release];
  [super dealloc];
}


@end
