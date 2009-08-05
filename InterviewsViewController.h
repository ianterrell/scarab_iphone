//
//  InterviewsViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InterviewsViewController : UITableViewController {
  NSMutableArray *interviews;
  BOOL fetchedNewInterviews;
  int lastInterviewNumber;
}


@property(nonatomic,retain) NSMutableArray *interviews;

- (int)setupInterviewsFromDb;
- (void)fetchNewInterviews;

@end
