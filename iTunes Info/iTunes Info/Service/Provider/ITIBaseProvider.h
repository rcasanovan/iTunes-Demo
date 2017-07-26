//
//  ITIBaseProvider.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

//__ Request
#import "ITIRequestManager.h"

/**
 Enum for each possible error code
 ITIErrorNoErrorCode                -> Everything OK
 ITIErrorCodeServerError            -> Server error
 ITIErrorCodeReachabilityCodeError  -> No internet connection error
 
 @since 1.0.0
 */
typedef NS_ENUM(NSUInteger, ITIErrorCode) {
    ITIErrorNoErrorCode                =  -1,
    ITIErrorCodeServerError            =  0,
    ITIErrorCodeReachabilityCodeError  =  1
};

@interface ITIBaseProvider : NSObject

/**
 request manager property (in order to call server)
 
 @since 1.0.0
 */
@property (strong, nonatomic) ITIRequestManager *requestManager;

@end
