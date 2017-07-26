//
//  ITIRequestManagerEndPoints.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 02/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#ifndef ITIRequestManagerEndPoints_h
#define ITIRequestManagerEndPoints_h

//__ Operations (GET, POST, PUT, etc)
static NSString * const kGETOperation = @"GET";

//__ Base URL
static NSString * const kBaseUrl = @"https://itunes.apple.com/";

//__ End points
static NSString * const kSearchEndPoint = @"search";

//__ API calls parameters
static NSString * const kSearchTerm             = @"term";
static NSString * const kResults                = @"results";
static NSString * const kArtistName             = @"artistName";
static NSString * const kAlbumName              = @"collectionName";
static NSString * const kTrackName              = @"trackName";
static NSString * const kTrackPrice             = @"trackPrice";
static NSString * const kPriceCurrency          = @"currency";
static NSString * const kReleaseDateTimestamp   = @"releaseDate";
static NSString * const kArtistUrlPhotoSmall    = @"artworkUrl30";
static NSString * const kArtistUrlPhotoMedium   = @"artworkUrl60";
static NSString * const kArtistUrlPhotoBig      = @"artworkUrl100";

#endif /* ITIRequestManagerEndPoints_h */
