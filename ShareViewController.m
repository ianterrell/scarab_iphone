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
  tweet.frame = CGRectMake(210, 119, 90, 30);
  tweet.font = [UIFont boldSystemFontOfSize:14.0];
  [tweet addTarget:self action:@selector(openTweetView) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:tweet];

  TTButton *email = [TTButton buttonWithStyle:@"purchasebutton:" title:@"Share via Email"];
  email.frame = CGRectMake(20, 249, 280, 50);
  email.font = [UIFont boldSystemFontOfSize:22.0];
  [email addTarget:self action:@selector(mail) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:email];

  // Add analytics for viewing share screen
  [[Beacon shared] startSubBeaconWithName:@"Viewed Share" timeSession:NO];
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
  // Add analytics for sharing via FB
  [[Beacon shared] startSubBeaconWithName:@"Shared - Facebook" timeSession:NO];
}

- (void)dialogDidCancel:(FBDialog*)dialog {
  debugLog(@"dialog did cancel.");
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error {
  debugLog(@"dialog did fail with error: %@", [error localizedDescription]);
}

#pragma mark -
#pragma mark Button Actions

-(void)openTweetView {
  TTOpenURL(@"scarab://tweetShare");
}

-(void)mail {
  if ([MFMailComposeViewController canSendMail]) {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"Scarab Magazine:  A literary magazine for the iPhone and iPod Touch"];
    [controller setMessageBody:@""
    "<table width=\"100%\" cellpadding=\"5\" cellspacing=\"0\">"
    "	 <tbody><tr>"
    "		 <td valign=\"top\" align=\"left\" width=\"10%\">"
    "		 	 <img src=\"http://192.168.0.104:3000/images/iphone_with_splash.png\" style=\"padding-bottom:10px;\" width=\"144\" height=\"225\">"
    "		 </td>"
    "		 <td valign=\"top\" align=\"left\" width=\"90%;\">"
    "			 <p style=\"font:13px 'Lucida Grande', 'Lucida', 'Helvetica', 'Arial'\">I started reading Scarab, a literary magazine for my iPhone, and I think you'll like it, too.  They feature the best in contemporary artists reading their prose and poetry to you as you follow along, and publish eleven new works an issue.  Plus you can win an iTunes gift card each week just for having the app.  Check it out!</p>"
    "			 <p style=\"font:13px 'Lucida Grande', 'Lucida', 'Helvetica', 'Arial';padding:0;margin:0;padding-bottom:10px;\"><a href=\"http://www.scarabmag.com\">Scarab Homepage</a></p>"
    "			 <p style=\"font:13px 'Lucida Grande', 'Lucida', 'Helvetica', 'Arial';padding:0;margin:0;padding-bottom:10px;\"><a href=\"http://itunes.com/apps/scarab\">Download Scarab on iTunes</a></p>"
    "		 </td>"
    "	 </tr></tbody>"
    "</table>" isHTML:YES];
    [self presentModalViewController:controller animated:YES];
    [controller release];
  } else {
    TTAlert(@"Your device isn't set up to send emails.  Have you set up your Mail app yet?");
  }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
  
  if (result == MFMailComposeResultSent) {    
    // Add analytics for sharing via mail
    [[Beacon shared] startSubBeaconWithName:@"Shared - Email" timeSession:NO];
  }
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
