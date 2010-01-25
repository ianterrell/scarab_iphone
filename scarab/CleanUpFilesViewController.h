//
//  CleanUpFilesViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CleanUpFilesViewController : UIViewController {
  IBOutlet UILabel *sizeLabel;
}

@property(nonatomic,retain) UILabel *sizeLabel;

- (IBAction)cleanUpFiles;

@end
