//
//  ITISearchDetailView.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITISearchDetailView.h"

//__ Global End Points
#import "ITIGlobalEndPoints.h"

@interface ITISearchDetailView ()

@property (nonatomic, weak) IBOutlet UILabel        *trackNameLabel;
@property (nonatomic, weak) IBOutlet UILabel        *albumNameLabel;
@property (nonatomic, weak) IBOutlet UILabel        *artistNameLabel;
@property (nonatomic, weak) IBOutlet UILabel        *releaseDateLabel;
@property (nonatomic, weak) IBOutlet UILabel        *priceLabel;
@property (nonatomic, weak) IBOutlet UIImageView    *artistImageView;
@property (nonatomic, weak) IBOutlet UIButton       *buyButton;

@end

@implementation ITISearchDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

/**
 Setup view
 
 @since 1.0.0
 */
- (void)setupView {
    self.artistImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.artistImageView.layer.borderWidth = 1.0;
    self.artistImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.artistImageView.layer.cornerRadius = self.artistImageView.frame.size.width / 2;
    self.artistImageView.clipsToBounds = YES;
    self.buyButton.layer.cornerRadius = 10.0;
    self.buyButton.layer.borderWidth = 1.0;
    self.buyButton.layer.borderColor = [[UIColor blueColor] CGColor];
    [self.buyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.buyButton.clipsToBounds = YES;
    [self.buyButton setBackgroundColor:[UIColor clearColor]];
    [self.buyButton setTitle:kBuyTitle forState:UIControlStateNormal];
}

#pragma mark - Setters

/**
 View model setter
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)setViewModel:(ITISearchDetailViewModel *)viewModel {
    _viewModel = viewModel;
    [self configureArtistInformationWithViewModel:viewModel];
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureArtistInformationWithViewModel:(ITISearchDetailViewModel *)viewModel {
    self.trackNameLabel.text = viewModel.trackName;
    self.albumNameLabel.text = viewModel.albumName;
    self.artistNameLabel.text = viewModel.artistName;
    self.releaseDateLabel.text = viewModel.releaseDate;
    self.priceLabel.text = viewModel.price;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:viewModel.artistUrlPhoto]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artistImageView.image = [UIImage imageWithData:data];
        });
    }] resume];
}

#pragma mark - User actions

- (IBAction)buyButtonPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchDetailViewDelegateBuy)]) {
        [self.delegate searchDetailViewDelegateBuy];
    }
}

@end

#pragma mark - ITISearchDetailViewModel implementation

@implementation ITISearchDetailViewModel

- (instancetype)init {
    if (self = [super init]) {
        _trackName = @"";
        _albumName = @"";
        _artistName = @"";
        _releaseDate = @"";
        _price = @"";
        _artistUrlPhoto = @"";
    }
    return self;
}

@end
