//
//  CHBarItemViewModel.m
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import "CHBarItemViewModel.h"

@implementation CHBarItemViewModel
- (instancetype)initWithUnselectIcon:(NSString *)unselect
                        selectedIcon:(NSString *)selected
                    uiviewcontroller:(NSString *)uiviewcontroll
                               title:(NSString *)title{
    self = [super init];
    if (self) {
        _selectedIcon = selected;
        _unselectIcon = unselect;
        _uiviewControllName = uiviewcontroll;
        _title = title;
    }
    return self;
}
@end
