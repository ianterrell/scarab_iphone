//
//  SplashScreenController.m
//  Scarab
//
//  Created by Ian Terrell on 6/9/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SplashScreenController.h"

#define kSplashScreenFadeTime 0.75

@implementation SplashScreenController

- (void)viewDidLoad {
  [self fade];
}

-(void)fade {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kSplashScreenFadeTime];
  [UIView setAnimationDelegate:AppDelegate];
  [UIView setAnimationDidStopSelector:@selector(doneWithSplash)];
  self.view.alpha = 0.0;
  [UIView commitAnimations];
}

- (void)dealloc {
  [super dealloc];
}


@end
