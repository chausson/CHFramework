//
//  CHTabBarViewController.h
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTabBarViewModel.h"
#import "CHCustomTabBar.h"

@interface CHTabBarViewController : UITabBarController
@property (strong ,nonatomic ) CHTabBarViewModel *viewModel;
@property (strong ,nonatomic ) CHCustomTabBar *customTabBar;

@end
