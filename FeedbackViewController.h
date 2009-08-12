//
//  FeedbackViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeedbackViewController : UIViewController <TTPostControllerDelegate> {
  IBOutlet UIButton *button;
}

@property(nonatomic,retain) UIButton *button;

- (IBAction)sendFeedback;

@end
