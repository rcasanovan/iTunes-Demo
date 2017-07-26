//
//  ITISearchViewTableViewCell.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITISearchViewTableViewCell.h"

//__ View Model
#import "ITISearchViewObject.h"

@interface ITISearchViewTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel        *trackNameLabel;
@property (nonatomic, weak) IBOutlet UILabel        *artistNameLabel;
@property (nonatomic, weak) IBOutlet UILabel        *albumNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView    *artistImageView;

@end

@implementation ITISearchViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCell];
}

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.trackNameLabel.text = @"";
    self.artistNameLabel.text = @"";
    self.albumNameLabel.text = @"";
    self.artistImageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - DVATableViewCellProtocol

- (void)bindWithModel:(id<DVATableViewModelProtocol>)viewModel {
    ITISearchViewObject *model = (ITISearchViewObject *)viewModel;
    self.trackNameLabel.text = model.trackName;
    self.artistNameLabel.text = model.artistName;
    self.albumNameLabel.text = model.albumName;
    
    self.artistImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.artistImageView.clipsToBounds = YES;
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.artistUrlPhoto]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artistImageView.image = [UIImage imageWithData:data];
        });
    }] resume];
}

@end
