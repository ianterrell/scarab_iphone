//
//  InterviewViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "InterviewViewController.h"
#import "Interview.h"
#import "Author.h"
#import "FootnoteView.h"
#import "Footnote.h"

#define kFootnoteAnimationDuration 0.3
#define kFootnoteStartX 4
#define kFootnoteEndX 4

@implementation InterviewViewController

@synthesize interview, nextFootnote, subTitleLabel, scrollView, footnoteView;

-(id)initWithId:(NSString *)interviewId {
  if (self = [super init]) {
    self.interview = [Interview interviewWithId:[NSNumber numberWithInt:[interviewId intValue]]];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  AppDelegate.interviewViewController = self;
  
  if (self.interview == nil)
    return;
  
  // Add analytics hit for the interview
  [[Beacon shared] startSubBeaconWithName:[NSString stringWithFormat:@"Interview %d - %@", [self.interview.interviewId intValue], self.interview.author.name] timeSession:NO];
  
  self.title = @"Interview";

  // Title
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  label.font = [UIFont systemFontOfSize:17];
  label.text = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"<b><a href=\"scarab://authors/%@\">%@</a></b>", self.interview.authorId, self.interview.author.name] lineBreaks:NO URLs:YES]; 
  label.frame = CGRectMake(80, 8, 220, 25);
  label.textColor = [UIColor blackColor];//RGBCOLOR(100,100,100);
  label.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
  label.backgroundColor = [UIColor clearColor];  
  [self.view addSubview:label];

  // Date
  self.subTitleLabel.text = self.interview.date;

  // Image
  [UIHelpers addRoundedImageWithURL:[self.interview.author fullyQualifiedPhotoUrl] toView:self.view];
  
  // Body 
  [UIHelpers addCopy:[StringUtils prepForLabel:self.interview.body] toScrollView:scrollView];
  
  // Footnote
  self.footnoteView = [[FootnoteView alloc] init];
  [footnoteView setTextFromXHTML:@"<i>Most links in the interviews are actually footnotes, which appear here when you tap on them.  To hide this notice and other real footnotes, touch them and swipe straight down.</i>"];
  footnoteView.origin = CGPointMake(kFootnoteStartX, self.view.height);
  footnoteView.interviewViewController = self;
  [self.view addSubview:footnoteView];
  
  // Show tutorial footnote?
  NSString *tutorialShownFilePath = [NSString stringWithFormat:@"%@/footnoteTutorialShown", [AppDelegate applicationDocumentsDirectory]];
  if (![[NSFileManager defaultManager] fileExistsAtPath:tutorialShownFilePath]) {
    [self showFootnote];
    [[NSFileManager defaultManager] createFileAtPath:tutorialShownFilePath contents:nil attributes:nil];
  }
}

#pragma mark -
#pragma mark Footnotes

- (void)openFootnoteWithId:(NSString *)footnoteId {
  Footnote *f = [Footnote footnoteWithId:[NSNumber numberWithInt:[footnoteId intValue]]];
  if (footnoteUp) {
    self.nextFootnote = f;
    [self hideFootnoteShowNext:YES];
  } else {
    [footnoteView setTextFromXHTML:f.body];
    [self showFootnote];
  }
}

- (void)showNextFootnote {
  [footnoteView setTextFromXHTML:nextFootnote.body];
  [self showFootnote];
  nextFootnote = nil;
}

- (void)showFootnote {
  footnoteView.userInteractionEnabled = YES;
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:kFootnoteAnimationDuration];
  footnoteView.origin = CGPointMake(kFootnoteEndX, self.view.height-footnoteView.height);
  footnoteUp = YES;
  [UIView commitAnimations];
}

- (void)hideFootnoteShowNext:(BOOL)next {
  footnoteView.userInteractionEnabled = NO;
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:kFootnoteAnimationDuration];
  
  if (next) {
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(showNextFootnote)];
  }
  
  footnoteView.origin = CGPointMake(kFootnoteStartX, self.view.height);
  footnoteUp = NO;
  [UIView commitAnimations];
}


#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  debugLog(@"deallocing InterviewViewController");

  [nextFootnote release];
  [footnoteView release];
  [interview release];
  [subTitleLabel release];
  [scrollView release];

  [super dealloc];
}

@end
