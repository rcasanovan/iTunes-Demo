//
//  UIColor+iTunes_Info.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "UIColor+iTunes_Info.h"

@implementation UIColor (iTunes_Info)

+ (UIColor *)iTunes_information_colorWithHex:(NSInteger)rgbValue {
    UIColor *color = [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
    return color;
}

+ (UIColor *)iTunes_information_searchSeparatorBackgroundColor {
    return [self iTunes_information_colorWithHex:0x818181];
}

+ (UIColor *)iTunes_information_textWhiteColor {
    return [self iTunes_information_colorWithHex:0xffffff];
}

+ (UIColor *)iTunes_information_systemStatusBlackTextColor {
    return [self iTunes_information_colorWithHex:0x000000];
}

+ (UIColor *)iTunes_information_systemStatusGrayTextColor {
    return [self iTunes_information_colorWithHex:0x9E9E9E];
}

@end
