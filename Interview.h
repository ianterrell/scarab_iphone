//
//  Interview.h
//  Scarab
//
//  Created by Ian Terrell on 8/5/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMManagedObject.h"

@class Author;

@interface Interview : SMManagedObject {

}

@property(retain) NSNumber *interviewId;
@property(retain) NSNumber *number;
@property(retain) NSString *body;
@property(retain) NSString *date;
@property(retain) NSNumber *authorId;

@property(retain) Author *author;
@property(retain) NSMutableSet *footnotes;

+ (Interview *)interviewWithId:(NSNumber *)interviewId;

@end
