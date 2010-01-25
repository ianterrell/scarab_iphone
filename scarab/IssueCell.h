//
//  IssueCell.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTableViewCell.h"

#define kIssueCellHeight 80

@interface IssueCell : SMTableViewCell {
  IBOutlet UIImageView *scarab;
  IBOutlet UILabel *number;
  IBOutlet UILabel *title;
  IBOutlet UILabel *subtitle;
  IBOutlet UILabel *preview;

}

@property(nonatomic,retain) UIImageView *scarab;
@property(nonatomic,retain) UILabel *number;
@property(nonatomic,retain) UILabel *title;
@property(nonatomic,retain) UILabel *subtitle;
@property(nonatomic,retain) UILabel *preview;

@end
