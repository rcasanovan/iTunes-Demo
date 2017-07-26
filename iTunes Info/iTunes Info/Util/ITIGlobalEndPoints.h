//
//  ITIGlobalEndPoints.h
//  iTunes info
//
//  Created by Ricardo Casanova on 19/3/15.
//  Copyright (c) 2015 Develapps. All rights reserved.
//

#ifndef iTunes_info_ITIGlobalEndPoints_h
#define iTunes_info_ITIGlobalEndPoints_h

#pragma mark - Versions

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

static CGFloat    const kSeachResultsCellHeight = 80.0;

//__ Storyboards
static NSString * const ITIRootStoryboard          = @"Main";
static NSString * const ITINotificationsStoryboard = @"Notifications";

static NSString * const ITIShowGeneralSystemNotification    = @"ITIShowGeneralSystemNotification";
static NSString * const ITIShowSearchDetailNotification     = @"ITIShowSearchDetailNotification";
static NSString * const ITIReloadInternetNotification       = @"PIJPReloadInternetNotification";

static NSString * const kTAGNoInternetNotification          = @"kTAGNoInternetNotification";
static NSString * const kTAGObject                          = @"kTAGObject";

//__ App messagea
//__ TO DO: In future we can use location files in order to translate the app to different languages
static NSString * const kYouCanNotBuyMessage        = @"Come on!... This is just a sample. You can't buy any song here :P";
static NSString * const kCancelTitle                = @"Cancel";
static NSString * const kBuyTitle                   = @"Buy";
static NSString * const kAboutInformation           = @"iTunes Information\nCreated by: Ricardo Casanova N.\n@rcasanovan";
static NSString * const kSuggestionsTitle           = @"Suggestions";
static NSString * const kNoResultsTitle             = @"No results";
static NSString * const kiTunesSuggestionsTitle     = @"iTunes suggestions";

#endif
