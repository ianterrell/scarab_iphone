//
//  CleanUpFilesViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "CleanUpFilesViewController.h"
#import "Work.h"

@implementation CleanUpFilesViewController

@synthesize sizeLabel;


- (id)init {
  if (self = [super init]) {
    self.title = @"Clean Up Files";
    UIImage* image = [UIImage imageNamed:@"20-gear2.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    TTButton *button = [TTButton buttonWithStyle:@"purchasebutton:" title:@"Clean Up Files"];
    button.frame = CGRectMake(90,153,140,40);
    button.font = [UIFont boldSystemFontOfSize:14.0];
    [button addTarget:self action:@selector(cleanUpFiles) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  }
  return self;
}

- (void)calculateAndDisplaySize {
  NSFileManager *manager = [NSFileManager defaultManager];
  NSNumber *fileSize = [NSNumber numberWithUnsignedLongLong:0];
  NSArray *contents = [manager directoryContentsAtPath:[Work audioDirectoryPath]];
  if (contents != nil)
    for (NSString *file in contents) {
      debugLog(@"file is %@ at %@", file, [NSString stringWithFormat:@"%@/%@", [Work audioDirectoryPath], file]);
      NSDictionary *fileAttributes = [manager fileAttributesAtPath:[NSString stringWithFormat:@"%@/%@", [Work audioDirectoryPath], file] traverseLink:YES];
      if (fileAttributes != nil)
        fileSize = [NSNumber numberWithUnsignedLongLong:(0 + [[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue])];
    }
  
  sizeLabel.text = [NSString stringWithFormat:@"%0.1f", [fileSize unsignedLongLongValue]/1024.0/1024.0];
}


- (void)viewDidAppear:(BOOL)animated {
  [self calculateAndDisplaySize];
  [super viewDidAppear:animated];
}

- (IBAction)cleanUpFiles {
  if ([[NSFileManager defaultManager] removeItemAtPath:[Work audioDirectoryPath] error:nil]) {
    [AppDelegate setUpAudioDirectory];
    [self calculateAndDisplaySize];
  } else {
    debugLog(@"error cleaning up files!");
    // TODO FIX ME DISPLAY ERROR
  }
}

- (void)dealloc {
  [sizeLabel release];
  [super dealloc];
}


@end
