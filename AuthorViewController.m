//
//  AuthorViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "AuthorViewController.h"


@implementation AuthorViewController

@synthesize navigationItem, webView, delegate;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // TODO: Set real author information, like, duh.
  
  self.navigationItem.title = @"Ian Terrell";
  NSString *bio = @"<html><head><style>body { font-family: helvetica; }</style></head><body><img src=\"ian_128.jpg\" style=\"float:left;margin-right: 10px; margin-bottom: 5px;\"/><b>IAN TERRELL</b> grew up in Tacoma, Washington, and has since claimed Cape Cod and Alaska as home. He is the author of <a href=\"http://www.amazon.com/gp/product/098004071X?ie=UTF8&tag=fromthefish-20&linkCode=xm2&creativeASIN=098004071X\"><em>Interpretive Work</em></a> (<a href=\"http://www.arktoi.com\">Arktoi Books</a>/Red Hen Press, 2008) and <a href=\"http://www.amazon.com/gp/product/0892553553?ie=UTF8&tag=fromthefish-20&creativeASIN=0892553553\"><em>Approaching Ice</em></a> (forthcoming from <a href=\"http://www.perseabooks.com/\">Persea Books</a> in late 2009).</p><p>His poems have been publihed in such journals as <em>The Atlantic Monthly</em>, <em>Poetry</em>,<em> Prairie Schooner</em>, <em>Field</em>, <em>The Believer</em>, and <em>Orion</em> as well as in several anthologies. Ian has received a Wallace Stegner Fellowship from Stanford University and a scholarship to the Bread Loaf Writer's Conference. In 2005, he launched <a href=\"http://www.broadsidedpress.org\">Broadsided Press</a>, a grassroots-distributed and guerilla-art-inspired project.</p><p>He works as a naturalist.</p><ul><li>Webpage: <a href=\"http://ianterrell.com\">http://ianterrell.com</a></li><li>Email: <a href=\"mailto:ian.terrell@gmail.com\">ian.terrell@gmail.com</a></li></ul></body></html>";




  //<div id="a002223more"><div id="more"><p><a href="mailto:lizbradfield@gmail.com">Email</a><br />
  NSString *imagePath = [[NSBundle mainBundle] resourcePath];
  imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
  imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  [webView loadHTMLString:bio baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",imagePath]]];}

-(IBAction)done {
  [self.delegate authorViewControllerDidFinish:self];	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 return YES;
}


- (void)dealloc {
  [navigationItem release];
  [webView release];
  [super dealloc];
}


@end
