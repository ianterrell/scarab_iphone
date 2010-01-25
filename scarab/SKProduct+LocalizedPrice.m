//
//  SKProduct+LocalizedPrice.m
//  Scarab
//
//  Created by Ian Terrell on 6/23/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SKProduct+LocalizedPrice.h"


@implementation SKProduct (LocalizedPrice)

- (NSString *)localizedPrice {
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
  [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [numberFormatter setLocale:self.priceLocale];
  NSString *price = [numberFormatter stringFromNumber:self.price];
  [numberFormatter release];
  return price;
}

@end
