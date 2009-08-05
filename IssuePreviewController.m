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
#import "FootnoteView.h"

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
  
  
  // screwing around here past this
  
    UIColor* black = RGBCOLOR(158, 163, 172);
  TTShapeStyle *footnoteBox =  [TTShapeStyle styleWithShape:
      [TTRoundedRectangleShape shapeWithTopLeft:10 topRight:10 bottomRight:0 bottomLeft:0] next:
      [TTShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:5 offset:CGSizeMake(2, -2) next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0.25, 0.25, 0.25, 0.25) next:
      [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-0.25, -0.25, -0.25, -0.25) next:
      [TTSolidBorderStyle styleWithColor:black width:1 next:nil]]]]]];
      
  TTStyledTextLabel* footnote = [[[TTStyledTextLabel alloc] initWithFrame:CGRectZero] autorelease];
  footnote.font = [UIFont systemFontOfSize:13];
  footnote.text = [TTStyledText textFromXHTML:@"Well you see, the truth about the horseman was that he wasn't a horseman at all -- he was riding a donkey! <a href=\"http://google.com\">pic of horse</a>" lineBreaks:YES URLs:YES];
  footnote.frame = CGRectMake(0, 0, 300, 283);
  footnote.contentInset = UIEdgeInsetsMake(20, 15, 20, 0);
  footnote.backgroundColor = [UIColor clearColor]; 
  footnote.userInteractionEnabled = YES;
  [footnote sizeToFit];
  
  CGRect frame = CGRectMake(4, 100+self.scrollView.height-footnote.height, 320, 100);
  FootnoteView* v = [[[FootnoteView alloc] initWithFrame:frame] autorelease];
  v.userInteractionEnabled = YES;
  v.backgroundColor = [UIColor clearColor];
  v.style = footnoteBox;
  [v addSubview:footnote];
  [self.view addSubview:v];
}

-(IBAction)purchaseIssue {
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
