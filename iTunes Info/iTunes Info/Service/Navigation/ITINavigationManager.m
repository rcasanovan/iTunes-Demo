//
//  ITINavigationManager.m
//  iTunes info
//
//  Created by Ricardo Casanova on 17/04/16.
//  Copyright (c) 2016 Pijp Technologies. All rights reserved.
//

#import "ITINavigationManager.h"

//__ Global End Points
#import "ITIGlobalEndPoints.h"

@interface ITINavigationManager ()

@property (strong, nonatomic) UIWindow *window;

@end

@implementation ITINavigationManager

/**
 Shared class object. It works in order to create a single instance (singleton) for class
 
 @since 1.0.0
 */
+ (instancetype)shared {
    static ITINavigationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ITINavigationManager alloc] initWithNotifications];
    });
    
    return sharedInstance;
}

/**
 Init with navigation notifications
 
 @since 1.0.0
 */
- (instancetype)initWithNotifications {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didShowGeneralSystemNotificationViewNotification:) name:ITIShowGeneralSystemNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didShowSearchDetailViewNotification:) name:ITIShowSearchDetailNotification object:nil];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 Show general system notification
 
 @param notification notification parameters for navigation
 
 @since 1.0.0
 */
- (void)didShowGeneralSystemNotificationViewNotification:(NSNotification *)notification {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationManagerShowGeneralSystemNotification:)]) {
        [self.delegate navigationManagerShowGeneralSystemNotification:notification];
    }
}

/**
 Show search detail
 
 @param notification notification parameters for navigation
 
 @since 1.0.0
 */
- (void)didShowSearchDetailViewNotification:(NSNotification *)notification {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationManagerShowSearchDetailViewNotification:)]) {
        [self.delegate navigationManagerShowSearchDetailViewNotification:notification];
    }
}

@end
