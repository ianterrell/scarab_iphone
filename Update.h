//
//  Update.h
//  Scarab
//
//  Created by Ian Terrell on 8/4/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMManagedObject.h"

@interface Update : SMManagedObject {

}

@property(retain) NSString *updateId;
@property(retain) NSString *number;
@property(retain) NSString *body;

+ (NSArray *)findAllSinceNumber:(NSNumber *)number;

@end
