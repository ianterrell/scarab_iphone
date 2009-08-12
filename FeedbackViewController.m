//
//  FeedbackViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "FeedbackViewController.h"
#import "Feedback.h"

@implementation FeedbackViewController

@synthesize button;

- (id)init {
  if (self = [super init]) {
    self.title = @"Send Feedback";
    UIImage* image = [UIImage imageNamed:@"18-envelope.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
  }
  return self;
}

- (IBAction)sendFeedback {
  TTPostController* controller = [[[TTPostController alloc] init] autorelease];
  controller.originView = button;
  controller.delegate = self;
  [controller showInView:self.view animated:YES];
}

- (void)postController:(TTPostController*)postController didPostText:(NSString*)text withResult:(id)result {
  [AppDelegate showHUDWithLabel:nil details:@"Sending" whileExecuting:@selector(postFeedback:) onTarget:self withObject:text animated:YES];
}

- (void)postFeedback:(NSString *)text {
  Feedback *feedback = [[Feedback alloc] init];
  feedback.text = text;
  if (![feedback saveRemote]) {
    // TODO: ERROR ALERT
  }
  [feedback release];
}

- (void)dealloc {
  [button release];
  [super dealloc];
}


@end
