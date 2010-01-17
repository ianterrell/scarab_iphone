//
//  ShareViewController.m
//  Scarab
//
//  Created by Ian Terrell on 1/15/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import "ShareViewController.h"

#define fbApiKey @"6944bbdfd85e1a3a6f77ae658f2aa323"
#define fbApiSecret @"88f6116219d59cb39090454192917cac" 

@implementation ShareViewController

@synthesize session;

#pragma mark -
#pragma mark Initialization

- (id)init {
  if (self = [super init]) {
    self.title = @"Share with Friends";
  }
  return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  self.session = [FBSession sessionForApplication:fbApiKey secret:fbApiSecret delegate:self];

  FBLoginButton* button = [[[FBLoginButton alloc] init] autorelease];
  button.frame = CGRectMake(210, 20, 90, 30);
  [self.view addSubview:button];
  
  TTButton *tweet = [TTButton buttonWithStyle:@"tweetItButton:" title:@"Tweet it"];
  tweet.frame = CGRectMake(210, 153, 90, 30);
  tweet.font = [UIFont boldSystemFontOfSize:14.0];
  //[self.purchaseButton addTarget:self action:@selector(purchaseIssue) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:tweet];

  TTButton *email = [TTButton buttonWithStyle:@"purchasebutton:" title:@"Share via Email"];
  email.frame = CGRectMake(20, 288, 280, 50);
  email.font = [UIFont boldSystemFontOfSize:22.0];
  //[self.purchaseButton addTarget:self action:@selector(purchaseIssue) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:email];

}

#pragma mark -
#pragma mark Facebook Methods and Callbacks

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
//  debugLog(@"did login with facebook user id: %@", uid);
  [self showPublishDialog];
}

-(void)showPublishDialog {
  FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.delegate = self;
  dialog.userMessagePrompt = @"Tell your friends about Scarab!";
	dialog.attachment = @"{\"name\":\"Scarab Magazine\","
		"\"href\":\"http://www.scarabmag.com\","
		"\"caption\":\"A literary magazine for your iPhone.\","
    "\"description\":\"Listen to and read along with the best in contemporary poetry and prose. Eleven new works and an interview per issue, delivered right into your hand.\","
		"\"properties\":{\"App\":{\"text\":\"Scarab on iTunes\",\"href\":\"http://itunes.com/apps/scarab\"}}}";
	[dialog show];
}

- (void)dialogDidSucceed:(FBDialog*)dialog {
  debugLog(@"dialog did succeed!");
}

- (void)dialogDidCancel:(FBDialog*)dialog {
  debugLog(@"dialog did cancel.");
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error {
  debugLog(@"dialog did fail with error: %@", [error localizedDescription]);
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
  [session.delegates removeObject:self];
  [session release];
  [super dealloc];
}


@end
