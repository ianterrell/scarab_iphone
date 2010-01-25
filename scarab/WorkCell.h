//
//  WorkCell.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTableViewCell.h"

#define kWorkCellHeight 80

@interface WorkCell : SMTableViewCell {
  IBOutlet UILabel *title;
  IBOutlet UILabel *subtitle;
}

@property(nonatomic,retain) UILabel *title;
@property(nonatomic,retain) UILabel *subtitle;

@end
