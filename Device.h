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
  NSString *email;
  BOOL okToEmail;
}

@property(nonatomic,retain) NSNumber *deviceId;
@property(nonatomic,retain) NSString *token;
@property(nonatomic,retain) NSString *email;
@property(nonatomic) BOOL okToEmail;

+(BOOL)saveOnServer:(NSData *)tokenData;

@end