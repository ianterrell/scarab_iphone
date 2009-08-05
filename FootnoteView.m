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

@implementation FootnoteView

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
  }
}
@end
