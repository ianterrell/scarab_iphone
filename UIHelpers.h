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


+(TTImageView *)newRoundedImageNamed:(NSString *)imageName;
+(TTImageView *)newRoundedImageNamed:(NSString *)imageName withRect:(CGRect)rect andRadius:(CGFloat)radius;
+(void)addRoundedImageNamed:(NSString *)imageName toView:(UIView *)view;
+(void)addRoundedImageNamed:(NSString *)imageName toView:(UIView *)view withRect:(CGRect)rect andRadius:(CGFloat)radius;

@end
