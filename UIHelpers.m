//
//  UIHelpers.m
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "UIHelpers.h"

#define kDefaultRoundedImageRect CGRectMake(8,8,64,64)
#define kDefaultRoundedImageRadius 8.0f

@implementation UIHelpers

+(TTImageView *)newRoundedImageNamed:(NSString *)imageName {
  return [self newRoundedImageNamed:imageName withRect:kDefaultRoundedImageRect andRadius:kDefaultRoundedImageRadius];
}

+(TTImageView *)newRoundedImageNamed:(NSString *)imageName withRect:(CGRect)rect andRadius:(CGFloat)radius {
  TTImageView *imageView = [[TTImageView alloc] initWithFrame:rect];
  imageView.backgroundColor = [UIColor clearColor];
  imageView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:radius] next:[TTContentStyle styleWithNext:nil]]; 
  imageView.image = [UIImage imageNamed:imageName];
  return imageView;
}

+(void)addRoundedImageNamed:(NSString *)imageName toView:(UIView *)view {
  [self addRoundedImageNamed:imageName toView:view withRect:kDefaultRoundedImageRect andRadius:kDefaultRoundedImageRadius];
}

+(void)addRoundedImageNamed:(NSString *)imageName toView:(UIView *)view withRect:(CGRect)rect andRadius:(CGFloat)radius{
  TTImageView *imageView = [self newRoundedImageNamed:imageName withRect:rect andRadius:radius];
  [view addSubview:imageView];
  [imageView release];
}

@end
