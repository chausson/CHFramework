//
//  CHSettingItemCell.m
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "CHSettingItemCell.h"

@implementation CHSettingItemCell

+ (NSString *)identifier{
    return @"CHSettingItemCell";
}
- (void)loadFromData:(CHItemViewModel *)viewModel{
    [super loadFromData:viewModel];
    if (viewModel.name) {
            _name.text = viewModel.name;
    }

    
}
@end
