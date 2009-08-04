//
//  NewsViewController.h
//  Scarab
//
//  Created by Ian Terrell on 8/4/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsViewController : TTTableViewController {
  BOOL fetchedTheNews;
  int currentUpdateNumber;
}

@end
