//
//  ITISearchViewObject.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITISearchViewObject.h"

//__ Model
#import "ITIArtist.h"

//__ Cell
#import "ITISearchViewTableViewCell.h"

@implementation ITISearchViewObject

/**
 Init class

 @param artistUrlPhoto          artist url photo
 @param artistName              artist name
 @param albumName               album name
 @param trackName               track name
 
 @since 1.0.0
 */
- (instancetype)initWithArtistUrlPhoto:(NSString *)artistUrlPhoto
                            artistName:(NSString *)artistName
                             albumName:(NSString *)albumName
                             trackName:(NSString *)trackName {
    if (self = [super init]) {
        _artistUrlPhoto = artistUrlPhoto;
        _artistName = artistName;
        _albumName = albumName;
        _trackName = trackName;
    }
    
    return self;
}

/**
 Generate "view model" array
 
 @param artists model array

 @since 1.0.0
 */
+ (NSArray *)generateArrayOfObjectsWithArray:(NSArray *)artists {
    NSMutableArray *objectViewArtists = [NSMutableArray new];
    for (ITIArtist *eachArtist in artists) {
        [objectViewArtists addObject:[[ITISearchViewObject alloc] initWithArtistUrlPhoto:eachArtist.artistUrlPhotoMedium artistName:eachArtist.artistName albumName:eachArtist.albumName trackName:eachArtist.trackName]];
    }
    return [objectViewArtists copy];
}

#pragma mark - DVATableViewModelProtocol

- (NSString *)dva_cellIdentifier {
    return [ITISearchViewTableViewCell description];
}

@end
