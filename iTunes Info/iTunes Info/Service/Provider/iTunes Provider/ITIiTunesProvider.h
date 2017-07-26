//
//  ITIiTunesProvider.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIBaseProvider.h"

typedef void (^ITIiTunesProviderCompletion)(NSArray *results, NSInteger errorCode, NSString *errorMessage);

@interface ITIiTunesProvider : ITIBaseProvider

/**
 Provider to search into iTunes
 
 @param term            seach term separated by "+" (michael+jackson, liam+gallagher)
 @param completionBlock a completion block for provider response
 
 @since 1.0.0
 */
- (void)iTunesProviderSearchWithTerm:(NSString *)term
                        oncompletion:(ITIiTunesProviderCompletion)completionBlock;

@end
