//
//  SMWorkAudioDownload.h
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMWorkAudioDownloadManager.h"
#import "WorkViewController.h"
#import "Work.h"

@interface SMWorkAudioDownload : NSObject {
  Work *work;
  NSURLConnection *connection;
  NSMutableData *data;
  long long expectedContentLength;
  WorkViewController *controller;
}

@property(nonatomic,retain) Work *work;
@property(nonatomic,retain) NSURLConnection *connection;
@property(nonatomic,retain) NSMutableData *data;
@property(nonatomic,retain) WorkViewController *controller;

@property(nonatomic,assign) long long expectedContentLength;

- (SMWorkAudioDownload *)initWithWork:(Work *)work controller:(WorkViewController *)controller;

@end
