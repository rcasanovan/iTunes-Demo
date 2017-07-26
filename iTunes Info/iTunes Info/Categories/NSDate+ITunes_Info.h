//
//  NSDate+ITunes_Info.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ITunes_Info)

+ (instancetype)convertDateFromTimeStamp:(double)date;
+ (instancetype)convertDateFromyyyyMMddHHmmssStringDate:(NSString *)date;
+ (NSNumber *)getActuaDateLikeTimeStamp;
+ (NSNumber *)getDateLikeTimeStamp:(NSDate *)date;
- (NSString *)itunesInfo_StringddMMMMyyyyFromDate;

@end
