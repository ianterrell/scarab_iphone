//
//  WorksBaseTableViewController.m
//  Scarab
//
//  Created by Ian Terrell on 7/31/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "WorksBaseTableViewController.h"

#import "Work.h"
#import "Author.h"
#import "WorkCell.h"

@implementation WorksBaseTableViewController

@synthesize works;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return works == nil ? 0 : [works count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kWorkCellHeight;
}

-(Work *)workAtIndexPath:(NSIndexPath *)indexPath {
  return (Work *)[works objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"WorkCell";
  WorkCell *cell = (WorkCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [WorkCell createNewCellFromNib];
  }
  
  Work *work = [self workAtIndexPath:indexPath];
  if (work != nil) {
    cell.title.text = work.title;
    cell.subtitle.text = [NSString stringWithFormat:@"%@ %@", [work aTypeBy], work.author.name];
    [UIHelpers addRoundedImageWithURL:[work.author fullyQualifiedPhotoUrl] toView:cell];
  }
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
  //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg_selected.png"]];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TTOpenURL([NSString stringWithFormat:@"scarab://works/%@", [self workAtIndexPath:indexPath].workId]);
}

- (void)dealloc {
  [works release];
  [super dealloc];
}


@end

