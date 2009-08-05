//
//  InterviewViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InterviewViewController : UIViewController {
  IBOutlet UILabel *titleLabel;
  IBOutlet UIScrollView *scrollView;
}

@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UIScrollView *scrollView;

@end
