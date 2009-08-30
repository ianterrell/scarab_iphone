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

+(TTImageView *)newRoundedImageNamed:(NSString *)imageName orURL:(NSString *)URL withRect:(CGRect)rect andRadius:(CGFloat)radius {
  TTImageView *imageView = [[TTImageView alloc] initWithFrame:rect];
  imageView.backgroundColor = [UIColor clearColor];
  imageView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:radius] next:[TTContentStyle styleWithNext:nil]]; 
  if (imageName != nil)
    imageView.image = [UIImage imageNamed:imageName];
  else
    imageView.URL = URL;
  return imageView;
}

+(void)addRoundedImageNamed:(NSString *)imageName orURL:(NSString *)URL toView:(UIView *)view withRect:(CGRect)rect andRadius:(CGFloat)radius{
  TTImageView *imageView = [self newRoundedImageNamed:imageName orURL:URL withRect:rect andRadius:radius];
  [view addSubview:imageView];
  [imageView release];
}

#pragma mark Image Views

+(TTImageView *)newRoundedImageNamed:(NSString *)imageName {
  return [self newRoundedImageNamed:imageName orURL:nil withRect:kDefaultRoundedImageRect andRadius:kDefaultRoundedImageRadius];
}

+(TTImageView *)newRoundedImageWithURL:(NSString *)URL {
  return [self newRoundedImageNamed:nil orURL:URL withRect:kDefaultRoundedImageRect andRadius:kDefaultRoundedImageRadius];
}

#pragma mark Helpers

+(void)addRoundedImageNamed:(NSString *)imageName toView:(UIView *)view {
  [self addRoundedImageNamed:imageName orURL:nil toView:view withRect:kDefaultRoundedImageRect andRadius:kDefaultRoundedImageRadius];
}

+(void)addRoundedImageWithURL:(NSString *)URL toView:(UIView *)view {
  [self addRoundedImageNamed:nil orURL:URL toView:view withRect:kDefaultRoundedImageRect andRadius:kDefaultRoundedImageRadius];
}

+ (void)addCopy:(NSString *)copy toScrollView:(UIScrollView *)scrollView {
  TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:CGRectZero] autorelease];
  label.font = [UIFont systemFontOfSize:14];
  label.text = [TTStyledText textFromXHTML:copy lineBreaks:YES URLs:YES];
  label.frame = CGRectMake(0, 0, 320, 283);
  label.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
  label.backgroundColor = [UIColor clearColor];  
  [label sizeToFit];
  [scrollView addSubview:label];
  scrollView.contentSize = CGSizeMake(scrollView.width, label.height);
}


@end
