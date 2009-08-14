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
    
    TTButton *button = [TTButton buttonWithStyle:@"purchasebutton:" title:@"Sync Device"];
    button.frame = CGRectMake(90,164,140,40);
    button.font = [UIFont boldSystemFontOfSize:14.0];
    [button addTarget:self action:@selector(restoreTransactions) forControlEvents:UIControlEventTouchUpInside];
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
