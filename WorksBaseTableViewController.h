//
//  WorksBaseTableViewController.h
//  Scarab
//
//  Created by Ian Terrell on 7/31/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorksBaseTableViewController : UITableViewController {
  NSMutableArray *works;
}

@property(nonatomic,retain) NSMutableArray *works;

@end
