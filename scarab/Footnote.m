//
//  Footnote.m
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Footnote.h"
#import "Interview.h"

@implementation Footnote

@dynamic footnoteId, interviewId, body;
@dynamic interview;

+ (NSArray *)findAllInInterview:(Interview *)interview {
  // htp://server/interviews/:id/footnotes.xml
  NSString *footnotesInInterview = [NSString stringWithFormat:@"%@%@/%d/%@%@",
                                    [self getRemoteSite],
                                    [Interview getRemoteCollectionName],
                                    [interview.interviewId intValue],
                                    [self getRemoteCollectionName],
                                    [self getRemoteProtocolExtension]];
  Response *response = [ORConnection get:footnotesInInterview];
	return [self performSelector:[self getRemoteParseDataMethod] withObject:response.body];
}

+ (Footnote *)footnoteWithId:(NSNumber *)footnoteId {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"footnoteId = %d", [footnoteId intValue]]];
}

@end
