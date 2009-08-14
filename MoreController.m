//
//  MoreController.m
//  Scarab
//
//  Created by Ian Terrell on 8/14/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "MoreController.h"


@implementation MoreController

- (id)init {
  if (self = [super init]) {
    self.title = @"More";
    UIImage* image = [UIImage imageNamed:@"more-icon.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    self.variableHeightRows = NO;

    TTTableImageItem *feedback = [TTTableImageItem itemWithText:@"Send Feedback" imageURL:@"bundle://18-envelope.png" URL:@"scarab://feedback"];
    TTTableImageItem *syncDevice = [TTTableImageItem itemWithText:@"Sync Device" imageURL:@"bundle://02-redo.png" URL:@"scarab://syncDevice"];
    TTTableImageItem *cleanUpFiles = [TTTableImageItem itemWithText:@"Clean Up Files" imageURL:@"bundle://20-gear2.png" URL:@"scarab://cleanUpFiles"];
    TTTableImageItem *credits = [TTTableImageItem itemWithText:@"Credits" imageURL:@"bundle://29-heart.png" URL:@"scarab://credits"];

    self.dataSource = [TTListDataSource dataSourceWithObjects:feedback, syncDevice, cleanUpFiles, credits, nil];
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

@end
