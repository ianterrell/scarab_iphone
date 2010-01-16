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

- (id)init {
  if (self = [super init]) {
    self.title = @"Share";
  }
  return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  self.session = [FBSession sessionForApplication:fbApiKey secret:fbApiSecret delegate:self];

  FBLoginButton* button = [[[FBLoginButton alloc] init] autorelease];
  [self.view addSubview:button];
  


}

-(IBAction)showDialog {
  FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.delegate = self;
	dialog.userMessagePrompt = @"Example prompt";
	dialog.attachment = @"{\"name\":\"Facebook Connect for iPhone\","
		"\"href\":\"http://developers.facebook.com/connect.php?tab=iphone\","
		"\"caption\":\"Caption\",\"description\":\"Description\","
		"\"media\":[{\"type\":\"image\","
			"\"src\":\"http://img40.yfrog.com/img40/5914/iphoneconnectbtn.jpg\","
			"\"href\":\"http://developers.facebook.com/connect.php?tab=iphone/\"}],"
		"\"properties\":{\"another link\":{\"text\":\"Facebook home page\",\"href\":\"http://www.facebook.com\"}}}";
	// replace this with a friend's UID
	// dialog.targetId = @"999999";
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

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
//  debugLog(@"did login with facebook user id: %@", uid);
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
