//
//  ITISearchDetailViewController.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITISearchDetailViewController.h"
#import "ITISearchDetailView.h"

//__ Global End Points
#import "ITIGlobalEndPoints.h"

//__ Categories
#import "NSDate+ITunes_Info.h"

//__ Model
#import "ITIArtist.h"

@interface ITISearchDetailViewController () <ITISearchDetailViewDelegate>

@property (nonatomic, readonly) ITISearchDetailView *searchDetailView;

@end

@implementation ITISearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchDetailView.delegate = self;
    self.searchDetailView.viewModel = [self viewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters

/**
 View cast to ITISearchDetailView
 
 @since 1.0.0
 */
- (ITISearchDetailView *)searchDetailView {
    return (ITISearchDetailView *)self.view;
}

/**
 View model init
 
 @since 1.0.0
 */
- (ITISearchDetailViewModel *)viewModel {
    ITISearchDetailViewModel *viewModel = [ITISearchDetailViewModel new];
    viewModel.trackName = self.artist.trackName;
    viewModel.albumName = self.artist.albumName;
    viewModel.artistName = self.artist.artistName;
    NSDate *releaseDate = [NSDate convertDateFromTimeStamp:self.artist.releaseDateTimestamp.doubleValue];
    viewModel.releaseDate = [releaseDate itunesInfo_StringddMMMMyyyyFromDate];
    viewModel.price = [NSString stringWithFormat:@"%@ %@", self.artist.trackPrice, self.artist.priceCurrency];
    viewModel.artistUrlPhoto = self.artist.artistUrlPhotoBig;
    return viewModel;
}

#pragma mark - Helpers

/**
 Buy product
 
 @since 1.0.0
 */
- (void)buyProduct {
    [self showSimpleAlertWithText:kYouCanNotBuyMessage];
}

#pragma mark - ITISearchDetailViewDelegate

- (void)searchDetailViewDelegateBuy {
    [self buyProduct];
}

@end
