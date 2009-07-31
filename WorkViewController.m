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
#import "Work.h"

#define kToolbarHeight 44
#define kToolbarAnimationDuration 0.3
#define kAudioTimerInterval 1
#define kSliderCooldown 0.2

@implementation WorkViewController

@synthesize workText, favoriteStar, authorImage;
@synthesize downloadingToolbarView, downloadingProgressView;
@synthesize playingToolbarView, playingToolbar, playingSlider, playingTimeElapsed, playingTimeRemaining, playButton, pauseButton;
@synthesize work, audioPlayer, audioUpdateTimer, wasPlaying, sliderCooledDown, sliderMoving;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // TODO: set up work with a real one on initialization and navigation push
  self.work = [[Work alloc] init];
  
  self.title = @"Issue 4";
  [self.workText loadHTMLString:@"<html><head><style>body { font-family: helvetica; }</style></head><body><p>In Ohio, my friend Lee becomes <br/>&nbsp;&nbsp;&nbsp;&nbsp;a monarch by smoking milkweed.<br/>I don’t suggest it. All the green stones <br/>&nbsp;&nbsp;&nbsp;&nbsp;in the creek point<br/>and laugh at his blond-tufted wings.</p><p>I ride fevers the way a hawk surfs a <br/>&nbsp;&nbsp;&nbsp;&nbsp;thermal: somewhere beneath me,<br/>I am a chattering delirium of martyrs. <br/>&nbsp;&nbsp;&nbsp;&nbsp;Staked, I learn this is my fault.<br/>Flaming, I learn I am blameless, that even <br/>&nbsp;&nbsp;&nbsp;&nbsp;good guys get burned.</p><p>People never run from a house fire: <br/>&nbsp;&nbsp;&nbsp;&nbsp;the fire trucks<br/>have sirens just to clear the way, <br/>&nbsp;&nbsp;&nbsp;&nbsp;but this is also<br/>jealousy: everyone wants to be first <br/>&nbsp;&nbsp;&nbsp;&nbsp;to feel the heat.</p><p>Ask the Cuyahoga, which burns and <br/>&nbsp;&nbsp;&nbsp;&nbsp;freezes in its season.<br/>Ask it what? I’ve forgotten, but I’m sure <br/>&nbsp;&nbsp;&nbsp;&nbsp;it began with<br/>a letter balanced on the tip of <br/>&nbsp;&nbsp;&nbsp;&nbsp;lamplight, or a kiss.</p><p>My father caught my mother <br/>&nbsp;&nbsp;&nbsp;&nbsp;with a campfire<br/>set with singing, oak leaves, <br/>&nbsp;&nbsp;&nbsp;&nbsp;the hissing of a Coleman stove.<br/>My mother caught my father with a <br/>&nbsp;&nbsp;&nbsp;&nbsp;honeycomb and a bear.</p><p>Brian, this is not wisdom. It is a string <br/>&nbsp;&nbsp;&nbsp;&nbsp;of cheap pearls,<br/>and everyone knows wisdom is a <br/>&nbsp;&nbsp;&nbsp;&nbsp;set of crossing<br/>white ankles in a library that cures <br/>&nbsp;&nbsp;&nbsp;&nbsp;your desire for books.</p><br/><i>Read by the author</i><br/><br/><br/><br/></body></html>" baseURL:nil];
    
  // Set author image with rounded corners
  [UIHelpers addRoundedImageNamed:@"brian.jpg" toView:self.view];
  
  // Set up byline
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
  label.font = [UIFont systemFontOfSize:14];
  label.text = [TTStyledText textFromXHTML:@"<i>A poem by <a href=\"scarab://author/1\">Brian Wilkins</a></i>" lineBreaks:NO URLs:YES];
  label.frame = CGRectMake(80, 52, 200, 23);
  label.textColor = RGBCOLOR(100,100,100);
  label.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
  label.backgroundColor = [UIColor clearColor];  
  [self.view addSubview:label];
  
  // Set up navigation to author view
  // TODO: Small chance the downloader will keep a copy of this around and so not dealloc and release -- how to handle here?
  //[[TTNavigationCenter defaultCenter] addView:@"author" target:self action:@selector(showAuthorViewWithObject:type:state:)];
  
  // Set up audio file
  
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
  static BOOL favorite = NO;
  if (favorite)
    [favoriteStar setImage:[UIImage imageNamed:@"star-empty.png"] forState:UIControlStateNormal];
  else
    [favoriteStar setImage:[UIImage imageNamed:@"star-full.png"] forState:UIControlStateNormal];
  favorite = !favorite;
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
  
//  [[TTNavigationCenter defaultCenter] removeView:@"author"];
  
  [favoriteStar release];
  [workText release];
  [authorImage release];
  
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
