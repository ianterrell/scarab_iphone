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
@dynamic productIdentifier;
@dynamic transactionIdentifier;

+(NSArray *)findAllSinceNumber:(NSNumber *)issueNumber {
  // htp://server/issues/since/:number.xml
  NSString *issuesSincePath = [NSString stringWithFormat:@"%@%@/since/%d%@",
                              [self getRemoteSite],
                              [self getRemoteCollectionName],
                              [issueNumber intValue],
                              [self getRemoteProtocolExtension]];
  Response *response = [Connection get:issuesSincePath];
	return [self performSelector:[self getRemoteParseDataMethod] withObject:response.body];
}

+(Issue *)issueWithProductIdentifier:(NSString *)productIdentifier {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"productIdentifier = %@", productIdentifier]];
}

+(Issue *)issueWithNumber:(NSString *)number {
  return [self fetchFirstWithPredicate:[NSPredicate predicateWithFormat:@"number = %@", number]];
}

-(TTView *)swatchView {
  TTStyle *style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
    [TTSolidFillStyle styleWithColor:[self uiColor] next:
    [TTSolidBorderStyle styleWithColor:RGBCOLOR(160, 160, 160) width:1 next:nil]]];
  TTView* view = [[[TTView alloc] initWithFrame:CGRectMake(8,8,64,64)] autorelease];
  view.backgroundColor = [UIColor clearColor];
  view.style = style;
  return view;
}

-(UIColor *)uiColor {
  NSString *hexColor = [NSString stringWithFormat:@"0x%@", self.color];
  int i;
  sscanf([hexColor UTF8String], "%x", &i);
  return UIColorFromRGB(i);
}

@end
