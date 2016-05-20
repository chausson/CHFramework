//
//  CHTabBarModel.h
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class CHTabBarItemModel;
@protocol CHTabBarItemModel <NSObject>
@end
@interface CHTabBarItemModel : JSONModel
@property (copy ,nonatomic) NSString *UIViewControllName;
@property (copy ,nonatomic) NSString *unselectedIconName;
@property (copy ,nonatomic) NSString *selectedIconName;
@property (copy ,nonatomic) NSString <Optional>*tabbarTitle;
@end
@interface CHTabBarModel : JSONModel
@property (assign ,nonatomic) NSUInteger selectIndex;
@property (strong ,nonatomic) NSArray<CHTabBarItemModel> *tabBarItems;
@property (copy ,nonatomic) NSString <Optional>*title;
@property (copy ,nonatomic) NSString *color;
@property (assign ,nonatomic) NSInteger height;
@property (copy ,nonatomic) NSString <Optional>*style;

@end
