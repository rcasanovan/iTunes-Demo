//
//  ITIArtist.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITIArtist : NSObject

@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSString *trackPrice;
@property (nonatomic, strong) NSString *priceCurrency;
@property (nonatomic, strong) NSNumber *releaseDateTimestamp;
@property (nonatomic, strong) NSString *artistUrlPhotoSmall;
@property (nonatomic, strong) NSString *artistUrlPhotoMedium;
@property (nonatomic, strong) NSString *artistUrlPhotoBig;

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
                 artistUrlPhotoBig:(NSString *)artistUrlPhotoBig;

@end
