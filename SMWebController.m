//
//  SMWebController.m
//  Scarab
//
//  Created by Ian Terrell on 8/17/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMWebController.h"


@implementation SMWebController

- (void)openURL:(NSURL*)URL {
  [super openURL:URL];
  
  // Add analytics for web browsing
  [[Beacon shared] startSubBeaconWithName:[NSString stringWithFormat:@"URL %@ %@", [URL host], [URL fragment]] timeSession:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
