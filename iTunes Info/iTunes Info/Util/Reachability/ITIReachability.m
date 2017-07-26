//
//  ITIReachability.m
//  iTunes info
//
//  Created by Ricardo Casanova on 12/6/15.
//  Copyright (c) 2015 Pijp. All rights reserved.
//

#import "ITIReachability.h"

//__ UIKit
#import <UIKit/UIKit.h>

//__ Global Ebd Points
#import "ITIGlobalEndPoints.h"

#import "Reachability.h"

@implementation ITIReachability

+ (BOOL) deviceHasReachability {
    BOOL host_answer, internet_answer, wifi_answer;
    Reachability *hostReachability;
    Reachability *internetReachability;
    Reachability *wifiReachability;    
    
    //__ Change the host name here to change the server you want to monitor.
    NSString *remoteHostName = @"www.apple.com";
    
    hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [hostReachability startNotifier];
    host_answer = [ITIReachability validateAppReachibility:hostReachability];
    
    internetReachability = [Reachability reachabilityForInternetConnection];
    [internetReachability startNotifier];
    internet_answer = [ITIReachability validateAppReachibility:internetReachability];
    
    wifiReachability = [Reachability reachabilityForLocalWiFi];
    [wifiReachability startNotifier];
    wifi_answer = [ITIReachability validateAppReachibility:wifiReachability];
    
    if (internet_answer || host_answer || (SYSTEM_VERSION_LESS_THAN(@"10.0") && wifi_answer)) {
        return YES;
    }
    
    return NO;
}

+ (BOOL) validateAppReachibility:(Reachability *)reachability {
    BOOL answer;
        
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:        {
            answer = NO;
            break;
        }
        case ReachableViaWWAN:        {
            answer = YES;
            break;
        }
        case ReachableViaWiFi:        {
            answer = YES;
            break;
        }
    }
    
    return answer;
}

@end
