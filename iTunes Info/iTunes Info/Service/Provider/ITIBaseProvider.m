//
//  ITIBaseProvider.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIBaseProvider.h"

@implementation ITIBaseProvider

/**
 Init method
 
 @since 1.0.0
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        _requestManager = [ITIRequestManager shared];
    }
    return self;
}

@end
