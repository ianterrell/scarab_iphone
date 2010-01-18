//
//  GiveawayViewController.m
//  Scarab
//
//  Created by Ian Terrell on 1/17/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import "GiveawayViewController.h"
#import "Device.h"

@implementation GiveawayViewController

@synthesize emailField, mailingListSwitch, signUpButton;

- (id)init {
  if (self = [super init]) {
    self.title = @"Free iTunes Gift Cards";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Did we already sign up?
  NSString *signedUpEmail = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/promotionEmail", [AppDelegate applicationDocumentsDirectory]] encoding:NSASCIIStringEncoding error:nil];
  if (signedUpEmail != nil)
    self.emailField.text = signedUpEmail;

  self.signUpButton = [TTButton buttonWithStyle:@"purchasebutton:" title:(signedUpEmail == nil ? @"Sign Up" : @"Update")];
  self.signUpButton.frame = CGRectMake(210, 94, 90, 30);
  self.signUpButton.font = [UIFont boldSystemFontOfSize:14.0];
  [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.signUpButton];
}

-(void)signUp {
  if ([self.emailField.text length] < 7) {
    TTAlert(@"Make sure to enter your email address properly!");
  } else if (AppDelegate.pushNotificationDeviceToken == nil) {
    TTAlert(@"We couldn't find your push notification setup!  Make sure you have them turned on!  Check the Settings app to double check.");
  } else {
    Device *device = [[Device alloc] init];
    device.token = AppDelegate.pushNotificationDeviceToken;
    device.email = self.emailField.text;
    device.okToEmail = self.mailingListSwitch.on;
    if ([device saveRemote]) {
      TTAlert(@"You're all signed up to win free gift cards!  Be sure to stop back by here again if your email address changes.");
      [self.emailField.text writeToFile:[NSString stringWithFormat:@"%@/promotionEmail", [AppDelegate applicationDocumentsDirectory]] atomically:YES encoding:NSASCIIStringEncoding error:nil];
    } else {
      TTAlert(@"There was an error signing you up -- please try again later!  Sorry!");
    }
  }
}


- (void)dealloc {
  [signUpButton release];
  [emailField release];
  [mailingListSwitch release];
  [super dealloc];
}


@end
