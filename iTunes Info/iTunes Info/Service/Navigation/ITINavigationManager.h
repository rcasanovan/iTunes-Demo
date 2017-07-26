//
//  ITINavigationManager.h
//  iTunes info
//
//  Created by Ricardo Casanova on 17/04/16.
//  Copyright (c) 2016 Pijp Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ITINavigationManagerRegisterDelegate;

@interface ITINavigationManager : NSObject

+ (instancetype)shared;

@property (nonatomic, weak) id <ITINavigationManagerRegisterDelegate> delegate;

@end

@protocol ITINavigationManagerRegisterDelegate <NSObject>

@optional

/**
 Show general system notification
 
 @param notification notification parameters for navigation
 
 @since 1.0.0
 */
- (void)navigationManagerShowGeneralSystemNotification:(NSNotification *)notification;

/**
 Show search detail
 
 @param notification notification parameters for navigation
 
 @since 1.0.0
 */
- (void)navigationManagerShowSearchDetailViewNotification:(NSNotification *)notification;

@end
