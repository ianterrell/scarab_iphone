//
//  UIHelpers.h
//  Scarab
//
//  Created by Ian Terrell on 6/12/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIHelpers : NSObject {

}


+ (TTImageView *)newRoundedImageNamed:(NSString *)imageName;
+ (TTImageView *)newRoundedImageWithURL:(NSString *)URL;
+ (void)addRoundedImageNamed:(NSString *)imageName toView:(UIView *)view;
+ (void)addRoundedImageWithURL:(NSString *)URL toView:(UIView *)view;

+ (void)addCopy:(NSString *)copy toScrollView:(UIScrollView *)scrollView;

@end
