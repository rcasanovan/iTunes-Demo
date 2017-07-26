//
//  ITISearchViewObject.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITISearchViewObject : NSObject

@property (copy, nonatomic, readonly) NSString  *artistUrlPhoto;
@property (copy, nonatomic, readonly) NSString  *artistName;
@property (copy, nonatomic, readonly) NSString  *albumName;
@property (copy, nonatomic, readonly) NSString  *trackName;

/**
 Generate "view model" array
 
 @param artists model array
 
 @since 1.0.0
 */
+ (NSArray *)generateArrayOfObjectsWithArray:(NSArray *)artists;

@end
