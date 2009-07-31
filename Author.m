//
//  Author.m
//  Scarab
//
//  Created by Ian Terrell on 7/30/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Author.h"


@implementation Author

@dynamic authorId;
@dynamic name;
@dynamic location;
@dynamic bio;
@dynamic photoUrl;

+ (Author *)authorWithId:(NSString *)authorId {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"authorId = %@", authorId]];
}

- (NSString *)fullyQualifiedPhotoUrl {
  // Site ends with /, partial URL starts with /
  NSMutableString *url = [NSMutableString stringWithString:[ObjectiveResourceConfig getSite]];
  int length = [url length];
  [url replaceCharactersInRange:NSMakeRange(length-1, 1) withString:self.photoUrl];
  return url;
}

@end

