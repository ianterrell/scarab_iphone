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

@synthesize workText, favoriteStar, authorImage;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Issue 4";
  [self.workText loadHTMLString:@"<html><head><style>body { font-family: helvetica; }</style></head><body><p>Roses are red<br/>Violets are blue<br/>Blah blah blah<br/>Hizzah boo hoo.</p><p>Roses are white<br/>Violets are purple<br/>Blah blah blah<br/>Rizzah yurple.</p><p>Roses are pink<br/>Violets are yellow<br/>Blah blah blah<br/>Kizzah mellow.</p><br/><i>Read by the author</i><br/><br/><br/><br/></body></html>" baseURL:nil];
    
  // Set author image with rounded corners
  [UIHelpers addRoundedImageNamed:@"ian.png" toView:self.view];
  
  // Set up byline
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  label.font = [UIFont systemFontOfSize:14];
  label.text = [TTStyledText textFromXHTML:@"<i>A poem by <a href=\"tt://author\">Ian Terrell</a></i>" lineBreaks:NO urls:YES];
  label.frame = CGRectMake(80, 52, 200, 23);
  label.textColor = RGBCOLOR(100,100,100);
  label.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
  label.backgroundColor = [UIColor clearColor];  
  [self.view addSubview:label];
  
  // Set up navigation to author view
  [[TTNavigationCenter defaultCenter] addView:@"author" target:self action:@selector(showAuthorViewWithObject:type:state:)];
}

-(void)showAuthorViewWithObject:(id)object type:(id)type state:(id)state {
	AuthorViewController *authorViewController = [[AuthorViewController alloc] initWithNibName:@"AuthorViewController" bundle:nil];
	[self.navigationController pushViewController:authorViewController animated:YES];
	[authorViewController release];
}

-(IBAction)toggleFavorite {
  static BOOL favorite = NO;
  if (favorite)
    [favoriteStar setImage:[UIImage imageNamed:@"star-empty.png"] forState:UIControlStateNormal];
  else
    [favoriteStar setImage:[UIImage imageNamed:@"star-full.png"] forState:UIControlStateNormal];
  favorite = !favorite;
}

- (void)dealloc {
  [[TTNavigationCenter defaultCenter] removeView:@"author"];
  [favoriteStar release];
  [workText release];
  [authorImage release];
  [super dealloc];
}


@end
