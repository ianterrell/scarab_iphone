//
//  Interview.m
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Interview.h"


@implementation Interview

@dynamic interviewId, authorId, number, body, date;
@dynamic author, footnotes;

+ (Interview *)interviewWithId:(NSNumber *)interviewId {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"interviewId = %d", [interviewId intValue]]];
}


@end
