//
//  Author.m
//  Scarab
//
//  Created by Ian Terrell on 7/30/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Author.h"
#import "Issue.h"

@implementation Author

@dynamic authorId, name, location, bio, photoUrl;
@dynamic works;

#pragma mark Finders

+ (NSArray *)findAllInIssue:(Issue *)issue {
  // htp://server/issues/:number/authors.xml
  NSString *authorsInIssue = [NSString stringWithFormat:@"%@%@/%d/%@%@",
                             [self getRemoteSite],
                             [Issue getRemoteCollectionName],
                             [issue.issueId intValue],
                             [self getRemoteCollectionName],
                             [self getRemoteProtocolExtension]];
  Response *response = [Connection get:authorsInIssue];
	return [self performSelector:[self getRemoteParseDataMethod] withObject:response.body];
}

+ (Author *)authorWithId:(NSString *)authorId {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"authorId = %@", authorId]];
}

#pragma mark Helpers

- (NSString *)fullyQualifiedPhotoUrl {
  // Site ends with /, partial URL starts with /
  NSMutableString *url = [NSMutableString stringWithString:AppDelegate.baseServerURL];
  [url appendString:self.photoUrl];
  return url;
}

@end

