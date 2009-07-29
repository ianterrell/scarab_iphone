//
//  AuthorViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "AuthorViewController.h"


@implementation AuthorViewController

@synthesize scrollView;

-(void)viewDidLoad {
  // TODO: Set real author information, like, duh.
  
  self.title = @"Brian Wilkins";
  
  // Set author image with rounded corners
  [UIHelpers addRoundedImageNamed:@"brian.jpg" toView:self.view];
  
  // Set up bio
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  
  label.font = [UIFont systemFontOfSize:14];
  
  NSString *bioCopy = @"<b>Brian Wilkins</b> currently lives on an air-mattress which floats down the Cocheco river in heavy rains. He holds, nay clutches, a MFA from the University of New Hampshire, which he believes will be rescinded in the near future. He has been published several times out of pity. His current venture is this very magazine, the finest thing he has accomplished short of winning a dance-a-thon.<br/><br/>You can find his latest works at <a href=\"http://www.amazon.com/\">Amazon.com</a>.";
  //<ul><li>Webpage: <a href=\"http://ianterrell.com\">http://ianterrell.com</a></li><li>Email: <a href=\"mailto:ian.terrell@gmail.com\">ian.terrell@gmail.com</a></li></ul>
  label.text = [TTStyledText textFromXHTML:bioCopy lineBreaks:YES URLs:YES];
  label.frame = CGRectMake(0, 0, 320, 283);
  label.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
  label.backgroundColor = [UIColor clearColor];  
  [label sizeToFit];
  [scrollView addSubview:label];
  
  scrollView.contentSize = CGSizeMake(scrollView.width, label.height);
  
  AppDelegate.visibleController = self;
}

-(void)dealloc {
  [scrollView release];
  [super dealloc];
}


@end
