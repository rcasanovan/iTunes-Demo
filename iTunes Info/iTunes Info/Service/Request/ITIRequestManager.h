//
//  ITIRequestManager.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A general completion block for network calls
 
 @param redirectURL the redirect URL
 @param json        a json returned from server (a dictionary or array)
 @param success     if success
 @param error       error object
 
 @since 1.0.0
 */
typedef void(^ITINetworkGeneralArrayCompletionBlock)(NSURL *redirectURL, NSArray *json, BOOL success, NSError *error);
typedef void(^ITINetworkGeneralDictionaryCompletionBlock)(NSURL *redirectURL, NSDictionary *json, BOOL success, NSError *error);

@interface ITIRequestManager : NSObject

/**
 Shared class object. It works in order to create a single instance (singleton) for class
 
 @since 1.0.0
 */
+ (instancetype)shared;

/**
 Request for search in iTunes
 
 @param term            seach term separated by "+" (michael+jackson, liam+gallagher)
 @param completionBlock a completion block for API call response

 @since 1.0.0
 */
- (void)requestManagerSearchWithTerm:(NSString *)term
                        oncompletion:(ITINetworkGeneralDictionaryCompletionBlock)completionBlock;

@end
