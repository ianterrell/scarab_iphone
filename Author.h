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

@property(retain) NSString *authorId;
@property(retain) NSString *name;
@property(retain) NSString *location;
@property(retain) NSString *bio;
@property(retain) NSString *photoUrl;

@property(retain) NSMutableSet *works;

#pragma mark Finders

+ (NSArray *)findAllInIssue:(Issue *)issue;
+ (Author *)authorWithId:(NSString *)authorId;

#pragma mark Helpers

- (NSString *)fullyQualifiedPhotoUrl;

@end
