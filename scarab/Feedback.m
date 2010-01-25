//
//  Feedback.m
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Feedback.h"


@implementation Feedback

@synthesize feedbackId, text;

- (NSArray *)excludedPropertyNames {
  NSMutableArray *excluded = [NSMutableArray arrayWithArray: [super excludedPropertyNames]];
  [excluded addObject:@"URLValue"];
  return (NSArray *)excluded;
} 

- (void)dealloc {
  [feedbackId release];
  [text release];
  [super dealloc];
}

@end
