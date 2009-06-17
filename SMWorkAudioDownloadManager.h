//
//  SMWorkAudioDownloadManager.h
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkViewController.h"
#import "Work.h"

@interface SMWorkAudioDownloadManager : NSObject {
  NSMutableDictionary *downloads;
}

@property(nonatomic,retain) NSMutableDictionary *downloads;

+ (SMWorkAudioDownloadManager *)defaultManager;

- (void)downloadAudioForWork:(Work *)work controller:(WorkViewController *)controller;
- (void)updateController:(WorkViewController *)controller forDownloadForWork:(Work *)work;
- (void)doneDownloadingAudioFileForWork:(Work *)work;
- (BOOL)isAudioFileBeingDownloadedForWork:(Work *)work;

@end
