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

@property(retain) NSNumber *issueId;
@property(retain) NSString *color;
@property(retain) NSNumber *number;
@property(retain) NSString *title;
@property(retain) NSString *subtitle;
@property(retain) NSString *previewDescription;
@property(retain) NSString *productIdentifier;
@property(retain) NSString *transactionIdentifier;
@property(retain) NSNumber *downloaded;

@property(retain) NSMutableSet *works;

+ (Issue *)issueWithNumber:(NSNumber *)number;
+ (Issue *)issueWithProductIdentifier:(NSString *)productIdentifier;

- (BOOL)hasBeenPurchased;
- (BOOL)hasBeenDownloaded;
- (TTView *)swatchView;
- (UIColor *)uiColor;

@end
