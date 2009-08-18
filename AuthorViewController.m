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
    self.author = [Author authorWithId:[NSNumber numberWithInt:[authorId intValue]]];
    if (self.author == nil) {
      // TODO: add HUD or something to let them know a fetch is happening
      debugLog(@"fetching author with id %@ from server", authorId);
      Author *a = [Author findRemote:authorId];
      if (a == nil) {
        debugLog(@"error!  couldn't find author on the server -- this could happen; handle!");
        [AppDelegate showGenericError];
      } else {
        [AppDelegate.managedObjectContext insertObject:a];
        NSError *error = nil;
        [AppDelegate save:&error];
        if (error) {
          debugLog(@"Error saving new author:  %@", [error localizedDescription]);
          [AppDelegate showSaveError];
        } else {
          self.author = a;
        }
      }
    }
  }
  return self;
}


-(void)viewDidLoad {
  // Add analytics hit for the author
  [[Beacon shared] startSubBeaconWithName:[NSString stringWithFormat:@"Author %d - %@", [self.author.authorId intValue], self.author.name] timeSession:NO];
  
  self.title = @"Author";
  self.name.text = self.author.name;
  self.location.text = self.author.location;
  [UIHelpers addRoundedImageWithURL:[self.author fullyQualifiedPhotoUrl] toView:self.view];
  [UIHelpers addCopy:[StringUtils prepForLabel:self.author.bio] toScrollView:scrollView];
}

-(void)dealloc {
  [scrollView release];
  [author release];
  [name release];
  [location release];
  [super dealloc];
}


@end
