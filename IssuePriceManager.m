//
//  IssuePriceManager.m
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "IssuePriceManager.h"

#define kInitialCacheCapacity 5

@implementation IssuePriceManager

+ (IssuePriceManager *)defaultManager {
  static IssuePriceManager *singleton = nil;
  if (singleton == nil)
    singleton = [[IssuePriceManager alloc] init];
  return singleton;
}

- (IssuePriceManager *)init {
  if ([super init] == self)
    self.cache = [NSMutableDictionary dictionaryWithCapacity:kInitialCacheCapacity];
  return self;
}


@end
