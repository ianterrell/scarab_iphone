//
//  GiveawayViewController.h
//  Scarab
//
//  Created by Ian Terrell on 1/17/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiveawayViewController : UIViewController {
  IBOutlet UITextField* emailField;
  IBOutlet UISwitch* mailingListSwitch;
  
  TTButton* signUpButton;
}

@property(nonatomic, retain) UITextField* emailField;
@property(nonatomic, retain) UISwitch* mailingListSwitch;

@property(nonatomic, retain) TTButton* signUpButton;

@end
