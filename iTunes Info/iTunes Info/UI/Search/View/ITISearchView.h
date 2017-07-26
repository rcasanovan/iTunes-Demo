//
//  ITISearchView.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class      ITISearchViewModel;
@protocol   ITISearchViewDelegate;

@interface ITISearchView : UIView

@property (strong, nonatomic) ITISearchViewModel            *viewModel;
@property (weak, nonatomic) id  <ITISearchViewDelegate>     delegate;

@end

#pragma mark - ViewModel

@interface ITISearchViewModel : NSObject

@property (nonatomic)       BOOL        activateSearch;
@property (nonatomic)       BOOL        setupVibracy;
@property (nonatomic)       BOOL        typedSearch;
@property (copy, nonatomic) NSArray     *searchResults;
@property (copy, nonatomic) NSString    *aboutInformation;
@property (nonatomic)       CGFloat     keyboardHeight;

@end

#pragma mark - ITISearchViewDelegate

@protocol ITISearchViewDelegate <NSObject>

- (void)searchViewDelegateSearchWithSearchText:(NSString *)searchText;
- (void)searchViewDelegateSearchSelected;
- (void)searchViewDelegateCancelSelected;
- (void)searchViewDelegateSelectedSearchAtIndex:(NSInteger)index;

@end
