//
//  WorkViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorViewController.h"

@interface WorkViewController : UIViewController <AuthorViewControllerDelegate> {
  IBOutlet UIWebView *workText;
}

@property(nonatomic,retain) UIWebView *workText;

-(IBAction)showAuthorView;

@end
