//
//  InterviewsViewController.m
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "InterviewsViewController.h"

#import "Interview.h"
#import "Author.h"
#import "Footnote.h"
#import "InterviewCell.h"

@implementation InterviewsViewController

@synthesize interviews;

- (id)init {
  if (self = [super init]) {
    self.title = @"Interviews";

    UIImage* image = [UIImage imageNamed:@"66-microphone.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if (interviews == nil)
    lastInterviewNumber = [self setupInterviewsFromDb];

  if (!fetchedNewInterviews)
    [AppDelegate showHUDWithLabel:nil details:@"Checking for new interviews" whileExecuting:@selector(fetchNewInterviews) onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark Interview Management

// returns highest number
- (int)setupInterviewsFromDb {
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:NO];
  self.interviews = [Interview fetchWithSortDescriptor:sortDescriptor];
  [sortDescriptor release];
  int count = [self.interviews count];
  debugLog(@"There are %d interviews in the database", count);
  
  [(UITableView *)self.view reloadData];
  
  if (count > 0)
    return [((Interview *)[self.interviews objectAtIndex:0]).number intValue];
  else
    return 0;
}

-(void)fetchNewInterviews {
  debugLog(@"The number of the last interview in the database is %d", lastInterviewNumber);
  NSArray *newInterviewsOnServer = [Interview findAllSinceNumber:[NSNumber numberWithInt:lastInterviewNumber]];
  debugLog(@"There are %d new interviews on the server", [newInterviewsOnServer count]);
  
  if ([newInterviewsOnServer count] > 0) {
    for (Interview *interview in newInterviewsOnServer) {
      [AppDelegate.managedObjectContext insertObject:interview];
      
      // Set author
      Author *author = [Author authorWithId:interview.authorId];
      if (author == nil) {
        author = [Author findRemote:[NSString stringWithFormat:@"%d", [interview.authorId intValue]]];
        if (author == nil) {
          // TODO: handle error
          debugLog(@"error!  couldn't find author on the server -- this could happen (orly?); handle!");
        } else {
          [AppDelegate.managedObjectContext insertObject:author];
          interview.author = author;
        }
      } else {
        interview.author = author;
      }
      
      // Fetch footnotes!
      NSArray *footnotes = [Footnote findAllInInterview:interview];
      for (Footnote *footnote in footnotes) {
        [AppDelegate.managedObjectContext insertObject:footnote];
        footnote.interview = interview;
      }
    }
    
    NSError *error = nil;
    [AppDelegate save:&error];
    if (error) {
      debugLog(@"Error saving new interviews:  %@", [error localizedDescription]);
      for (id key in [error userInfo]) {
        debugLog(@"key: %@, value: %@", key, [[error userInfo] objectForKey:key]);
      }
      // TODO: FIXME BITCH WHAT DO I DO?
      // probably set interviews to empty or nil, alert user to try again or contact support if the problem persists
    } else {
      [self setupInterviewsFromDb];
    }
  }
  
  fetchedNewInterviews = YES;
}

#pragma mark -
#pragma mark Table View Stuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return interviews == nil ? 0 : [interviews count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kInterviewCellHeight;
}

-(Interview *)interviewAtIndexPath:(NSIndexPath *)indexPath {
  return (Interview *)[interviews objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"InterviewCell";
  InterviewCell *cell = (InterviewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [InterviewCell createNewCellFromNib];
  }
  
  Interview *interview = [self interviewAtIndexPath:indexPath];
  if (interview != nil) {
    cell.title.text = interview.author.name;
    cell.subtitle.text = interview.date;
    [UIHelpers addRoundedImageWithURL:[interview.author fullyQualifiedPhotoUrl] toView:cell];
  }
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
  //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg_selected.png"]];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TTOpenURL([NSString stringWithFormat:@"scarab://interviews/%@", [self interviewAtIndexPath:indexPath].interviewId]);
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  [interviews release];
  [super dealloc];
}



@end

