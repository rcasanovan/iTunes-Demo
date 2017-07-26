//
//  ITISearchDetailView.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class      ITISearchDetailViewModel;
@protocol   ITISearchDetailViewDelegate;

@interface ITISearchDetailView : UIView

@property (strong, nonatomic) ITISearchDetailViewModel          *viewModel;
@property (weak, nonatomic) id  <ITISearchDetailViewDelegate>   delegate;
@end

#pragma mark - ViewModel

@interface ITISearchDetailViewModel : NSObject

@property (copy, nonatomic) NSString *trackName;
@property (copy, nonatomic) NSString *albumName;
@property (copy, nonatomic) NSString *artistName;
@property (copy, nonatomic) NSString *releaseDate;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *artistUrlPhoto;

@end

#pragma mark - ITISearchDetailViewDelegate

@protocol ITISearchDetailViewDelegate <NSObject>

- (void)searchDetailViewDelegateBuy;

@end
