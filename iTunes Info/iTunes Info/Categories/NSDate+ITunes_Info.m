//
//  NSDate+ITunes_Info.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "NSDate+ITunes_Info.h"

@implementation NSDate (ITunes_Info)

#pragma mark - Date formatters

+ (NSDateFormatter *)itunesInfoddMMMMyyyyDateFormatter {
    static NSDateFormatter *itunesDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        itunesDateFormatter = [[NSDateFormatter alloc] init];
        itunesDateFormatter.dateFormat = @"dd MMMM yyyy";
        itunesDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es"];
        itunesDateFormatter.timeZone = [NSTimeZone systemTimeZone];
    });
    return itunesDateFormatter;
}

#pragma mark - Time formatters
+ (NSDateFormatter *)iTunesTimeFormatter {
    static NSDateFormatter *timeFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeFormatter = [[NSDateFormatter alloc] init];
        timeFormatter.dateFormat = @"HH':'mm";
        timeFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
        timeFormatter.timeZone = [NSTimeZone systemTimeZone];
    });
    return timeFormatter;
}

#pragma mark - convert timestamp to NSDate
+ (instancetype)convertDateFromTimeStamp:(double)date {
    return [NSDate dateWithTimeIntervalSince1970:(date)];
}

#pragma mark - convert string date to NSDate

+ (instancetype)convertDateFromyyyyMMddHHmmssStringDate:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    NSDate *dateFromString = [formatter dateFromString:date];
    return dateFromString;
}

#pragma mark - convert actual NSDate to timestamp
+ (NSNumber *)getActuaDateLikeTimeStamp {
    NSDate *actualDate = [NSDate date];
    NSTimeInterval timestamp = [actualDate timeIntervalSince1970];
    NSNumber *timestampNumber = @(timestamp);
    return @([timestampNumber intValue]);
}

#pragma mark - convert NSDate to timestamp
+ (NSNumber *)getDateLikeTimeStamp:(NSDate *)date {
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSNumber *timestampNumber = @(timestamp);
    return @([timestampNumber intValue]);
}

#pragma mark - Strings from Dates

- (NSString *)itunesInfo_StringddMMMMyyyyFromDate {
    NSString *date = [[NSDate itunesInfoddMMMMyyyyDateFormatter] stringFromDate:self];
    return [NSString stringWithFormat:@"%@",date];
}

@end
