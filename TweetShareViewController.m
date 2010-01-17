//
//  TweetShareViewController.m
//  Scarab
//
//  Created by Ian Terrell on 1/17/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import "TweetShareViewController.h"


@implementation TweetShareViewController

@synthesize tweetView, usernameField, passwordField, followSwitch;

- (id)init {
  if (self = [super init]) {
    self.title = @"Tweet it!";
  }
  return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];

  TTButton *tweet = [TTButton buttonWithStyle:@"tweetItButton:" title:@"Send!"];
  tweet.frame = CGRectMake(210, 166, 90, 30);
  tweet.font = [UIFont boldSystemFontOfSize:14.0];
  //[self.purchaseButton addTarget:self action:@selector(purchaseIssue) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:tweet];

  [self.usernameField becomeFirstResponder];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [tweetView release];
  [usernameField release];
  [passwordField release];
  [followSwitch release];
  [super dealloc];
}


@end
