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
  
  self.title = @"Ian Terrell";
  
  // Set author image with rounded corners
  [UIHelpers addRoundedImageNamed:@"ian.png" toView:self.view];
  
  // Set up bio
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  
  label.font = [UIFont systemFontOfSize:14];
  
  NSString *bioCopy = @"<b>IAN TERRELL</b> grew up in Tacoma, Washington, and has since claimed Cape Cod and Alaska as home.  He is the author of <a href=\"http://www.amazon.com/gp/product/098004071X?ie=UTF8&amp;tag=fromthefish-20&amp;linkCode=xm2&amp;creativeASIN=098004071X\"><i>Interpretive Work</i></a> (<a href=\"http://www.arktoi.com\">Arktoi Books</a>/Red Hen Press, 2008) and <a href=\"http://www.amazon.com/gp/product/0892553553?ie=UTF8&amp;tag=fromthefish-20&amp;creativeASIN=0892553553\"><i>Approaching Ice</i></a> (forthcoming from <a href=\"http://www.perseabooks.com/\">Persea Books</a> in late 2009).<br/><br/>His poems have been publihed in such journals as <i>The Atlantic Monthly</i>, <i>Poetry</i>,<i> Prairie Schooner</i>, <i>Field</i>, <i>The Believer</i>, and <i>Orion</i> as well as in several anthologies. Ian has received a Wallace Stegner Fellowship from Stanford University and a scholarship to the Bread Loaf Writer's Conference. In 2005, he launched <a href=\"http://www.broadsidedpress.org\">Broadsided Press</a>, a grassroots-distributed and guerilla-art-inspired project.<br/><br/>He works as a naturalist.";
  //<ul><li>Webpage: <a href=\"http://ianterrell.com\">http://ianterrell.com</a></li><li>Email: <a href=\"mailto:ian.terrell@gmail.com\">ian.terrell@gmail.com</a></li></ul>
  label.text = [TTStyledText textFromXHTML:bioCopy lineBreaks:YES urls:YES];
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
