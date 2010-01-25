//
//  InterviewViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Interview;
@class FootnoteView;
@class Footnote;

@interface InterviewViewController : UIViewController {
  IBOutlet UILabel *subTitleLabel;
  IBOutlet UIScrollView *scrollView;
  FootnoteView *footnoteView;
  
  Interview *interview;
  Footnote *nextFootnote;
  
  BOOL footnoteUp;
}

@property(nonatomic,retain) Interview *interview;
@property(nonatomic,retain) Footnote *nextFootnote;

@property(nonatomic,retain) FootnoteView *footnoteView;
@property(nonatomic,retain) UILabel *subTitleLabel;
@property(nonatomic,retain) UIScrollView *scrollView;

- (void)openFootnoteWithId:(NSString *)footnoteId;
- (void)showFootnote;
- (void)hideFootnoteShowNext:(BOOL)next;

@end
