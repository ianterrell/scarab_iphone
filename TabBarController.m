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
                                             nil]];
}
@end
