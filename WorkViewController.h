//
//  WorkViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkViewController : UIViewController {
  IBOutlet UIWebView *workText;
  IBOutlet UIButton *favoriteStar;
  IBOutlet UIImageView *authorImage;
}

@property(nonatomic,retain) UIWebView *workText;
@property(nonatomic,retain) UIButton *favoriteStar;
@property(nonatomic,retain) UIImageView *authorImage;

-(void)showAuthorViewWithObject:(id)object type:(id)type state:(id)state;
-(IBAction)toggleFavorite;

@end
