//
//  ASNavigator.h
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/13.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class ASNavigator;
@protocol ASNavigatable <NSObject>


@optional

/**
 * @brief 返回视图控制器带参协议
 */
- (void)popControllerWithParameters:(NSDictionary *)parameters;

/**
 * @brief 压入视图控制器带参协议
 */
- (void)skipPageProtocol:(NSDictionary *)parameters;

@end
@interface ASNavigator : NSObject
/**
 * @brief 初始化对象
 */
+ (instancetype)shareModalCenter;

/**
 * @brief 根据内存地址获取视图控制器
 */
- (__kindof UIViewController *)fetchVCWithMemoryPath:(NSString *)memory;
/**
 * @brief 获取当前视图控制器
 */
- (__kindof UIViewController *)fetchCurrentViewController;
/**
 * @brief 使用前必须先设置根视图控制器
 */
- (__kindof UINavigationController *)innerWithHome:(UIViewController *)homeViewController;

- (void)popToViewController:(UIViewController *)controller isAnimation:(BOOL)animation;

- (void)popFormerlyViewControllerWithAnimation:(BOOL)animation;

- (void)popHomeViewControllerWithAnimation:(BOOL)animation
                                completion:(void(^)())finish;

- (void)popRootViewController:(BOOL)animaition;

- (void)pushViewController:(UIViewController <ASNavigatable>*)controller
                parameters:(NSDictionary *)parameter
               isAnimation:(BOOL)animation;

- (void)presentViewController:(UIViewController <ASNavigatable>*)controller
                   parameters:(NSDictionary *)parameter
                  isAnimation:(BOOL)animation
                   completion:(void(^)())finish;
/**
 * @brief 替换当前控制器
 */
- (void)changeCurrentViewController:(UIViewController *)controller isAnimation:(BOOL)animation;

- (void)dismissCurrentModalViewControlleAnimation:(BOOL)animation
                                       completion:(void(^)())finish;
@end
