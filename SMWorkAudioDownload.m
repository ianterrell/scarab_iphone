//
//  SMWorkAudioDownload.m
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMWorkAudioDownload.h"


@implementation SMWorkAudioDownload

@synthesize work, connection, data, expectedContentLength, controller;

- (SMWorkAudioDownload *)initWithWork:(Work *)_work controller:(WorkViewController *)_controller {
  if ([super init] == self) {
    self.work = _work;
    self.controller = _controller;
  }
  NSURL *url = [NSURL URLWithString:self.work.audioFileURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
  return self;
}

#pragma mark Connection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  self.expectedContentLength = [response expectedContentLength];
  self.data = [NSMutableData dataWithCapacity:self.expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data {
  [self.data appendData:_data];
  self.controller.downloadingProgressView.progress = (float)[self.data length] / self.expectedContentLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  if ([self.data writeToFile:[self.work audioFilePath] atomically:YES]) {
    [controller doneDownloadingAudioFile];
    [[SMWorkAudioDownloadManager defaultManager] doneDownloadingAudioFileForWork:self.work];
  } else {
    // TODO handle this error for real
    debugLog(@"Error saving audio file for work.");
  }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  debugLog(@"error downloading file, failed. %@", [error localizedDescription]);
}


- (void)dealloc {
  [data release];
	[work release];
  [connection release];
  [controller release];
  [super dealloc];
}

@end
