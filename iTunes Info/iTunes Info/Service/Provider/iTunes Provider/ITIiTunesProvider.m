//
//  ITIiTunesProvider.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIiTunesProvider.h"

//__ End Points
#import "ITIRequestManagerEndPoints.h"

//__ Categories
#import "NSDate+ITunes_Info.h"

//__ Model
#import "ITIArtist.h"

//__ Reachability
#import "ITIReachability.h"

@implementation ITIiTunesProvider

#pragma mark - Helpers

/**
 Transform the string date into timestamp
 
 @param stringDate the string date
 
 @since 1.0.0
 */
- (NSNumber *)getTimestampDateFromStringDate:(NSString *)stringDate {
    NSDate *date = [NSDate convertDateFromyyyyMMddHHmmssStringDate:stringDate];
    return [NSDate getDateLikeTimeStamp:date];
}

#pragma mark - Providers

/**
 Provider to search into iTunes
 
 @param term            seach term separated by "+" (michael+jackson, liam+gallagher)
 @param completionBlock a completion block for provider response
 
 @since 1.0.0
 */
- (void)iTunesProviderSearchWithTerm:(NSString *)term
                        oncompletion:(ITIiTunesProviderCompletion)completionBlock {
    //__ No internet connection? -> return ITIErrorCodeReachabilityCodeError
    if (![ITIReachability deviceHasReachability]) {
        completionBlock(nil, ITIErrorCodeReachabilityCodeError, nil);
        return;
    }
    
    [self.requestManager requestManagerSearchWithTerm:term oncompletion:^(NSURL *redirectURL, NSDictionary *json, BOOL success, NSError *error) {
        //__ Success? -> process json response
        if (success) {
            NSMutableArray *results = [NSMutableArray new];
            //__ Get the results and process each one
            NSArray *jsonResults = json[kResults];
            for (NSDictionary *eachResult in jsonResults) {
                NSString *artistName            = eachResult[kArtistName];
                NSString *albumName             = eachResult[kAlbumName];
                NSString *trackName             = eachResult[kTrackName];
                NSString *trackPrice            = eachResult[kTrackPrice];
                NSString *priceCurrency         = eachResult[kPriceCurrency];
                NSNumber *releaseDateTimestamp  = [self getTimestampDateFromStringDate:eachResult[kReleaseDateTimestamp]];
                NSString *artistUrlPhotoSmall   = eachResult[kArtistUrlPhotoSmall];
                NSString *artistUrlPhotoMedium  = eachResult[kArtistUrlPhotoMedium];
                NSString *artistUrlPhotoBig     = eachResult[kArtistUrlPhotoBig];
                //__ Transform the json data into an app model (ITIArtist)
                ITIArtist *artist = [[ITIArtist alloc] initWithArtistName:artistName
                                                                albumName:albumName
                                                                trackName:trackName
                                                               trackPrice:trackPrice
                                                            priceCurrency:priceCurrency
                                                     releaseDateTimestamp:releaseDateTimestamp
                                                      artistUrlPhotoSmall:artistUrlPhotoSmall
                                                     artistUrlPhotoMedium:artistUrlPhotoMedium
                                                        artistUrlPhotoBig:artistUrlPhotoBig];
                //__ Add it to the list
                [results addObject:artist];
            }
            //__ Return an inmutable copy for server response + ITIErrorNoErrorCode (everything is OK)
            completionBlock([results copy], ITIErrorNoErrorCode, nil);
        }
        else {
            //__ No response + ITIErrorCodeServerError (Server error)
            completionBlock(nil, ITIErrorCodeServerError, error.description);
        }
    }];
}

@end
