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

@synthesize issue, scarab, issueNumber, issueTitle, description, freeWorkTableView;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Preview"; //[NSString stringWithFormat:@"Issue %@", issue.number];
  self.issueNumber.text = issue.number;
  self.issueTitle.text = issue.title;
  [self.description loadHTMLString:@"<html><head><style>body { font-family: helvetica; }</style></head><body><p>This is an issue description.  It has stuff in it.  It probably even describes the issue.</p><p>It may have lists?</p><ul><li>Awesome stuff</li><li>More awesome stuff</li></ul><p>Long descriptions?  I'm not sure.  You tell me, Brian.</p></body></html>" baseURL:nil];
  
  TTImageView *issueColorView = [UIHelpers newRoundedImageNamed:@"purple.png"];
  [self.view insertSubview:issueColorView belowSubview:scarab];
  [issueColorView release];
  
  // Make Purchase Button (pretty but a lot of work!)
  TTButton *b = [TTButton buttonWithStyle:@"purchasebutton:" title:@"     Purchase Issue"];
  b.frame = CGRectMake(112,37,160,40);
  b.font = [UIFont boldSystemFontOfSize:14.0];
  [b addTarget:self action:@selector(purchaseIssue) forControlEvents:UIControlEventTouchUpInside];
  UIImageView *biv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download-arrow.png"]];
  biv.center = CGPointMake(25,18);
  [b addSubview:biv];
  [biv release];
  [self.view addSubview:b];
}

-(void)viewWillAppear:(BOOL)animated {
  [freeWorkTableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:animated];
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
  [UIHelpers addRoundedImageNamed:@"ian.png" toView:cell];
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];

  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	WorkViewController *workViewController = [[WorkViewController alloc] initWithNibName:@"WorkViewController" bundle:nil];
	[self.navigationController pushViewController:workViewController animated:YES];
	[workViewController release];
}

-(IBAction)purchaseIssue {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Purchase the current issue alone or as the first issue of a subscription." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"$2.99 Single Issue", @"$16.99 6 Months (6 issues)", @"$29.99 1 Year (12 issues)", nil];
  [actionSheet showInView:AppDelegate.window];
  [actionSheet release];
}


- (void)dealloc {
  debugLog(@"Deallocing issue preview view");
  [issue release];
  [scarab release];
  [issueNumber release];
  [issueTitle release];
  [description release];
  [freeWorkTableView release];
  [super dealloc];
}


@end
