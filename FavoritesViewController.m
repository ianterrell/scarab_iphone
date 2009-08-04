//
//  FavoritesViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/4/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Work.h"

@implementation FavoritesViewController

- (id)init {
  if (self = [super init]) {
    self.title = @"Favorites";
    UIImage* image = [UIImage imageNamed:@"28-star.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    AppDelegate.favoritesViewController = self;
    [self reloadFavorites];
  }
  return self;
}

- (void)reloadFavorites {
  self.works = [Work fetchWithPredicate:[NSPredicate predicateWithFormat:@"favorite = %d", YES]];
  [(UITableView *)self.view reloadData];
}

@end
