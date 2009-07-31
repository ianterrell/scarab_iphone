//
//  PlaceholderController.m
//  Scarab
//
//  Created by Ian Terrell on 7/28/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "PlaceholderController.h"


@implementation PlaceholderController

- (NSString*)nameForType:(PlaceholderType)type {
  switch (type) {
    case PlaceholderNews:
      return @"News";
    case PlaceholderFavorites:
      return @"Favorites";
    case PlaceholderInterviews:
      return @"Interviews";
    case PlaceholderFeedback:
      return @"Send Feedback";
    case PlaceholderSync:
      return @"Sync Device";
    case PlaceholderCleanUp:
      return @"Clean Up Files";
    case PlaceholderIssue:
      return @"Issue";
    default:
      return @"";
  }
}

- (NSString*)iconForType:(PlaceholderType)type {
  switch (type) {
    case PlaceholderNews:
      return @"09-chat2.png";
    case PlaceholderFavorites:
      return @"28-star.png";
    case PlaceholderInterviews:
      return @"66-microphone.png";
    case PlaceholderFeedback:
      return @"18-envelope.png";
    case PlaceholderSync:
      return @"57-download.png";
    case PlaceholderCleanUp:
      return @"20-gear2.png";
    case PlaceholderIssue:
      return @"20-gear2.png";
    default:
      return @"";
  }
}

- (id)initWithType:(PlaceholderType)type {
  if (self = [super init]) {
    self.title = [self nameForType:type];
    UIImage* image = [UIImage imageNamed:[self iconForType:type]];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
  }
  return self;
}


@end
