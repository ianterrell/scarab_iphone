//
//  RestoreTransactionsViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "RestoreTransactionsViewController.h"
#import "SMStore.h"

@implementation RestoreTransactionsViewController

- (id)init {
  if (self = [super init]) {
    self.title = @"Sync Device";
    UIImage* image = [UIImage imageNamed:@"57-download.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    TTButton *button = [TTButton buttonWithStyle:@"purchasebutton:" title:@"Sync Device"];
    button.frame = CGRectMake(90,164,140,40);
    button.font = [UIFont boldSystemFontOfSize:14.0];
    [button addTarget:self action:@selector(cleanUpFiles) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  }
  return self;
}

- (IBAction)restoreTransactions {
  [AppDelegate showHUDWithLabel:nil details:@"Syncing" animated:YES];
  [[SMStore defaultStore] restoreAllTransactions];
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
    [super dealloc];
}


@end
