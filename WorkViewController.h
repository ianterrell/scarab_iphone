//
//  WorkViewController.h
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Work;

@interface WorkViewController : UIViewController <AVAudioPlayerDelegate> {
  IBOutlet UILabel *titleLabel;
  IBOutlet UIScrollView *scrollView;
  IBOutlet UIButton *favoriteStar;
 
  IBOutlet UIView *downloadingToolbarView;
  IBOutlet UIProgressView *downloadingProgressView;
  
  // TODO: abstract out player stuff to helper class?
  IBOutlet UIView *playingToolbarView;
  IBOutlet UIToolbar *playingToolbar;
  IBOutlet UISlider *playingSlider;
  IBOutlet UILabel *playingTimeElapsed;
  IBOutlet UILabel *playingTimeRemaining;
  IBOutlet UIBarButtonItem *playButton;
  IBOutlet UIBarButtonItem *pauseButton;
    
  Work *work;
  AVAudioPlayer *audioPlayer;
  NSTimer *audioUpdateTimer;
  BOOL wasPlaying, sliderCooledDown, sliderMoving;
}

@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UIButton *favoriteStar;

@property(nonatomic,retain) UIView *downloadingToolbarView;
@property(nonatomic,retain) UIProgressView *downloadingProgressView;

@property(nonatomic,retain) UIView *playingToolbarView;
@property(nonatomic,retain) UIToolbar *playingToolbar;
@property(nonatomic,retain) UISlider *playingSlider;
@property(nonatomic,retain) UILabel *playingTimeElapsed;
@property(nonatomic,retain) UILabel *playingTimeRemaining;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *playButton;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *pauseButton;

@property(nonatomic,retain) Work *work;
@property(nonatomic,retain) AVAudioPlayer *audioPlayer;
@property(nonatomic,retain) NSTimer *audioUpdateTimer;
@property(nonatomic,assign) BOOL wasPlaying;
@property(nonatomic,assign) BOOL sliderCooledDown;
@property(nonatomic,assign) BOOL sliderMoving;

- (void)showAuthorViewWithObject:(id)object type:(id)type state:(id)state;
- (IBAction)toggleFavorite;

- (IBAction)playAudio;
- (IBAction)pauseAudio;
- (IBAction)sliderPause;
- (IBAction)sliderUpdate;
- (IBAction)sliderPlay;
- (void)updateAudioDisplay;

#pragma mark -
#pragma mark Audio Player

- (void)setUpAudioPlayer;

#pragma mark Callbacks

- (void)doneDownloadingAudioFile;

#pragma mark Toolbar Setup

- (void)animateToolbar:(UIView *)toolbar up:(BOOL)up;
- (void)showToolbar:(UIView *)toolbar;
- (void)hideToolbar:(UIView *)toolbar;


@end
