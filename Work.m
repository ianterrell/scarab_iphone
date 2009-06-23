//
//  Work.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Work.h"
#import "SMWorkAudioDownloadManager.h"

@implementation Work

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

@end
