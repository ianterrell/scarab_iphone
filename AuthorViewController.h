//
//  AuthorViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Author;

@interface AuthorViewController : UIViewController {
  IBOutlet UIScrollView *scrollView;
  IBOutlet UILabel *name;
  IBOutlet UILabel *location;
  Author *author;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UILabel *name;
@property(nonatomic,retain) UILabel *location;
@property(nonatomic,retain) Author *author;

@end
