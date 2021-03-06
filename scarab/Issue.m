//
//  Issue.m
//  Scarab
//
//  Created by Ian Terrell on 6/10/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Issue.h"

@implementation Issue

@dynamic issueId;
@dynamic color;
@dynamic number;
@dynamic title;
@dynamic subtitle;
@dynamic previewDescription;
@dynamic productIdentifier;
@dynamic transactionIdentifier;
@dynamic downloaded;

@dynamic works;

#pragma mark Finders

+ (Issue *)issueWithProductIdentifier:(NSString *)productIdentifier {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"productIdentifier = %@", productIdentifier]];
}

+ (Issue *)issueWithNumber:(NSNumber *)number {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"number = %d", [number intValue]]];
}

#pragma mark Helpers

- (BOOL)hasBeenPurchased {
  return self.transactionIdentifier != nil;
}

- (BOOL)hasBeenDownloaded {
  return [self.downloaded boolValue];
}

- (TTView *)swatchView {
  TTStyle *style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
    [TTSolidFillStyle styleWithColor:[self uiColor] next:
    [TTSolidBorderStyle styleWithColor:RGBCOLOR(160, 160, 160) width:1 next:nil]]];
  TTView* view = [[[TTView alloc] initWithFrame:CGRectMake(8,8,64,64)] autorelease];
  view.backgroundColor = [UIColor clearColor];
  view.style = style;
  return view;
}

- (UIColor *)uiColor {
  NSString *hexColor = [NSString stringWithFormat:@"0x%@", self.color];
  int i;
  sscanf([hexColor UTF8String], "%x", &i);
  return UIColorFromRGB(i);
}

@end
