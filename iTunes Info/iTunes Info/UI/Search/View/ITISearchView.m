//
//  ITISearchView.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITISearchView.h"

//__ Global End Points
#import "ITIGlobalEndPoints.h"

//__ Categories
#import "UIColor+iTunes_Info.h"

//__ Tables
#import "DVAArrayDataSourceForTableView.h"
#import "DVAProtocolDataSourceForTableView.h"
#import "NSArray+DVATableViewModelDatasource.h"

//__ Cell
#import "ITISearchViewTableViewCell.h"

@interface ITISearchView () <UISearchBarDelegate, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIView         *searchContainerView;
@property (nonatomic, weak) IBOutlet UISearchBar    *storeSearchBar;
@property (nonatomic, weak) IBOutlet UIButton       *searchCancelButton;
@property (nonatomic, weak) IBOutlet UIImageView    *separatorImageView;
@property (nonatomic, weak) IBOutlet UILabel        *aboutInformationLabel;

//__ Results
@property (nonatomic, weak)     IBOutlet    UIView         *searchResultsContainerView;
@property (nonatomic, weak)     IBOutlet    UITableView    *searchResultsTableView;
@property (nonatomic,strong)                DVAProtocolDataSourceForTableView *searchDataSource;

//__ No results
@property (nonatomic, weak) IBOutlet UILabel *searchNoResultsLabel;

//__ Constraints
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cancelButtonWidthConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *searchBarRightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *searchViewContainterBottomConstraint;

@end

@implementation ITISearchView

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
    
    self.separatorImageView.backgroundColor = [UIColor iTunes_information_searchSeparatorBackgroundColor];
    self.separatorImageView.alpha = 0.2;
    
    [self.storeSearchBar setBackgroundColor:[UIColor clearColor]];
    [self.storeSearchBar setBarTintColor:[UIColor clearColor]];
    UIImage *searchFieldImage = [[UIImage imageNamed:@"SearchBarMask"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(7, 19, 7, 20)];
    [self.storeSearchBar setSearchFieldBackgroundImage:searchFieldImage forState:UIControlStateNormal];
    [self.storeSearchBar setImage:[UIImage imageNamed:@"SpotlightSearch"]
                 forSearchBarIcon:UISearchBarIconSearch
                            state:UIControlStateNormal];
    self.storeSearchBar.delegate = self;
    self.storeSearchBar.placeholder = @"Search artists";
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [self.storeSearchBar valueForKey:@"_searchField"];
    searchField.tintColor = [UIColor iTunes_information_textWhiteColor];
    // Change search bar text color
    searchField.textColor = [UIColor iTunes_information_textWhiteColor];
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor iTunes_information_textWhiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.storeSearchBar setImage:[UIImage imageNamed:@"SearchClear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    [self.storeSearchBar setImage:[UIImage imageNamed:@"SearchClear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    [self.searchCancelButton setBackgroundImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    [self.searchCancelButton setBackgroundImage:[UIImage imageNamed:@"CancelPress"] forState:UIControlStateSelected];
    
    [self showCancelButtonView:NO animated:NO];
    
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.searchResultsTableView.backgroundColor = [UIColor whiteColor];
    [self setupDataSource];
}

#pragma mark - Setters

/**
 View model setter
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)setViewModel:(ITISearchViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self configureVibrancyWithViewModel:viewModel];
    [self configureSearchBarWithViewModel:viewModel];
    [self configureCancelWithViewModel:viewModel];
    [self configureResultsWithViewModel:viewModel];
    [self configureResultsTableWithViewModel:viewModel];
    [self configureInformationWithViewModel:viewModel];
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureVibrancyWithViewModel:(ITISearchViewModel *)viewModel {
    if (viewModel.setupVibracy) {
        [self setupViewVibrancy];
        viewModel.setupVibracy = NO;
    }
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureSearchBarWithViewModel:(ITISearchViewModel *)viewModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!viewModel.activateSearch) {
            self.storeSearchBar.text = @"";
        }
    });
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureCancelWithViewModel:(ITISearchViewModel *)viewModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showCancelButtonView:viewModel.activateSearch animated:viewModel.activateSearch];
    });
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureResultsWithViewModel:(ITISearchViewModel *)viewModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.searchNoResultsLabel.text = viewModel.activateSearch && !viewModel.typedSearch ? kSuggestionsTitle : kNoResultsTitle;
        self.searchViewContainterBottomConstraint.constant = self.viewModel.keyboardHeight;
        self.searchResultsContainerView.hidden = !viewModel.activateSearch;
    });
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureResultsTableWithViewModel:(ITISearchViewModel *)viewModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.searchDataSource.viewModelDataSource = viewModel.searchResults;
        self.searchResultsTableView.hidden = !viewModel.searchResults.count;
        [self.searchResultsTableView reloadData];
    });
}

/**
 View model setter helper
 
 @param viewModel the new view model information
 
 @since 1.0.0
 */
- (void)configureInformationWithViewModel:(ITISearchViewModel *)viewModel {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.aboutInformationLabel.text = viewModel.aboutInformation;
    });
}

#pragma mark - Data source

/**
 Setup data source for results
 
 @since 1.0.0
 */
-(void)setupDataSource {
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:[ITISearchViewTableViewCell description] bundle:nil] forCellReuseIdentifier:[ITISearchViewTableViewCell description]];
    self.searchDataSource = [DVAProtocolDataSourceForTableView new];
    [self.searchDataSource setTitleHeader:kiTunesSuggestionsTitle ForSection:0];
    self.searchResultsTableView.dataSource = self.searchDataSource;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSeachResultsCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.storeSearchBar resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewDelegateSelectedSearchAtIndex:)]) {
        [self.delegate searchViewDelegateSelectedSearchAtIndex:indexPath.row];
    }
}

#pragma mark - Helpers

- (void)setupViewVibrancy {
    self.searchContainerView.backgroundColor = [UIColor clearColor];
    
    //__ Create blur effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //__ Create vibrancy effect
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    
    //__ Add blur to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.searchContainerView.frame;
    
    //__ Add vibrancy to yet another effect view
    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
    vibrantView.frame = self.searchContainerView.frame;
    
    //__ Add both effect views to the image view
    [self.searchContainerView addSubview:effectView];
    [self.searchContainerView addSubview:vibrantView];
    
    [self.searchContainerView sendSubviewToBack:effectView];
    [self.searchContainerView sendSubviewToBack:vibrantView];
    
    for (UIView *subview in [[self.storeSearchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview setAlpha:0.0];
            break;
        }
    }
}

- (void)showCancelButtonView:(BOOL)show animated:(BOOL)animated {
    CGFloat animateDuration = (animated) ? 0.25 : 0;
    self.cancelButtonWidthConstraint.constant = show ? 93.0 : 0.0;
    self.searchBarRightConstraint.constant = show ? 118.0 : 10.0;
    
    [UIView animateWithDuration: animateDuration animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - User Actions

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.storeSearchBar resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewDelegateCancelSelected)]) {
        [self.delegate searchViewDelegateCancelSelected];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewDelegateSearchWithSearchText:)]) {
        [self.delegate searchViewDelegateSearchWithSearchText:searchText];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewDelegateSearchSelected)]) {
        [self.delegate searchViewDelegateSearchSelected];
    }
    return YES;
}

@end

#pragma mark - ITISearchViewModel implementation

@implementation ITISearchViewModel

- (instancetype)init {
    if (self = [super init]) {
        _activateSearch = NO;
        _setupVibracy = NO;
        _typedSearch = NO;
        _searchResults = [NSArray new];
        _aboutInformation = @"";
        _keyboardHeight = 0.0;
    }
    return self;
}

@end
