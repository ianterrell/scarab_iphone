//
//  AuthorViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorViewController : UIViewController {
  IBOutlet UIScrollView *scrollView;
}

@property(nonatomic,retain) UIScrollView *scrollView;

@end
