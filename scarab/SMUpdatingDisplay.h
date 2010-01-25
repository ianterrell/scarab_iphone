//
//  SMUpdatingDisplay.h
//  Scarab
//
//  Created by Ian Terrell on 8/17/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMUpdatingDisplay : NSObject {
  TTActivityLabel *loadingLabel;
  NSMutableArray *things;
}

@property(nonatomic,retain) TTActivityLabel *loadingLabel;
@property(nonatomic,retain) NSMutableArray *things;

+ (SMUpdatingDisplay *)sharedDisplay;
- (void)addCheckingFor:(NSString *)thing;
- (void)removeCheckingFor:(NSString *)thing;
- (BOOL)isCheckingFor:(NSString *)thing;
- (void)show;
- (void)hide;
- (NSString *)displayMessage;

@end
