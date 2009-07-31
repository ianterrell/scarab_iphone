//
//  IssueViewController.h
//  Scarab
//
//  Created by Ian Terrell on 7/29/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorksBaseTableViewController.h"

@class Issue;

@interface IssueViewController : WorksBaseTableViewController {
  Issue *issue;
}

@property(nonatomic,retain) Issue *issue;

@end
