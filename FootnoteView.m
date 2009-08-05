//
//  FootnoteView.m
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "FootnoteView.h"

#define HORIZ_SWIPE_DRAG_MAX  6
#define VERT_SWIPE_DRAG_MIN   20

#define kFootnoteHeightMin 50

@implementation FootnoteView

@synthesize interviewViewController, footnoteLabel;

- (id)init {
  if (self == [super init]) {
    UIColor* black = RGBCOLOR(158, 163, 172);
    TTShapeStyle *footnoteBox =  [TTShapeStyle styleWithShape:
      [TTRoundedRectangleShape shapeWithTopLeft:10 topRight:10 bottomRight:0 bottomLeft:0] next:
      [TTShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:5 offset:CGSizeMake(2, -2) next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0.25, 0.25, 0.25, 0.25) next:
      [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-0.25, -0.25, -0.25, -0.25) next:
      [TTSolidBorderStyle styleWithColor:black width:1 next:nil]]]]]];

    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.style = footnoteBox;
  }
  
  return self;
}

- (void)setTextFromXHTML:(NSString *)text {
  [footnoteLabel removeFromSuperview];
  
  TTStyledTextLabel* footnote = [[[TTStyledTextLabel alloc] initWithFrame:CGRectZero] autorelease];
  footnote.font = [UIFont systemFontOfSize:13];
  footnote.text = [TTStyledText textFromXHTML:text lineBreaks:YES URLs:YES];
  footnote.frame = CGRectMake(0, 0, 300, 283);
  footnote.contentInset = UIEdgeInsetsMake(15, 10, 5, 0);
  footnote.backgroundColor = [UIColor clearColor];
  footnote.userInteractionEnabled = YES;
  [footnote sizeToFit];
  
  debugLog(@"footnote is %.0f by %.0f", footnote.width, footnote.height);
  self.frame = CGRectMake(self.origin.x, self.origin.y, 320, footnote.height < kFootnoteHeightMin ? kFootnoteHeightMin : footnote.height);
  
  footnoteLabel = footnote;
  [self addSubview:footnoteLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  startTouchPosition = [[touches anyObject] locationInView:self];
}
 
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint currentTouchPosition = [[touches anyObject] locationInView:self];

  // If the swipe tracks correctly.
  if (fabsf(startTouchPosition.x - currentTouchPosition.x) <= HORIZ_SWIPE_DRAG_MAX &&
      fabsf(startTouchPosition.y - currentTouchPosition.y) >= VERT_SWIPE_DRAG_MIN && 
      startTouchPosition.y < currentTouchPosition.y) {
      // It appears to be a swipe.
    
    debugLog(@"I think we have a swipe down!");
    [interviewViewController hideFootnoteShowNext:NO];
  }
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  [footnoteLabel release];
  [super dealloc];
}

@end
