//
//  Work.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Work.h"
#import "SMWorkAudioDownloadManager.h"
#import "Issue.h"
#import "Author.h"

@implementation Work

@dynamic authorId, workId, title, body, position, reader, free, favorite;
@dynamic issue, author;

#pragma mark Finders

+ (NSArray *)findAllInIssue:(Issue *)issue {
  // TODO: Add transaction identifier to restrict access!
  // htp://server/issues/:number/works.xml?tid=identifier
  NSString *worksInIssue = [NSString stringWithFormat:@"%@%@/%d/%@%@?tid=%@",
                           [self getRemoteSite],
                           [Issue getRemoteCollectionName],
                           [issue.issueId intValue],
                           [self getRemoteCollectionName],
                           [self getRemoteProtocolExtension],
                           issue.transactionIdentifier];
  Response *response = [Connection get:worksInIssue];
	return [self performSelector:[self getRemoteParseDataMethod] withObject:response.body];
}

+ (Work *)workWithId:(NSString *)workId {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"workId = %@", workId]];
}

#pragma mark Helpers

- (BOOL)audioFileHasBeenDownloaded {
  return [[NSFileManager defaultManager] fileExistsAtPath:self.audioFilePath];
}

- (BOOL)isAudioFileBeingDownloaded {
  return [[SMWorkAudioDownloadManager defaultManager] isAudioFileBeingDownloadedForWork:self];
}

- (NSString *)audioFileURL {
  // htp://server/works/:number/audio or with ?tid=identifier
  if (self.issue == nil)
    return [NSString stringWithFormat:@"%@%@/%d/audio", [Work getRemoteSite], [Work getRemoteCollectionName], [self.workId intValue]];
  else
    return [NSString stringWithFormat:@"%@%@/%d/audio?tid=%@", [Work getRemoteSite], [Work getRemoteCollectionName], [self.workId intValue], self.issue.transactionIdentifier];
}

+ (NSString *)audioDirectoryPath {
  return [NSString stringWithFormat:@"%@/audio", [AppDelegate applicationDocumentsDirectory]];
}

- (NSString *)audioFilePath {
  return [NSString stringWithFormat:@"%@/%d.mp3", [Work audioDirectoryPath], [self.workId intValue]];
}

- (BOOL)isFree {
  return [self.free isEqualToString:@"true"];
}

- (BOOL)isFavorite {
  return [self.favorite boolValue];
}

- (NSComparisonResult)compareByPosition:(Work *)other {
  int x = [self.position intValue];
  int y = [other.position intValue];
  return x == y ? NSOrderedSame : (x > y) ? NSOrderedDescending : NSOrderedAscending;
}

@end
