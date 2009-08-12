//
//  FeedbackViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeedbackViewController : UIViewController <TTPostControllerDelegate> {
  IBOutlet TTButton *button;
}

@property(nonatomic,retain) TTButton *button;

- (IBAction)sendFeedback;

@end
