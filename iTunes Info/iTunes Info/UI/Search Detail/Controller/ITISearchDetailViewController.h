//
//  ITISearchDetailViewController.h
//  iTunes Info
//
//  Created by Ricardo Casanova on 01/07/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import "ITIBaseViewController.h"

@class ITIArtist;

@interface ITISearchDetailViewController : ITIBaseViewController

/**
 Artist from master view
 
 @since 1.0.0
 */
@property (nonatomic, strong) ITIArtist *artist;

@end
