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
  // TODO:  may need to use something like the work ID with some logical equality rather than object equality; depends on core data once I add it in here
  // for now... one work
  [downloads setObject:download forKey:@"work"];
  [download release];
}

- (void)updateController:(WorkViewController *)_controller forDownloadForWork:(Work *)work {
  // TODO: fix to use work in best way (hashcodes, etc)
  SMWorkAudioDownload *download = [downloads objectForKey:@"work"];
  download.controller = _controller;
}

- (void)doneDownloadingAudioFileForWork:(Work *)work {
  // TODO: fix to use work key...
  [downloads removeObjectForKey:@"work"];
}

- (BOOL)isAudioFileBeingDownloadedForWork:(Work *)work {
  // TODO: fix to use work key...
  return [downloads objectForKey:@"work"] != nil;
}

- (void)shutDown {
  debugLog(@"Shutting down SMWorkAudioDownloadManager");
}

- (void)dealloc {
	[downloads release];
  [super dealloc];
}


@end
