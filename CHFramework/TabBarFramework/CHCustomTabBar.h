//
//  CHCustomTabBar.h
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCustomTabBar : UIView
@property (nonatomic ,readonly) NSArray <UIButton *>*buttons;
- (instancetype)initWithTabViewModel:(CHTabBarViewModel *)tabViewModel;
- (instancetype)init __unavailable;
- (instancetype)initWithFrame:(CGRect)frame __unavailable;


@end
