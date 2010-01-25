//
//  TweetShareViewController.h
//  Scarab
//
//  Created by Ian Terrell on 1/17/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTwitterEngine.h"

@interface TweetShareViewController : UIViewController <MGTwitterEngineDelegate, UITextViewDelegate> {
  IBOutlet UITextView* tweetView;
  IBOutlet UITextField* usernameField;
  IBOutlet UITextField* passwordField;
  IBOutlet UISwitch* followSwitch;
  IBOutlet UIActivityIndicatorView* activityView;
  IBOutlet UILabel* tweetingLabel;
  
  TTButton* tweetButton;
  MGTwitterEngine *twitterEngine;
  BOOL sentTweet;
}

@property(nonatomic, retain) UITextView* tweetView;
@property(nonatomic, retain) UITextField* usernameField;
@property(nonatomic, retain) UITextField* passwordField;
@property(nonatomic, retain) UISwitch* followSwitch;
@property(nonatomic, retain) UIActivityIndicatorView* activityView;
@property(nonatomic, retain) UILabel* tweetingLabel;
  
@property(nonatomic, retain) TTButton* tweetButton;
@property(nonatomic, retain) MGTwitterEngine *twitterEngine;

@end
