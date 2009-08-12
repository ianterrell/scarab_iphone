//
//  RestoreTransactionsViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "RestoreTransactionsViewController.h"
#import "SMStore.h"

@implementation RestoreTransactionsViewController

- (id)init {
  if (self = [super init]) {
    self.title = @"Sync Device";
    UIImage* image = [UIImage imageNamed:@"57-download.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    TTButton *button = [TTButton buttonWithStyle:@"purchasebutton:" title:@"Sync Device"];
    button.frame = CGRectMake(90,164,140,40);
    button.font = [UIFont boldSystemFontOfSize:14.0];
    [button addTarget:self action:@selector(cleanUpFiles) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  }
  return self;
}

- (IBAction)restoreTransactions {
  [AppDelegate showHUDWithLabel:nil details:@"Syncing" animated:YES];
  [[SMStore defaultStore] restoreAllTransactions];
}

- (void)dealloc {
  [super dealloc];
}


@end
