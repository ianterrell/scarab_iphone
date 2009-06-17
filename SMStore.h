//
//  SMStore.h
//  Scarab
//
//  Created by Ian Terrell on 6/16/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMStore : NSObject <SKProductsRequestDelegate> {

}

- (void) requestProductData;

@end
