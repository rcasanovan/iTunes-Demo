//
//  ITIBaseViewController.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIBaseViewController.h"

//__ Global End Points
#import "ITIGlobalEndPoints.h"

@interface ITIBaseViewController ()

@end

@implementation ITIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Helpers

/**
 Show sample popup
 
 @param text message to show
 
 @since 1.0.0
 */
- (void)showSimpleAlertWithText:(NSString *)text {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:text
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:kCancelTitle
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
    
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
