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
    case PlaceholderFeedback:
      return @"Send Feedback";
    default:
      return @"";
  }
}

- (NSString*)iconForType:(PlaceholderType)type {
  switch (type) {
    case PlaceholderFeedback:
      return @"18-envelope.png";
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
