//
//  AppDelegate.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "AppDelegate.h"

//_ Global End Points
#import "ITIGlobalEndPoints.h"

//__ Navigation Manager
#import "ITINavigationManager.h"

//__ Controllers
#import "ITIGeneralSystemNotificationViewController.h"
#import "ITISearchDetailViewController.h"

//__ Reachability
#import "Reachability.h"
#import "ITIReachability.h"

//__ Model
#import "ITIArtist.h"

@interface AppDelegate () <ITINavigationManagerRegisterDelegate>

//__ Declare Reachability, you no longer have a singleton but manage instances
@property (nonatomic, strong) Reachability *reachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureReachabilityNotification];
    //__ Listen for navigation notifications
    [ITINavigationManager shared].delegate = self;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - Reachability

- (void)configureReachabilityNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
}

- (void)handleNetworkChange:(NSNotification *)notice {
    if (![ITIReachability deviceHasReachability]) {
        [self showNoInternetConnectionView:YES];
        return;
    }
    
    [self showNoInternetConnectionView:NO];
}

#pragma mark - Navigation manager delegate methods

- (void)navigationManagerShowGeneralSystemNotification:(NSNotification *)notification {
    NSNumber *noInternetConnectionMode = notification.userInfo[kTAGNoInternetNotification];
    [self showGeneralSystemNotificationWithNoInternetConnectionMode:noInternetConnectionMode.boolValue];
}

- (void)navigationManagerShowSearchDetailViewNotification:(NSNotification *)notification {
    ITIArtist *artist = notification.userInfo[kTAGObject];
    [self showSearchDetailViewWithArtist:artist];
}

#pragma mark - Navigation helpers

- (void)showNoInternetConnectionView:(BOOL)showNoInternetConnection {
    UIViewController *selectedViewController = (UINavigationController *)[[UIApplication sharedApplication].windows objectAtIndex:0].rootViewController;
    if (!showNoInternetConnection && [selectedViewController.presentedViewController isKindOfClass:[ITIGeneralSystemNotificationViewController class]]) {
        [selectedViewController.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:ITIReloadInternetNotification object:self userInfo:@{kTAGNoInternetNotification : @(YES)}];
        }];
        return;
    }
    
    if (!showNoInternetConnection || (showNoInternetConnection && [selectedViewController.presentedViewController isKindOfClass:[ITIGeneralSystemNotificationViewController class]])) {
        return;
    }
    
    [self showGeneralSystemNotificationWithNoInternetConnectionMode:YES];
}

- (void)showGeneralSystemNotificationWithNoInternetConnectionMode:(BOOL)noInternetNotificationMode {
    ITIGeneralSystemNotificationViewController *main = (ITIGeneralSystemNotificationViewController *)[self selectViewControllerForGeneralSystemNotificationView];
    main.noInternetConnectionMode = noInternetNotificationMode;
    main.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    main.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    UIViewController *viewController = (UINavigationController *)[[UIApplication sharedApplication].windows objectAtIndex:0].rootViewController;
    if (viewController.childViewControllers) {
        [[viewController.childViewControllers lastObject] presentViewController:main animated:YES completion:nil];
    }
    [self.window makeKeyAndVisible];
}

- (void)showSearchDetailViewWithArtist:(ITIArtist *)artist {
    ITISearchDetailViewController *main = (ITISearchDetailViewController *)[self selectViewControllerForSearchDetailView];
    main.artist = artist;
    main.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    main.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    UINavigationController *viewController = (UINavigationController *)[[UIApplication sharedApplication].windows objectAtIndex:0].rootViewController;
    if ([viewController respondsToSelector:@selector(pushViewController:animated:)]) {
        [viewController pushViewController:main animated:YES];
    }
    [self.window makeKeyAndVisible];
}

#pragma mark - Navigation view selection methods

- (UIViewController *)selectViewControllerForGeneralSystemNotificationView {
    //__ Initial Storyboard
    NSString *storyBoardIdentifier = ITINotificationsStoryboard;
    ITIGeneralSystemNotificationViewController *main = [[UIStoryboard storyboardWithName:storyBoardIdentifier bundle:nil] instantiateViewControllerWithIdentifier:@"ITIGeneralSystemNotificationViewController"];
    return main;
}

- (UIViewController *)selectViewControllerForSearchDetailView {
    //__ Initial Storyboard
    NSString *storyBoardIdentifier = ITIRootStoryboard;
    ITISearchDetailViewController *main = [[UIStoryboard storyboardWithName:storyBoardIdentifier bundle:nil] instantiateViewControllerWithIdentifier:@"ITISearchDetailViewController"];
    return main;
}

@end
