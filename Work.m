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

@dynamic authorId, workId, title, body, position, reader;
@dynamic issue, author;

#pragma mark Finders

+ (NSArray *)findAllInIssue:(Issue *)issue {
  // TODO: Add transaction identifier to restrict access!
  // htp://server/issues/:number/works.xml
  NSString *worksInIssue = [NSString stringWithFormat:@"%@%@/%d/%@%@",
                           [self getRemoteSite],
                           [Issue getRemoteCollectionName],
                           [issue.issueId intValue],
                           [self getRemoteCollectionName],
                           [self getRemoteProtocolExtension]];
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

// TODO:  This is temporary, replace some stuff!
- (NSString *)audioFileURL {
  return [NSString stringWithFormat:@"%@test.mp3", [ObjectiveResourceConfig getSite]];
}

// TODO:  This is temporary, replace some stuff!
- (NSString *)audioFilePath {
  return [NSString stringWithFormat:@"%@/audiofile.mp3", [AppDelegate applicationDocumentsDirectory]];
}

- (NSComparisonResult)compareByPosition:(Work *)other {
  int x = [self.position intValue];
  int y = [other.position intValue];
  return x == y ? NSOrderedSame : (x > y) ? NSOrderedDescending : NSOrderedAscending;
}

@end
