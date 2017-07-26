//
//  ITIArtist.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIArtist.h"

@implementation ITIArtist

/**
 Init class
 
 @param artistName              artist name
 @param albumName               album name
 @param trackName               track name
 @param trackPrice              track price
 @param priceCurrency           track currency
 @param releaseDateTimestamp    release date (timestamp)
 @param artistUrlPhotoSmall     smal url photo
 @param artistUrlPhotoMedium    medium url photo
 @param artistUrlPhotoBig       big url photo
 
 @since 1.0.0
 */
- (instancetype)initWithArtistName:(NSString *)artistName
                         albumName:(NSString *)albumName
                         trackName:(NSString *)trackName
                        trackPrice:(NSString *)trackPrice
                     priceCurrency:(NSString *)priceCurrency
              releaseDateTimestamp:(NSNumber *)releaseDateTimestamp
               artistUrlPhotoSmall:(NSString *)artistUrlPhotoSmall
              artistUrlPhotoMedium:(NSString *)artistUrlPhotoMedium
                 artistUrlPhotoBig:(NSString *)artistUrlPhotoBig {
    self = [super self];
    if (self) {
        _artistName = artistName;
        _albumName = albumName;
        _trackName = trackName;
        _trackPrice = trackPrice;
        _priceCurrency = priceCurrency;
        _releaseDateTimestamp = releaseDateTimestamp;
        _artistUrlPhotoSmall = artistUrlPhotoSmall;
        _artistUrlPhotoMedium = artistUrlPhotoMedium;
        _artistUrlPhotoBig = artistUrlPhotoBig;
    }
    return self;
}

@end
