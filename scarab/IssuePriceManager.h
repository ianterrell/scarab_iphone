//
//  IssuePriceManager.h
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IssuePriceManager : NSObject {
  NSMutableDictionary *cache;
}

+ (IssuePriceManager *)defaultManager;

@end
