//
//  Footnote.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMManagedObject.h"

@class Interview;

@interface Footnote : SMManagedObject {

}

@property(retain) NSNumber *footnoteId;
@property(retain) NSNumber *interviewId;
@property(retain) NSString *body;

@property(retain) Interview *interview;

+ (NSArray *)findAllInInterview:(Interview *)interview;
+ (Footnote *)footnoteWithId:(NSNumber *)footnoteId;

@end
