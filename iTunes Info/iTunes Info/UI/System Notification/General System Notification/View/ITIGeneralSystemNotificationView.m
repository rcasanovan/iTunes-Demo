//
//  ITIGeneralSystemNotificationView.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/04/2017.
//  Copyright © 2017 Pijp. All rights reserved.
//

#import "ITIGeneralSystemNotificationView.h"

//__ Categpories
#import "UIColor+iTunes_Info.h"

@interface ITIGeneralSystemNotificationView()

@property (nonatomic, weak) IBOutlet UILabel        *systemStatusTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel        *systemStatusSubtitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView    *systemStatusImageView;

@end

@implementation ITIGeneralSystemNotificationView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

/**
 Setup view
 
 @since 1.0.0
 */
- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    //__ TO DO: In future we can custom fonts for each label with a custom category (UIFont+iTunes_info)
    self.systemStatusTitleLabel.textColor = [UIColor iTunes_information_systemStatusBlackTextColor];
    self.systemStatusSubtitleLabel.textColor = [UIColor iTunes_information_systemStatusGrayTextColor];
}

#pragma mark - Setters

/**
 View model setter
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)setViewModel:(ITIGeneralSystemNotificationViewModel *)viewModel {
    _viewModel = viewModel;
    [self configureSystemInformationWithViewModel:viewModel];
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureSystemInformationWithViewModel:(ITIGeneralSystemNotificationViewModel *)viewModel {
    self.systemStatusTitleLabel.text = viewModel.systemStatusTitle;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:viewModel.systemStatusSubtitle];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineHeightMultiple:1.4];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, viewModel.systemStatusSubtitle.length)];
    self.systemStatusSubtitleLabel.attributedText = attrString;
    self.backgroundColor = viewModel.systemStatusBackgroundColor;
    self.systemStatusTitleLabel.textColor = viewModel.systemStatusTextColor;
}

@end

#pragma mark - ITIGeneralSystemNotificationViewModel implementation

@implementation ITIGeneralSystemNotificationViewModel

- (instancetype)init {
    if (self = [super init]) {
        _systemStatusTitle = @"";
        _systemStatusSubtitle = @"";
        _systemStatusBackgroundColor = [UIColor whiteColor];
        _systemStatusTextColor = [UIColor iTunes_information_systemStatusBlackTextColor];
    }
    return self;
}

@end
