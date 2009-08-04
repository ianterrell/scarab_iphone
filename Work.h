//
//  Work.h
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMManagedObject.h"

@class Issue;
@class Author;

@interface Work : SMManagedObject {

}

@property(retain) NSString *workId;
@property(retain) NSString *authorId;
@property(retain) NSString *title;
@property(retain) NSString *body;
@property(retain) NSString *position;
@property(retain) NSString *reader;
@property(retain) NSString *workType;
@property(retain) NSString *free;
@property(retain) NSNumber *favorite;

@property(retain) Issue *issue;
@property(retain) Author *author;

@property(nonatomic,readonly) NSString *audioFileURL;
@property(nonatomic,readonly) NSString *audioFilePath;

#pragma mark Finders

+ (NSArray *)findAllInIssue:(Issue *)issue;
+ (Work *)workWithId:(NSString *)workId;

#pragma mark Helpers
+ (NSString *)audioDirectoryPath;
- (BOOL)audioFileHasBeenDownloaded;
- (BOOL)isAudioFileBeingDownloaded;
- (NSString *)aTypeBy;
- (BOOL)isFree;
- (BOOL)isFavorite;

@end
