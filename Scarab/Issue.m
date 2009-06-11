//
//  Issue.m
//  Scarab
//
//  Created by Ian Terrell on 6/10/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Issue.h"

@implementation Issue

@dynamic issueId;
@dynamic color;
@dynamic number;

+(NSArray *)findAllSinceNumber:(NSNumber *)issueNumber {
  // htp://server/issues/since/:number.xml
  NSString *issuesSincePath = [NSString stringWithFormat:@"%@%@/since/%d%@",
                              [self getRemoteSite],
                              [self getRemoteCollectionName],
                              [issueNumber intValue],
                              [self getRemoteProtocolExtension]];
  Response *response = [Connection get:issuesSincePath];
	return [self performSelector:[self getRemoteParseDataMethod] withObject:response.body];
}

@end
