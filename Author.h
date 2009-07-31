//
//  Author.h
//  Scarab
//
//  Created by Ian Terrell on 7/30/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMManagedObject.h"

@interface Author : SMManagedObject {

}

@property(retain) NSString *authorId;
@property(retain) NSString *name;
@property(retain) NSString *location;
@property(retain) NSString *bio;
@property(retain) NSString *photoUrl;

+ (Author *)authorWithId:(NSString *)authorId;

- (NSString *)fullyQualifiedPhotoUrl;

@end
