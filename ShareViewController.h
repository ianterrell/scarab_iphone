//
//  ShareViewController.h
//  Scarab
//
//  Created by Ian Terrell on 1/15/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"
#import <MessageUI/MessageUI.h>


@interface ShareViewController : UIViewController <FBSessionDelegate, FBDialogDelegate, MFMailComposeViewControllerDelegate> {
  FBSession *session;
}

@property(nonatomic, retain) FBSession *session;

-(void)showPublishDialog;
-(void)openTweetView;

@end
