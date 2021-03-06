//
//  Author.h
//  Scarab
//
//  Created by Ian Terrell on 7/30/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMManagedObject.h"

@class Issue;

@interface Author : SMManagedObject {

}

@property(retain) NSNumber *authorId;
@property(retain) NSString *name;
@property(retain) NSString *location;
@property(retain) NSString *bio;
@property(retain) NSString *photoUrl;

@property(retain) NSMutableSet *works;
@property(retain) NSMutableSet *interviews;

#pragma mark Finders

+ (NSArray *)findAllInIssue:(Issue *)issue;
+ (Author *)authorWithId:(NSNumber *)authorId;

#pragma mark Helpers

- (NSString *)fullyQualifiedPhotoUrl;

@end
