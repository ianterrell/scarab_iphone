//
//  Feedback.h
//  Scarab
//
//  Created by Ian Terrell on 8/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Feedback : NSObject {
  NSNumber *feedbackId;
  NSString *text;
}

@property(nonatomic,retain) NSNumber *feedbackId;
@property(nonatomic,retain) NSString *text;

@end
