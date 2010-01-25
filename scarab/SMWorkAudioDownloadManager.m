//
//  SMWorkAudioDownloadManager.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMWorkAudioDownloadManager.h"
#import "SMWorkAudioDownload.h"

#define kInitialDownloadCapacity 3

@implementation SMWorkAudioDownloadManager

@synthesize downloads;

+ (SMWorkAudioDownloadManager *)defaultManager {
  static SMWorkAudioDownloadManager *singleton = nil;
  if (singleton == nil)
    singleton = [[SMWorkAudioDownloadManager alloc] init];
  return singleton;
}

- (SMWorkAudioDownloadManager *)init {
  if ([super init] == self) {
    self.downloads = [NSMutableDictionary dictionaryWithCapacity:kInitialDownloadCapacity];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shutDown) name:UIApplicationWillTerminateNotification object:nil];
  }
  return self;
}

- (void)downloadAudioForWork:(Work *)work controller:(WorkViewController *)controller {
  SMWorkAudioDownload *download = [[SMWorkAudioDownload alloc] initWithWork:work controller:controller];
  [downloads setObject:download forKey:work.workId];
  [download release];
}

- (void)updateController:(WorkViewController *)_controller forDownloadForWork:(Work *)work {
  SMWorkAudioDownload *download = [downloads objectForKey:work.workId];
  download.controller = _controller;
}

- (void)doneDownloadingAudioFileForWork:(Work *)work {
  [downloads removeObjectForKey:work.workId];
}

- (BOOL)isAudioFileBeingDownloadedForWork:(Work *)work {
  return [downloads objectForKey:work.workId] != nil;
}

- (void)shutDown {
  debugLog(@"Shutting down SMWorkAudioDownloadManager.  Downloads count is %d", [downloads count]);
}

- (void)dealloc {
	[downloads release];
  [super dealloc];
}


@end
