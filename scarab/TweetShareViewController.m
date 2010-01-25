//
//  TweetShareViewController.m
//  Scarab
//
//  Created by Ian Terrell on 1/17/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import "TweetShareViewController.h"


@implementation TweetShareViewController

@synthesize tweetView, usernameField, passwordField, followSwitch, twitterEngine, activityView, tweetingLabel, tweetButton;

- (id)init {
  if (self = [super init]) {
    self.title = @"Tweet it!";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  tweetView.delegate = self;

  self.tweetButton = [TTButton buttonWithStyle:@"tweetItButton:" title:@"Send"];
  self.tweetButton.frame = CGRectMake(210, 166, 90, 30);
  self.tweetButton.font = [UIFont boldSystemFontOfSize:14.0];
  [self.tweetButton addTarget:self action:@selector(tweet) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.tweetButton];

  self.twitterEngine = [MGTwitterEngine twitterEngineWithDelegate:self];
  sentTweet = NO;
  
  [self.usernameField becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)newText {
  NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:newText];
  return (newString.length <= 140);
}

-(void)toggleButtonAndTweetingNotification {
  self.tweetButton.hidden = !self.tweetButton.hidden;
  self.tweetingLabel.hidden = !self.tweetButton.hidden;
  self.tweetingLabel.hidden ? [activityView stopAnimating] : [activityView startAnimating];
}

-(void)tweet {
  [self.twitterEngine setUsername:usernameField.text password:passwordField.text];
  [self.twitterEngine setClientName:@"Scarab Magazine" version:@"1.1" URL:@"http://www.scarabmag.com" token:@"scarabmag"];
  debugLog(@"sending tweet: %@", tweetView.text);
  [self toggleButtonAndTweetingNotification];
  [self.twitterEngine sendUpdate:tweetView.text];
}

#pragma mark Twitter Callbacks

- (void)requestSucceeded:(NSString *)requestIdentifier {
  debugLog(@"request succeeded!");
  if (sentTweet) {
    TTAlert(@"Tweet sent and you're now following @scarabmag!  Thank you!");
    // Add analytics for sharing via tweet
    [[Beacon shared] startSubBeaconWithName:@"Shared - Twitter - Followed" timeSession:NO];
    [self.navigationController popViewControllerAnimated:YES];
  } else {
    sentTweet = YES;
    debugLog(@"sent tweet successfully");
    if (followSwitch.on) {
      debugLog(@"following scarabmag as requested");
      [self.twitterEngine enableUpdatesFor:@"scarabmag"];
    } else {
      TTAlert(@"Tweet sent.  Thank you!");
      // Add analytics for sharing via tweet
      [[Beacon shared] startSubBeaconWithName:@"Shared - Twitter - Not Followed" timeSession:NO];
      [self.navigationController popViewControllerAnimated:YES];
    }
  }
}

- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error {
  debugLog(@"Error in Twitter request... %@", [error localizedDescription]);
  switch ([error code]) {
    case 401:
      TTAlert(@"Your login information doesn't work!");
      break;
    case -1009:
      TTAlert(@"No internet connection is available!  Try later!");
      break;
    default:
      TTAlert(@"Twitter can't be reached right now!  Try later!");
      break;
  }
  [self toggleButtonAndTweetingNotification];
}


- (void)dealloc {
  [tweetButton release];
  [twitterEngine release];
  [activityView release];
  [tweetingLabel release];
  [tweetView release];
  [usernameField release];
  [passwordField release];
  [followSwitch release];
  [super dealloc];
}


@end
