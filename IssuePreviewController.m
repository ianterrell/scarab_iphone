//
//  IssuePreviewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "IssuePreviewController.h"

#import "Issue.h"
#import "WorkCell.h"
#import "WorkViewController.h"

@implementation IssuePreviewController

@synthesize issue, icon, issueNumber, issueTitle, description;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}\
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  self.icon.backgroundColor = [issue uiColor];
  self.title = @"Preview Issue"; //[NSString stringWithFormat:@"Issue %@", issue.number];
  self.issueNumber.text = issue.number;
  self.issueTitle.text = issue.title;
  [self.description loadHTMLString:@"<html><head><style>body { font-family: helvetica; margin: 0px; }</style></head><body><p>This is an issue description.  It has stuff in it.  It probably even describes the issue.</p><p>It may have lists?</p><ul><li>Awesome stuff</li><li>More awesome stuff</li></ul><p>Long descriptions?  I'm not sure.  You tell me, Brian.</p></body></html>" baseURL:nil];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kWorkCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"WorkCell";
  WorkCell *cell = (WorkCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [WorkCell createNewCellFromNib];
  }
  
  // TODO: customize cell with work info here

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	WorkViewController *workViewController = [[WorkViewController alloc] initWithNibName:@"WorkViewController" bundle:nil];
	[self.navigationController pushViewController:workViewController animated:YES];
	[workViewController release];
}


- (void)dealloc {
  debugLog(@"Deallocing issue preview view");
  [issue release];
  [icon release];
  [issueNumber release];
  [issueTitle release];
  [description release];
  [super dealloc];
}


@end
