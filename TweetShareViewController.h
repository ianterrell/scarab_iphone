//
//  TweetShareViewController.h
//  Scarab
//
//  Created by Ian Terrell on 1/17/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetShareViewController : UIViewController {
  IBOutlet UITextView* tweetView;
  IBOutlet UITextField* usernameField;
  IBOutlet UITextField* passwordField;
  IBOutlet UISwitch* followSwitch;
}

@property(nonatomic, retain) UITextView* tweetView;
@property(nonatomic, retain) UITextField* usernameField;
@property(nonatomic, retain) UITextField* passwordField;
@property(nonatomic, retain) UISwitch* followSwitch;

@end
