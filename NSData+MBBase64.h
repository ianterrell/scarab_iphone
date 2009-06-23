//
//  NSData+MBBase64.h
//  Scarab
//
//  Created by Ian Terrell on 6/17/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;
@end
