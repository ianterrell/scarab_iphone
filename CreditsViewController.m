//
//  CreditsViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "CreditsViewController.h"
#import "UIHelpers.h"

@implementation CreditsViewController

@synthesize scrollView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  [UIHelpers addCopy:@"Scarab is thankful for generous artists with open licenses. Some tab bar icons were created by <a href=\"http://www.glyphish.com\">Glyphish</a> and are licensed under Creative Commons Attribution 3.0.  The star icons for favoriting works were created by <a href=\"http://www.icojoy.com\">Icojoy</a> and are <a href=\"http://www.freeiconsdownload.com/Free_Downloads.asp?id=265\">available</a> under the Creative Commons Attribution 3.0 license.  The download icon was created by <a href=\"http://pixel-mixer.com/\">Pixel-Mixer</a> and is <a href=\"http://www.iconspedia.com/icon/down-11614.html\">available</a> free for use.\n\nScarab is a publication of Old Brick Press, LLC." toScrollView:scrollView];
}

- (id)init {
  if (self = [super init]) {
    self.title = @"Credits";
  }
  return self;
}

- (void)dealloc {
//  [scrollView dealloc];
  [super dealloc];
}


@end
