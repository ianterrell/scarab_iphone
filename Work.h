//
//  Work.h
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMManagedObject.h"

@interface Work : SMManagedObject {

}

@property(nonatomic,readonly) NSString *audioFileURL;
@property(nonatomic,readonly) NSString *audioFilePath;

- (BOOL)audioFileHasBeenDownloaded;
- (BOOL)isAudioFileBeingDownloaded;

@end
