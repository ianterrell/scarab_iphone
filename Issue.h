//
//  Issue.h
//  Scarab
//
//  Created by Ian Terrell on 6/10/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMManagedObject.h"

@interface Issue : SMManagedObject {

}

@property(retain) NSString *issueId;
@property(retain) NSString *color;
@property(retain) NSString *number;


+(NSArray *)findAllSinceNumber:(NSNumber *)issueNumber;

@end
