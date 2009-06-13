//
//  ScarabStyleSheet.m
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "ScarabStyleSheet.h"

@implementation ScarabStyleSheet

- (TTStyle*)purchasebutton:(UIControlState)state {
  if (state == UIControlStateNormal) {
  return 
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
    [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
    [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0) blur:1 offset:CGSizeMake(0, 1) next:
    [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
                               color2:RGBCOLOR(216, 221, 231) next:
    [TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
    [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
    [TTTextStyle styleWithFont:nil color:TTSTYLEVAR(linkTextColor)
                 shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
                 shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
  } else if (state == UIControlStateHighlighted) {
    return 
      [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
      [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.9) blur:1 offset:CGSizeMake(0, 1) next:
      [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(225, 225, 225)
                                 color2:RGBCOLOR(196, 201, 221) next:
      [TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
      [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
      [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
                   shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
                   shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
  } else {
    return nil;
  }
}

- (TTStyle*)authorByline {
  return [TTTextStyle styleWithColor:RGBCOLOR(100,100,100) next:nil];
}

@end
