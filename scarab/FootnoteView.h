//
//  FootnoteView.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InterviewViewController.h"

@interface FootnoteView : TTView {
  CGPoint startTouchPosition;
  InterviewViewController *interviewViewController;
  TTStyledTextLabel *footnoteLabel;
}

@property(nonatomic, assign) InterviewViewController *interviewViewController;
@property(nonatomic, assign) TTStyledTextLabel *footnoteLabel;

- (void)setTextFromXHTML:(NSString *)text;

@end
