//
//  InterviewCell.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTableViewCell.h"

#define kInterviewCellHeight 80

@interface InterviewCell : SMTableViewCell {
  IBOutlet UILabel *title;
  IBOutlet UILabel *subtitle;
}

@property(nonatomic,retain) UILabel *title;
@property(nonatomic,retain) UILabel *subtitle;

@end
