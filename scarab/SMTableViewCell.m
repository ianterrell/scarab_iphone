//
//  SMTableViewCell.m
//  Scarab
//
//  Created by Ian Terrell on 6/11/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMTableViewCell.h"


@implementation SMTableViewCell

+(id)createNewCellFromNib { 
  NSArray* nibContents = [[NSBundle mainBundle] loadNibNamed:[self className] owner:self options:nil]; 
  NSEnumerator *nibEnumerator = [nibContents objectEnumerator]; 
  id cell = nil; 
  NSObject* nibItem = nil; 
  while ((nibItem = [nibEnumerator nextObject]) != nil) { 
    if ([nibItem isKindOfClass: [self class]]) { 
      cell = nibItem; 
      if ([[cell reuseIdentifier] isEqualToString:[self className]]) 
        break; // we have a winner 
      else 
      cell = nil; 
    } 
  } 
  return cell; 
}


@end
