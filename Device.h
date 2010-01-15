//
//  Device.h
//  Scarab
//
//  Created by Ian Terrell on 1/15/10.
//  Copyright 2010 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject {
  NSNumber *deviceId;
  NSString *token;
}

@property(nonatomic,retain) NSNumber *deviceId;
@property(nonatomic,retain) NSString *token;

+(BOOL)saveOnServer:(NSData *)tokenData;

@end