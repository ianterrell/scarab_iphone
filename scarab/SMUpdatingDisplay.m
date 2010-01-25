//
//  SMUpdatingDisplay.m
//  Scarab
//
//  Created by Ian Terrell on 8/17/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMUpdatingDisplay.h"
#import "TabBarController.h"

#define kAnimationDuration 0.3
#define kBaseOriginY 401
#define kBarHeight 30

@implementation SMUpdatingDisplay

@synthesize loadingLabel, things;

+ (SMUpdatingDisplay *)sharedDisplay {
  static SMUpdatingDisplay *singleton = nil;
  if (singleton == nil)
    singleton = [[SMUpdatingDisplay alloc] init];
  return singleton;
}

- (id)init {
  if (self = [super init]) {
    self.loadingLabel = [[[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleBlackBanner] autorelease];
    loadingLabel.text = @""; // prep; love OO black box bullshit
    self.things = [NSMutableArray arrayWithCapacity:2];
  }
  return self;
}


- (void)addCheckingFor:(NSString *)thing {
  @synchronized(things) {
    [things addObject:thing];
    [self show];
  }
}

- (void)removeCheckingFor:(NSString *)thing {
  @synchronized(things) {
    [things removeObject:thing];
    [self hide];
  }
}

- (BOOL)isCheckingFor:(NSString *)thing {
  return [things containsObject:thing];
}

- (void)show {
  debugLog(@"in show");
  
  // so we can queue up messages before the window is initialized:
  if ([UIApplication sharedApplication].keyWindow == nil)
    return;

  // if there's nothing here, we don't really need to show anything
  if ([things count] == 0)
    return;
  
  if (![loadingLabel.text isEqualToString:@""]) {
    // already visible, just update text
    debugLog(@"updating only");
    loadingLabel.text = [self displayMessage];
    return;
  } else  {
    debugLog(@"updating and showing");
    // update and show
    loadingLabel.frame = CGRectMake(0, kBaseOriginY + kBarHeight, 320, kBarHeight);
    loadingLabel.text = [self displayMessage];
    [loadingLabel sizeToFit];
    [AppDelegate.tabBarController.view insertSubview:loadingLabel atIndex:([AppDelegate.tabBarController.view.subviews count] - 1)];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kAnimationDuration];
    loadingLabel.frame = CGRectMake(0, kBaseOriginY, 320, kBarHeight);
    [UIView commitAnimations];
  }
}

- (void)hide {
  debugLog(@"in hide");
  if ([things count] == 0) {
    debugLog(@"hiding completely");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kAnimationDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(doneHiding)];
    loadingLabel.frame = CGRectMake(0, kBaseOriginY + kBarHeight, 320, kBarHeight);
    [UIView commitAnimations];
  } else {
    debugLog(@"updating with fewer items");
    loadingLabel.text = [self displayMessage];
  }
}

- (NSString *)displayMessage {
  int count = [things count];
  NSMutableString *message = [NSMutableString stringWithString:@"Checking for "];
  for (NSString *t in things) {
    [message appendString:t];
    if (--count > 0)
      [message appendString:@" and "];
  }
  [message appendString:@"..."];
  debugLog(@"update display message is '%@'", message);
  return message;
}

- (void)doneHiding {
  [loadingLabel removeFromSuperview];
  loadingLabel.text = @""; // clear for later display;
}


- (void)dealloc {
  [things release];
  [loadingLabel release];
  [super dealloc];
}

@end
