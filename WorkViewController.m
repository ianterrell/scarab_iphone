//
//  WorkViewController.m
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "WorkViewController.h"
#import "AuthorViewController.h"
#import "SMWorkAudioDownloadManager.h"
#import "Issue.h"
#import "Work.h"
#import "Author.h"

#define kToolbarHeight 44
#define kToolbarAnimationDuration 0.3
#define kAudioTimerInterval 1
#define kSliderCooldown 0.2

@implementation WorkViewController

@synthesize titleLabel, scrollView, favoriteStar;
@synthesize downloadingToolbarView, downloadingProgressView;
@synthesize playingToolbarView, playingToolbar, playingSlider, playingTimeElapsed, playingTimeRemaining, playButton, pauseButton;
@synthesize work, audioPlayer, audioUpdateTimer, wasPlaying, sliderCooledDown, sliderMoving;

-(id)initWithId:(NSString *)workId {
  Author *a = nil;
  if (self = [super init]) {
    self.work = [Work workWithId:workId];
    if (self.work == nil) {
      // Not in database -- could be a free work!  Let's check on the server.
      Work *w = [Work findRemote:workId];
      if (w == nil) {
        // TODO: handle error
        debugLog(@"error!  couldn't find work on the server -- this could happen; handle!");
      } 
      else if ([w isFree]) { 
        // Let's grab the author, too, and link them.  Try the DB first, then fetch and save from the server.
        a = [Author authorWithId:w.authorId];
        if (a == nil) {        
          a = [Author findRemote:w.authorId];
          [AppDelegate.managedObjectContext insertObject:a];
        }
        [AppDelegate.managedObjectContext insertObject:w];
        w.author = a; 
        NSError *error = nil;
        [AppDelegate save:&error];
        if (error) {
          debugLog(@"Error saving new work:  %@", [error localizedDescription]);
          // TODO: FIXME BITCH WHAT DO I DO?
        }
        self.work = w;
      } else {
        TTAlertViewController *alert = [[TTAlertViewController alloc] initWithTitle:@"Oops!" message:@"This work has not been purchased or downloaded yet."];
        [alert addCancelButtonWithTitle:@"Cancel" URL:@"scarab://library"];
        [alert showInView:self.view animated:YES];
        [alert release];
      }
    }
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // TODO: test if this is sufficient
  if (self.work == nil)
    return;
  
  self.title = self.work.workType;

  // Title
  self.titleLabel.text = self.work.title;

  // Byline
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  label.font = [UIFont systemFontOfSize:14];
  label.text = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"<i>by <a href=\"scarab://authors/%@\">%@</a></i>", self.work.authorId, self.work.author.name] lineBreaks:NO URLs:YES]; 
  label.frame = CGRectMake(80, 52, 200, 23);
  label.textColor = RGBCOLOR(100,100,100);
  label.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
  label.backgroundColor = [UIColor clearColor];  
  [self.view addSubview:label];

  // Image
  [UIHelpers addRoundedImageWithURL:[self.work.author fullyQualifiedPhotoUrl] toView:self.view];
  
  // Favorite
  if ([self.work isFavorite])
    [favoriteStar setImage:[UIImage imageNamed:@"star-full.png"] forState:UIControlStateNormal];
  else
    [favoriteStar setImage:[UIImage imageNamed:@"star-empty.png"] forState:UIControlStateNormal];
  
  // Body
  [UIHelpers addCopy:[NSString stringWithFormat:@"%@\n\n\n<i>Read by %@</i>\n\n\n\n", self.work.body, self.work.reader] toScrollView:scrollView];

  // Audio
  if ([work audioFileHasBeenDownloaded]) {
    [self setUpAudioPlayer];
  } else {
    SMWorkAudioDownloadManager *downloadManager = [SMWorkAudioDownloadManager defaultManager];
    [self showToolbar:downloadingToolbarView];
    if ([work isAudioFileBeingDownloaded]) {
      [downloadManager updateController:self forDownloadForWork:work];
    } else {
      [downloadManager downloadAudioForWork:work controller:self];
    }
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  debugLog(@"WorkViewController View will disappear animated %d", animated);
  [self pauseAudio];
}

-(void)showAuthorViewWithObject:(id)object type:(id)type state:(id)state {
	AuthorViewController *authorViewController = [[AuthorViewController alloc] initWithNibName:@"AuthorViewController" bundle:nil];
	[self.navigationController pushViewController:authorViewController animated:YES];
	[authorViewController release];
}

#pragma mark -
#pragma mark Interface Actions

-(IBAction)toggleFavorite {
  if ([work isFavorite]) {
    [favoriteStar setImage:[UIImage imageNamed:@"star-empty.png"] forState:UIControlStateNormal];
    work.favorite = [NSNumber numberWithBool:NO];
  } else {
    [favoriteStar setImage:[UIImage imageNamed:@"star-full.png"] forState:UIControlStateNormal];
    work.favorite = [NSNumber numberWithBool:YES];
  }
  
  NSError *error = nil;
  [AppDelegate save:&error];
  if (error) {
    debugLog(@"Error saving favorite:  %@", [error localizedDescription]);
    // TODO: FIXME BITCH WHAT DO I DO?
  }
  
  [AppDelegate.favoritesViewController reloadFavorites];
}

#pragma mark -
#pragma mark Toolbar Animation

- (void)animateToolbar:(UIView *)toolbar up:(BOOL)up {
  CGRect frame = toolbar.frame;
  frame.origin.y = up ? frame.origin.y - kToolbarHeight : frame.origin.y + kToolbarHeight;
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:kToolbarAnimationDuration];
  toolbar.frame = frame;
  [UIView commitAnimations];
}

- (void)showToolbar:(UIView *)toolbar {
  [self animateToolbar:toolbar up:YES];
}

- (void)hideToolbar:(UIView *)toolbar {
  [self animateToolbar:toolbar up:NO];
}

#pragma mark -
#pragma mark Audio Player

- (void)setUpAudioPlayer {
  [self showToolbar:playingToolbarView];
  AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.work.audioFilePath] error:nil];
  player.delegate = self;
  [player prepareToPlay];
  self.audioPlayer = player;
  [player release];
  [self.playingToolbar setItems:[NSArray arrayWithObject:self.playButton] animated:YES];
  [self updateAudioDisplay];
  wasPlaying = NO;
  sliderCooledDown = YES;
}

- (void)cancelAudioUpdateTimer {
  [self.audioUpdateTimer invalidate];
}

- (void)setUpAudioUpdateTimer {
  [self cancelAudioUpdateTimer];
  self.audioUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:kAudioTimerInterval target:self selector:@selector(updateAudioDisplay) userInfo:nil repeats:YES];
}

- (IBAction)playAudio {
  debugLog(@"Playing audio");
  [self.playingToolbar setItems:[NSArray arrayWithObject:self.pauseButton] animated:YES];
  [self.audioPlayer play];
  [self setUpAudioUpdateTimer];
}

- (IBAction)pauseAudio {
  debugLog(@"Pausing audio");
  [self.playingToolbar setItems:[NSArray arrayWithObject:self.playButton] animated:YES];
  [self cancelAudioUpdateTimer];
  [self.audioPlayer pause];
}

- (IBAction)sliderPause {
  if (sliderCooledDown) {
    self.sliderMoving = YES;
    self.wasPlaying = audioPlayer.playing;
    debugLog(@"Slider pause");
    [self cancelAudioUpdateTimer];
    debugLog(@"was playing? %d, %d", wasPlaying, audioPlayer.playing);
    [audioPlayer pause];
  }
}

- (IBAction)sliderUpdate {
  if (sliderCooledDown && sliderMoving) {
    debugLog(@"Slider update");
    audioPlayer.currentTime = self.playingSlider.value * audioPlayer.duration;
    [self updateAudioDisplay];
  }
}

- (IBAction)sliderPlay {
  if (sliderCooledDown) {
    debugLog(@"Slider play");
    debugLog(@"was playing? %d, %d", wasPlaying, audioPlayer.playing);
    if (wasPlaying) {
      [self setUpAudioUpdateTimer];
      [audioPlayer play];
    }
    self.sliderMoving = NO;
    self.sliderCooledDown = NO;
    [NSTimer scheduledTimerWithTimeInterval:kSliderCooldown target:self selector:@selector(cooldownSlider) userInfo:nil repeats:NO];
  }
}

- (void)cooldownSlider {
  debugLog(@"cooling down slider");
  self.sliderCooledDown = YES;
}

- (void)updateAudioDisplay {  
  debugLog(@"Updating display...");
  self.playingSlider.value = audioPlayer.currentTime / audioPlayer.duration;
  self.playingTimeRemaining.text = [NSString stringWithFormat:@"-%@",[StringUtils timeStringFromSeconds:(audioPlayer.duration - audioPlayer.currentTime)]];
  self.playingTimeElapsed.text = [StringUtils timeStringFromSeconds:self.audioPlayer.currentTime];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)success {
  if (!audioPlayer.currentTime) {
    [self updateAudioDisplay];
    [self pauseAudio];
  }
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
  [self pauseAudio];
}

#pragma mark -
#pragma mark Callbacks

- (void)doneDownloadingAudioFile {
  [self hideToolbar:downloadingToolbarView];
  [self performSelector:@selector(setUpAudioPlayer) withObject:nil afterDelay:kToolbarAnimationDuration];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  debugLog(@"deallocing WorkViewController");
  
  [favoriteStar release];
  [titleLabel release];
  [scrollView release];
  
  [downloadingToolbarView release];
  [downloadingProgressView release];
  
  [playingToolbarView release];
  [playingToolbar release];
  [playingSlider release];
  [playingTimeElapsed release];
  [playingTimeRemaining release];
  [playButton release];
  [pauseButton release];
  
  [work release];
  [self cancelAudioUpdateTimer];
  [audioPlayer release];
  
  [super dealloc];
}


@end
