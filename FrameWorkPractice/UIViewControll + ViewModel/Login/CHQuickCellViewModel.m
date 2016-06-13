//
//  CHQuickCellViewModel.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/6/7.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHQuickCellViewModel.h"

@implementation CHQuickCellViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = [NSString stringWithFormat:@"测试 %u", (arc4random_uniform(26))];
    }
    return self;
}
@end
