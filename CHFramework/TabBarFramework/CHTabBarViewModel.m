//
//  CHTabBarViewModel.m
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//
#import "CHBarItemViewModel.h"
#import "CHTabBarModel.h"
#import "CHTabBarViewModel.h"
#define TABBAR_PLIST_FILENAME @"CHTabBar"
@implementation CHTabBarViewModel
- (instancetype)init{
    self = [super init ];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:TABBAR_PLIST_FILENAME ofType:@"plist"];
        NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSError *error;
        CHTabBarModel * model = [[CHTabBarModel alloc]initWithDictionary:dic error:&error];
        _title = model.title;
        _currentIndex = model.selectIndex;
        _color = model.color;
        _style = model.style;
        _height = model.height;
        NSMutableArray *array  = [[NSMutableArray alloc]initWithCapacity:model.tabBarItems.count];
        for (CHTabBarItemModel *tabbarModel in model.tabBarItems) {
            CHBarItemViewModel *itemViewModel = [[CHBarItemViewModel alloc]initWithUnselectIcon:tabbarModel.unselectedIconName selectedIcon:tabbarModel.selectedIconName uiviewcontroller:tabbarModel.UIViewControllName title:tabbarModel.tabbarTitle];
            [array addObject:itemViewModel];
        }
        _barItemViewModels = [array copy];
    }
    return self;
}
- (void)selectItem:(NSUInteger)index{
    CHBarItemViewModel *itemViewModel = _barItemViewModels[index];
    self.currentIndex = index;
    self.title = itemViewModel.title;
}
- (void)setTitle:(NSString *)title{
    _title = title;
}
@end
