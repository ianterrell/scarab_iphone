//
//  NewsViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/4/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "NewsViewController.h"
#import "Update.h"
#import "SMUpdatingDisplay.h"

@implementation NewsViewController

- (int)setupDatasourceFromDb {
  TTListDataSource *source = [[TTListDataSource alloc] init];
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:NO];
  NSArray *updates = [Update fetchWithSortDescriptor:sortDescriptor limit:10];
  [sortDescriptor release];
  int last = 0;
  for (Update *update in updates) {
    debugLog(@"body is --%@--", update.body);
    [source.items addObject:[TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:update.body] URL:nil]];
    if (last == 0)
      last = [update.number intValue];
  }
  self.dataSource = source;
  [self refresh];
  return last;
}

- (id)init {
  if (self = [super init]) {
    self.title = @"News";

    UIImage* image = [UIImage imageNamed:@"09-chat2.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    self.autoresizesForKeyboard = YES;
    self.variableHeightRows = YES;
    self.tableView.allowsSelection = NO;
    
    currentUpdateNumber = [self setupDatasourceFromDb];
    if (!fetchedTheNews) {
      [[SMUpdatingDisplay sharedDisplay] addCheckingFor:@"news"];
      [NSThread detachNewThreadSelector:@selector(fetchNews) toTarget:self withObject:nil];
    }
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];


}


-(void)fetchNews {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  debugLog(@"The number of the last update in the database is %d", currentUpdateNumber);
  NSArray *newUpdatesOnServer = [Update findAllSinceNumber:[NSNumber numberWithInt:currentUpdateNumber]];
  debugLog(@"There are %d new updates on the server", [newUpdatesOnServer count]);
  
  int count = [newUpdatesOnServer count];
  if (count > 0) {
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", count];
    
    for (Update *update in newUpdatesOnServer)
      [AppDelegate.managedObjectContext insertObject:update];

    NSError *error = nil;
    [AppDelegate save:&error];
    if (error) {
      debugLog(@"Error saving new news:  %@", [error localizedDescription]);
      [AppDelegate showSaveError];
    }
  }
  fetchedTheNews = YES;
  [self setupDatasourceFromDb];

  [[SMUpdatingDisplay sharedDisplay] removeCheckingFor:@"news"];
  [pool release];
}

@end