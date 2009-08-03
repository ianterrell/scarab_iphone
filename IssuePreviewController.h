//
//  IssuePreviewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Issue;

@interface IssuePreviewController : UIViewController {
  Issue *issue;
  
  TTButton *purchaseButton;
  IBOutlet UIImageView *scarab;
  IBOutlet UILabel *issueNumber;
  IBOutlet UILabel *issueTitle;
  
  IBOutlet UIScrollView *scrollView;
}

@property(nonatomic,retain) Issue *issue;

@property(nonatomic,retain) TTButton *purchaseButton;
@property(nonatomic,retain) UIImageView *scarab;
@property(nonatomic,retain) UILabel *issueNumber;
@property(nonatomic,retain) UILabel *issueTitle;

@property(nonatomic,retain) UIScrollView *scrollView;

- (IBAction)purchaseIssue;
- (void)updatePurchaseButtonWithPrice:(NSString *)price;

@end
