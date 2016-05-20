//
//  CHTabBarViewModel.h
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHTabBarViewModel : NSObject


@property (strong ,nonatomic ,readonly) NSArray *barItemViewModels;
@property (assign ,nonatomic ) NSUInteger currentIndex;
@property (copy ,nonatomic ,readonly) NSString *title;
@property (copy ,nonatomic ,readonly) NSString *style;
@property (copy ,nonatomic) NSString *color;
@property (assign ,nonatomic) NSInteger colorGreen;
@property (assign ,nonatomic) NSInteger colorYellow;
@property (assign ,nonatomic) NSInteger height;

/**
  * @brief 选择控制器
  */
- (void)selectItem:(NSUInteger )index;
@end
