//
//  WorkViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "WorkViewController.h"
#import "AuthorViewController.h"

@implementation WorkViewController

@synthesize workText;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Issue 4";
  [self.workText loadHTMLString:@"<html><head><style>body { font-family: helvetica; }</style></head><body><p>Roses are red<br/>Violets are blue<br/>Blah blah blah<br/>Hizzah boo hoo.</p><p>Roses are white<br/>Violets are purple<br/>Blah blah blah<br/>Rizzah yurple.</p><p>Roses are pink<br/>Violets are yellow<br/>Blah blah blah<br/>Kizzah mellow.</p><br/><i>Read by the author</i><br/><br/><br/><br/></body></html>" baseURL:nil];
}

-(IBAction)showAuthorView {
  AuthorViewController *controller = [[AuthorViewController alloc] initWithNibName:@"AuthorViewController" bundle:nil];
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

-(void)authorViewControllerDidFinish:(AuthorViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
  [workText release];
  [super dealloc];
}


@end
