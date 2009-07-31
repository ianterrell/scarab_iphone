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
#import "SMStore.h"
#import "IssuePriceFetcherManager.h"
#import "PlaceholderController.h"

@implementation IssuePreviewController

@synthesize issue, scarab, issueNumber, issueTitle, description, freeWorkTableView, purchaseButton;

-(id)initWithNumber:(NSString *)number {
  if (self = [super init]) {
    self.issue = [Issue issueWithNumber:number];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Start request to update purchase button
  // TODO: go back to this instead of hardcoded: [[IssuePriceFetcherManager defaultManager] fetchPriceForIssue:issue previewController:self];
  
  self.title = @"Preview";//[NSString stringWithFormat:@"Preview %@", issue.title];
  self.issueNumber.text = issue.number;
  self.issueTitle.text = issue.title;
  [self.description loadHTMLString:@"<html><head><style>body { font-family: helvetica; }</style></head><body><p></p></body></html>" baseURL:nil];
  
  [self.view insertSubview:[issue swatchView] belowSubview:scarab];
  
  self.purchaseButton = [TTButton buttonWithStyle:@"purchasebutton:" title:@"     Updating Price..."];
  self.purchaseButton.frame = CGRectMake(95,37,200,40);
  self.purchaseButton.font = [UIFont boldSystemFontOfSize:14.0];
  [self.purchaseButton addTarget:self action:@selector(purchaseIssue) forControlEvents:UIControlEventTouchUpInside];
  UIImageView *biv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download-arrow.png"]];
  biv.center = CGPointMake(25,18);
  [self.purchaseButton addSubview:biv];
  [biv release];
  self.purchaseButton.enabled = NO;
  [self.view addSubview:self.purchaseButton];
  
  // TODO: remove
  [self updatePurchaseButtonWithPrice:@"2.99"];

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
  [UIHelpers addRoundedImageNamed:@"brian.jpg" toView:cell];
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];

  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO: set id after work!  work/id
  TTOpenURL(@"scarab://work");
}

-(IBAction)purchaseIssue {
  // TODO: go back to this! [[SMStore defaultStore] purchaseIssue:issue];
  debugLog(@"purchasing!");
  TTOpenURL([NSString stringWithFormat:@"scarab://issue/%@", issue.number]);
}

- (void)updatePurchaseButtonWithPrice:(NSString *)price { 
  [self.purchaseButton setTitle:[NSString stringWithFormat:@"     %@ Purchase Issue", price] forState:UIControlStateNormal];
  self.purchaseButton.enabled = YES;
}

- (void)dealloc {
  debugLog(@"Deallocing issue preview view");
  [issue release];
  [scarab release];
  [issueNumber release];
  [issueTitle release];
  [description release];
  [freeWorkTableView release];
  [purchaseButton release];
  [super dealloc];
}


@end
