//
//  Device.m
//  Scarab
//
//  Created by Ian Terrell on 1/15/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import "Device.h"


@implementation Device

@synthesize deviceId, token;

+ (BOOL)saveOnServer:(NSData *)tokenData {
  Device *device = [[Device alloc] init];
  device.token = [tokenData description];
  debugLog(@"saving device on server!!");
  return [device saveRemote];  // if YES then it passed the Rails validations
}

+(void)threadedSaveOnServer:(NSData *)tokenData {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  [self saveOnServer:tokenData];
  [pool release];
}

- (NSArray *)excludedPropertyNames {
  NSMutableArray *excluded = [NSMutableArray arrayWithArray: [super excludedPropertyNames]];
  [excluded addObject:@"URLValue"];
  return (NSArray *)excluded;
} 

- (void)dealloc {
  [deviceId release];
  [token release];
  [super dealloc];
}


@end
