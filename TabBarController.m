//
//  TabBarController.m
//  Scarab
//
//  Created by Ian Terrell on 7/28/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "TabBarController.h"
#import "PlaceholderController.h"

@implementation TabBarController
- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:@"scarab://library",
                                             [NSString stringWithFormat:@"scarab://placeholder/%d", PlaceholderNews],
                                             [NSString stringWithFormat:@"scarab://placeholder/%d", PlaceholderInterviews],
                                             @"scarab://favorites",
                                             [NSString stringWithFormat:@"scarab://placeholder/%d", PlaceholderFeedback],
                                             [NSString stringWithFormat:@"scarab://placeholder/%d", PlaceholderSync],
                                             [NSString stringWithFormat:@"scarab://placeholder/%d", PlaceholderCleanUp],
                                             [NSString stringWithFormat:@"scarab://placeholder/%d", PlaceholderCredits],
                                             nil]];
  self.customizableViewControllers = [NSArray arrayWithObjects:nil];
}
@end
