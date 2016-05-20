//
//  CHSettingCell.m
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "CHSettingCell.h"

@implementation CHSettingCell

- (void)loadFromData:(CHItemViewModel *)viewModel{
    _viewModel = viewModel;
}
+ (NSString *)identifier{
    return @"setting";
}
@end
