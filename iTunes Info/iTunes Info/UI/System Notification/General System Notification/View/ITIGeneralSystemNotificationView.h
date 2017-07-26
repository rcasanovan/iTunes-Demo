//
//  ITIGeneralSystemNotificationView.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/04/2017.
//  Copyright © 2017 Pijp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITIGeneralSystemNotificationViewModel;

@interface ITIGeneralSystemNotificationView : UIView

@property (strong, nonatomic) ITIGeneralSystemNotificationViewModel *viewModel;

@end

#pragma mark - ViewModel

@interface ITIGeneralSystemNotificationViewModel : NSObject

@property (copy, nonatomic) NSString    *systemStatusTitle;
@property (copy, nonatomic) NSString    *systemStatusSubtitle;
@property (copy, nonatomic) UIColor     *systemStatusBackgroundColor;
@property (copy, nonatomic) UIColor     *systemStatusTextColor;

@end
