//
//  AuthorViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthorViewControllerDelegate;

@interface AuthorViewController : UIViewController {
  IBOutlet UINavigationItem *navigationItem;
  IBOutlet UIWebView *webView;
  id <AuthorViewControllerDelegate> delegate;
}

@property(nonatomic,retain) UIWebView *webView;
@property(nonatomic,retain) UINavigationItem *navigationItem;
@property(nonatomic,assign) id <AuthorViewControllerDelegate> delegate;

-(IBAction)done;

@end

@protocol AuthorViewControllerDelegate
- (void)authorViewControllerDidFinish:(AuthorViewController *)controller;
@end

