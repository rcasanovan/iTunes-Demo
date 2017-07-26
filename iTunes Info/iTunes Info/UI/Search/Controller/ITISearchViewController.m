//
//  ITISearchViewController.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITISearchViewController.h"
#import "ITISearchView.h"

//__ Global End Points
#import "ITIGlobalEndPoints.h"

//__ Provider
#import "ITIiTunesProvider.h"

//__ View Model
#import "ITISearchViewObject.h"

//__ Model
#import "ITIArtist.h"

@interface ITISearchViewController () <ITISearchViewDelegate>

@property (nonatomic, readonly) ITISearchView *searchView;

@property (nonatomic, strong) ITIiTunesProvider *itunesProvider;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation ITISearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchView.delegate = self;
    self.searchView.viewModel = [self viewModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters

/**
 View cast to ITISearchView
 
 @since 1.0.0
 */
- (ITISearchView *)searchView {
    return (ITISearchView *)self.view;
}

/**
 Init iTunes Provider object
 
 @since 1.0.0
 */
- (ITIiTunesProvider *)itunesProvider {
    if (!_itunesProvider) {
        _itunesProvider = [ITIiTunesProvider new];
    }
    return _itunesProvider;
}

/**
 View model init
 
 @since 1.0.0
 */
- (ITISearchViewModel *)viewModel {
    ITISearchViewModel *viewModel = [ITISearchViewModel new];
    viewModel.setupVibracy = YES;
    viewModel.aboutInformation = kAboutInformation;
    return viewModel;
}

#pragma mark - Notifications

/**
 Notification to catch the keyboard appear
 
 @param aNotification the parameter notification
 
 @since 1.0.0
 */
- (void)keyboardWillBeAppear:(NSNotification *)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    ITISearchViewModel *viewModel = self.searchView.viewModel;
    viewModel.keyboardHeight = kbSize.height;
    self.searchView.viewModel = viewModel;
}

/**
 Notification to catch the keyboard disappear
 
 @param aNotification the parameter notification
 
 @since 1.0.0
 */
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    ITISearchViewModel *viewModel = self.searchView.viewModel;
    viewModel.keyboardHeight = 0.0;
    self.searchView.viewModel = viewModel;
}

#pragma mark - Helpers

/**
 Activate search
 -Reset the results
 -User is no typing
 
 @since 1.0.0
 */
- (void)activateSearch {
    ITISearchViewModel *viewModel = self.searchView.viewModel;
    viewModel.activateSearch = YES;
    self.searchResults = [NSArray new];
    viewModel.searchResults = [ITISearchViewObject generateArrayOfObjectsWithArray:self.searchResults];
    viewModel.typedSearch = NO;
    self.searchView.viewModel = viewModel;
}

/**
 Cancel search
 -Search is not activa
 -Reset the results
 
 @since 1.0.0
 */
- (void)cancelSearch {
    ITISearchViewModel *viewModel = self.searchView.viewModel;
    viewModel.activateSearch = NO;
    self.searchResults = [NSArray new];
    viewModel.searchResults = [ITISearchViewObject generateArrayOfObjectsWithArray:self.searchResults];
    self.searchView.viewModel = viewModel;
}

/**
 Reset search
 -User is no typing
 -Reset the results
 
 @since 1.0.0
 */
- (void)resetSearch {
    ITISearchViewModel *viewModel = self.searchView.viewModel;
    viewModel.typedSearch = NO;
    viewModel.searchResults = [NSArray new];
    self.searchView.viewModel = viewModel;
}

/**
 Apply search into iTunes with search term
 
 @param term search term
 
 @since 1.0.0
 */
- (void)applySearchWithTerm:(NSString *)term {
    if ([term isEqualToString:@""]) {
        [self resetSearch];
        return;
    }
    [self searchArtistWithTerm:term];
}

/**
 Prepare term for search
 
 @param term search term
 
 TO DO: In future, we need to change this method in order to manage multiple spaces in seach (liam      gallagher)
 
 @since 1.0.0
 */
- (NSString *)prepareTerm:(NSString *)term {
    return [term stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

/**
 Process selected artist at index
 
 @param index selected index
 
 @since 1.0.0
 */
- (void)processArtistSelectedAtIndex:(NSInteger)index {
    //__ Is index out of raange? -> do nothing
    if (index < 0 || index >= self.searchResults.count) {
        return;
    }
    
    ITIArtist *artistSelected = [self.searchResults objectAtIndex:index];
    //__ artistSelected exists? -> We need to notify "hey! show the search detail view" with kTAGObject (artistSelected))
    if (artistSelected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ITIShowSearchDetailNotification object:self userInfo:@{kTAGObject : artistSelected}];
    }
}

#pragma mark - Provider

/**
 Search artist with term
 
 @param term search term
 
 @since 1.0.0
 */
- (void)searchArtistWithTerm:(NSString *)term {
    //__ We should get a weak reference to view controller in order to avoid memory problems into the block
    __weak ITISearchViewController *weakSelf = self;
    [self.itunesProvider iTunesProviderSearchWithTerm:[self prepareTerm:term] oncompletion:^(NSArray *results, NSInteger errorCode, NSString *errorMessage) {
        @autoreleasepool {
            //__ Get the strong reference
            __strong ITISearchViewController *strongSelf = weakSelf;
            
            //__ No internet connection? -> We need to notify "hey! show the general system notification view" with kTAGNoInternetNotification mode (@YES)
            if (errorCode == ITIErrorCodeReachabilityCodeError) {
                [[NSNotificationCenter defaultCenter] postNotificationName:ITIShowGeneralSystemNotification object:self userInfo:@{kTAGNoInternetNotification : @YES}];
                return;
            }
            
            //__ Is something wrong? -> do somethind
            //__ TO DO: In future, we can show a popup in order to indicate what happen
            if (errorCode != ITIErrorNoErrorCode) {
                return;
            }
            
            //__ Save the results into local variable
            strongSelf.searchResults = results;
            //__ Prepare the view model injection
            ITISearchViewModel *viewModel = strongSelf.searchView.viewModel;
            viewModel.typedSearch = YES;
            viewModel.searchResults = [ITISearchViewObject generateArrayOfObjectsWithArray:strongSelf.searchResults];
            strongSelf.searchView.viewModel = viewModel;
        }
    }];
}

#pragma mark - ITISearchViewDelegate

- (void)searchViewDelegateSearchWithSearchText:(NSString *)searchText {
    //__ Wait 1.25 secs in order to apply search. This is in order to avoid "blinks" in search results view
    //__ TO DO: In future we can control user typing in oder to apply search after user finish typing
    double delayInSeconds = 1.25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self applySearchWithTerm:searchText];
    });
}

- (void)searchViewDelegateSearchSelected {
    [self activateSearch];
}

- (void)searchViewDelegateCancelSelected {
    [self cancelSearch];
}

- (void)searchViewDelegateSelectedSearchAtIndex:(NSInteger)index {
    [self processArtistSelectedAtIndex:index];
}

@end
