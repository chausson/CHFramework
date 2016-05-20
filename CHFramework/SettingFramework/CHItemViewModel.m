//
//  CHItemViewModel.m
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "CHItemViewModel.h"

@implementation CHItemViewModel
- (void)action{
    if ([self.name isEqualToString:@"清除缓存"]) {
        NSLog(@"清除缓存");
    }else if([self.name isEqualToString:@"关于我们"]){
        NSLog(@"关于我们");
    }
}
@end
