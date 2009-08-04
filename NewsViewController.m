//
//  NewsViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/4/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "NewsViewController.h"
#import "Update.h"

@implementation NewsViewController

- (id)init {
  if (self = [super init]) {
    self.title = @"News";

    UIImage* image = [UIImage imageNamed:@"09-chat2.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    self.autoresizesForKeyboard = YES;
    self.variableHeightRows = YES;
    self.tableView.allowsSelection = NO;
    
    // TODO: on init or appear? also reverse sort
    
    TTListDataSource *dataSource = [[[TTListDataSource alloc] init] autorelease];

    self.dataSource = dataSource;
        if (!fetchedTheNews) {
      // TODO:  does this work alphabetically or numerically?  i.e. 1, 10, 11, 2, 3, 4 (prols alphabet, LAME) -- sort in code?
      NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
      NSArray *updates = [Update fetchWithSortDescriptor:sortDescriptor];
      [sortDescriptor release];
      
      debugLog(@"there are %d updates in the db", [updates count]);
      
      currentUpdateNumber = [((Update *)[updates lastObject]).number intValue];
      
      for (Update *update in updates) {
        debugLog(@"body is --%@--", update.body);
        [((TTListDataSource *)self.dataSource).items addObject:[TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:update.body] URL:nil]];
      }
      
      [AppDelegate showHUDWithLabel:nil details:@"Checking for news" whileExecuting:@selector(fetchNews) onTarget:self withObject:nil animated:YES];
      
      [_tableView reloadData];
    }

  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];


}


-(void)fetchNews {
  debugLog(@"The number of the last update in the database is %d", currentUpdateNumber);
  NSArray *newUpdatesOnServer = [Update findAllSinceNumber:[NSNumber numberWithInt:currentUpdateNumber]];
  debugLog(@"There are %d new updates on the server", [newUpdatesOnServer count]);
  
  if ([newUpdatesOnServer count] > 0) {
    // TODO:  guarantee order from server, or sort here
    for (Update *update in newUpdatesOnServer) {
      [AppDelegate.managedObjectContext insertObject:update];
      [((TTListDataSource *)self.dataSource).items addObject:[TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:update.body] URL:nil]];
    }
    
    NSError *error = nil;
    [AppDelegate save:&error];
    if (error) {
      debugLog(@"Error saving new issues in Library:  %@", [error localizedDescription]);
      // TODO: FIXME BITCH WHAT DO I DO?
    }
    [self refresh];
  }
  fetchedTheNews = YES;
}

@end