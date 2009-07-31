//
//  AuthorViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "AuthorViewController.h"
#import "Author.h"

@implementation AuthorViewController

@synthesize scrollView, name, location, author;

-(id)initWithId:(NSString *)authorId {
  if (self = [super init]) {
    self.author = [Author authorWithId:authorId];
    if (self.author == nil) {
      // TODO: add HUD or something to let them know a fetch is happening
      debugLog(@"fetching author with id %@ from server", authorId);
      Author *a = [Author findRemote:authorId];
      if (a == nil) {
        // TODO: handle error
        debugLog(@"error!  couldn't find author on the server -- this could happen; handle!");
      } else {
        [AppDelegate.managedObjectContext insertObject:a];
        NSError *error = nil;
        [AppDelegate save:&error];
        if (error) {
          debugLog(@"Error saving new author:  %@", [error localizedDescription]);
          // TODO: FIXME BITCH WHAT DO I DO?
        } else {
          self.author = a;
        }
      }
    }
  }
  return self;
}


-(void)viewDidLoad {
  self.title = self.author.name;
  self.name.text = self.author.name;
  self.location.text = self.author.location;
  [UIHelpers addRoundedImageWithURL:[self.author fullyQualifiedPhotoUrl] toView:self.view];
  
  debugLog(@"bio is: ------%@------", self.author.bio);
  // Set up bio
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  label.font = [UIFont systemFontOfSize:14];
  label.text = [TTStyledText textFromXHTML:self.author.bio lineBreaks:YES URLs:YES];
  label.frame = CGRectMake(0, 0, 320, 283);
  label.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
  label.backgroundColor = [UIColor clearColor];  
  [label sizeToFit];
  [scrollView addSubview:label];
  scrollView.contentSize = CGSizeMake(scrollView.width, label.height);
}

-(void)dealloc {
  [scrollView release];
  [author release];
  [name release];
  [location release];
  [super dealloc];
}


@end
