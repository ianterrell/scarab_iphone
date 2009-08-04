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
@property(retain) NSString *title;
@property(retain) NSString *subtitle;
@property(retain) NSString *previewDescription;
@property(retain) NSString *productIdentifier;
@property(retain) NSString *transactionIdentifier;
@property(retain) NSNumber *downloaded;

@property(retain) NSMutableSet *works;

+ (NSArray *)findAllSinceNumber:(NSNumber *)number;
+ (Issue *)issueWithNumber:(NSString *)number;
+ (Issue *)issueWithProductIdentifier:(NSString *)productIdentifier;

- (BOOL)hasBeenPurchased;
- (BOOL)hasBeenDownloaded;
- (TTView *)swatchView;
- (UIColor *)uiColor;

@end
