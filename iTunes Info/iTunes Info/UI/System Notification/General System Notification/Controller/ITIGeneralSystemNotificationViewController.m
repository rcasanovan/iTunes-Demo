//
//  ITIGeneralSystemNotificationViewController.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/04/2017.
//  Copyright © 2017 Pijp. All rights reserved.
//

#import "ITIGeneralSystemNotificationViewController.h"
#import "ITIGeneralSystemNotificationView.h"

//__ Categories
#import "UIColor+iTunes_Info.h"

@interface ITIGeneralSystemNotificationViewController ()

@property (nonatomic, readonly) ITIGeneralSystemNotificationView *generalSystemNotificationView;

@end

@implementation ITIGeneralSystemNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.generalSystemNotificationView.viewModel = [self viewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters

/**
 View cast to ITIGeneralSystemNotificationView
 
 @since 1.0.0
 */
- (ITIGeneralSystemNotificationView *)generalSystemNotificationView {
    return (ITIGeneralSystemNotificationView *)self.view;
}

/**
 View model init
 
 @since 1.0.0
 */
- (ITIGeneralSystemNotificationViewModel *)viewModel {
    ITIGeneralSystemNotificationViewModel *viewModel = [ITIGeneralSystemNotificationViewModel new];
    //__ TO DO: In future, we can add diffetent types of information to this general system nofitication
    //__ like:
    //__ *system is down
    //__ *error response from server
    viewModel.systemStatusTitle = @"No internet connection.";
    viewModel.systemStatusSubtitle = @"iTunes info needs an internet conection.\nVerify and try again.";
    viewModel.systemStatusBackgroundColor = [UIColor whiteColor];
    viewModel.systemStatusTextColor = [UIColor iTunes_information_systemStatusBlackTextColor];
    return viewModel;
}

@end
