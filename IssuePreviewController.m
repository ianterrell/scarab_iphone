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

@synthesize issue, scarab, issueNumber, issueTitle, scrollView, purchaseButton;

-(id)initWithNumber:(NSString *)number {
  if (self = [super init]) {
    self.issue = [Issue issueWithNumber:[NSNumber numberWithInt:[number intValue]]];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Start request to update purchase button
  [[IssuePriceFetcherManager defaultManager] fetchPriceForIssue:issue previewController:self];
  
  self.title = @"Preview";
  self.issueNumber.text = [issue.number stringValue];
  self.issueTitle.text = issue.title;
  [self.view insertSubview:[issue swatchView] belowSubview:scarab];
  
  debugLog(@"description is: --%@--", issue.previewDescription);
  // Body
  [UIHelpers addCopy:issue.previewDescription toScrollView:scrollView];
  
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
}

-(IBAction)purchaseIssue {
  [AppDelegate showHUDWithLabel:nil details:@"Purchasing" animated:YES];
  [[SMStore defaultStore] purchaseIssue:issue];
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
  [scrollView release];
  [purchaseButton release];
  [super dealloc];
}


@end
