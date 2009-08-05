//
//  InterviewViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "InterviewViewController.h"


@implementation InterviewViewController

@synthesize titleLabel, scrollView;

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  debugLog(@"deallocing InterviewViewController");

  [titleLabel release];
  [scrollView release];

  [super dealloc];
}

@end
