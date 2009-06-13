//
//  AuthorViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "AuthorViewController.h"


@implementation AuthorViewController

-(void)viewDidLoad {
  self.title = @"Ian Terrell";
  // TODO: Set real author information, like, duh.
  NSString *imagePath = [[NSBundle mainBundle] resourcePath];
  imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
  imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  [self openURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//ian_bio.html",imagePath]]];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 return YES;
}


-(void)dealloc {
  [super dealloc];
}


@end
