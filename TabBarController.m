//
//  TabBarController.m
//  Scarab
//
//  Created by Ian Terrell on 7/28/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:@"scarab://library",
                                             @"scarab://news",
                                             @"scarab://interviews",
                                             @"scarab://favorites",
                                             @"scarab://more",
//                                             @"scarab://feedback",
//                                             @"scarab://syncDevice",
//                                             @"scarab://cleanUpFiles",
//                                             @"scarab://credits",
                                             nil]];
  self.customizableViewControllers = [NSArray arrayWithObjects:nil];
  self.delegate = self;
}

- (void) tabBarController:(UITabBarController*)aTabBarController didSelectViewController:(UIViewController*)viewController {
//    viewController.tabBarItem.badgeValue = nil;
  debugLog(@"hey I just selected a %@", [viewController className]);
  viewController.tabBarItem.badgeValue = nil;
}


@end
