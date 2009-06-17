//
//  StringUtils.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "StringUtils.h"


@implementation StringUtils


+ (NSString *)timeStringFromSeconds:(NSTimeInterval)time {
  return [NSString stringWithFormat:@"%d:%02d", (int)time/60, (int)time%60];
}

@end
