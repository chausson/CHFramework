//
//  ASNavigator.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/13.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASNavigator.h"
#import "ASNavigationController.h"
@interface ASNavigator()<UINavigationControllerDelegate>
@end
@implementation ASNavigator{
    ASNavigationController *_rootNaviViewController; // 根导航栏
    UIViewController *_currentViewController; // 当前视图控制器
    UIViewController *_currentModalViewController; //当前模块视图控制器
    NSMutableArray <UIViewController *>*_currentModalViewControllers; // 当前所有导航栏控制器
}
+ (instancetype)shareModalCenter{
    
    static ASNavigator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ASNavigator alloc]init];
        instance -> _currentModalViewControllers = [[NSMutableArray alloc]init];
    });
    
    return instance;
    
}
- (UIViewController *)currentModalNaviViewController{
    return _currentModalViewController;
}
- (UIViewController *)currentViewController{
    return _currentViewController;
}
- (__kindof UIViewController *)fetchCurrentViewController{
    return _currentViewController;
}
- (__kindof UIViewController *)currentModalViewController{
    
    return _currentModalViewController;
}
- (__kindof UINavigationController *)innerWithHome:(UIViewController *)homeViewController{

    if (homeViewController && !_rootNaviViewController) {
        _rootNaviViewController = [[ASNavigationController alloc]initWithRootViewController:homeViewController];
        _rootNaviViewController.delegate = self;
        _currentViewController = homeViewController;
        _currentModalViewController = _rootNaviViewController;
        [_currentModalViewControllers addObject:_rootNaviViewController];
        
    }
    return _rootNaviViewController;
}
- (void)popToViewController:(UIViewController *)controller isAnimation:(BOOL)animation{
    
}

- (void)popFormerlyViewControllerWithAnimation:(BOOL)animation{

        if ([self isUINavigationController:_currentModalViewController] && _currentModalViewController) {
            UINavigationController *navi =  (UINavigationController *) _currentModalViewController ;
    
            [navi popViewControllerAnimated:animation];
            
          
        }else{
            NSLog(@"非导航栏控制器");
        }
    
    
}

- (void)popHomeViewControllerWithAnimation:(BOOL)animation
                                completion:(void(^)())finish{


    if ([_currentModalViewController isKindOfClass:[_rootNaviViewController class]]) {
         [_rootNaviViewController popToRootViewControllerAnimated:animation];
    }else{
        [self dismissController:[_currentModalViewControllers lastObject] andAnimaition:animation];
    }
    _currentViewController = _rootNaviViewController.topViewController;
    if (finish) {
        finish();
    }
    
}
- (void)dismissController:(UIViewController *)controller andAnimaition:(BOOL)animation{


        [controller dismissViewControllerAnimated:animation completion:^{
            [_currentModalViewControllers removeLastObject];
            _currentModalViewController = [_currentModalViewControllers lastObject];
            if (_currentModalViewController != _rootNaviViewController) {
                [self dismissController:[_currentModalViewControllers lastObject] andAnimaition:animation];
            }else{
                [_rootNaviViewController popToRootViewControllerAnimated:animation];
            }
        }];


}
- (void)pushViewController:(UIViewController <ASNavigatable>*)controller
                parameters:(NSDictionary *)parameter
               isAnimation:(BOOL)animation{
    if (controller && [self isUINavigationController:_currentModalViewController] ) {
        _currentViewController = controller;
        if ([controller respondsToSelector:@selector(skipPageProtocol:)]) {
            [controller skipPageProtocol:parameter];
        }
        UINavigationController *navi = (UINavigationController *)_currentModalViewController;
        [navi pushViewController:controller animated:animation];

       
    }
}
- (void)presentViewController:(UIViewController <ASNavigatable>*)controller
                   parameters:(NSDictionary *)parameter
                  isAnimation:(BOOL)animation
                   completion:(void(^)())finish{
    if (_currentViewController) {
        if ([controller respondsToSelector:@selector(skipPageProtocol:)]) {
              [controller skipPageProtocol:parameter];
        }
       
    [_currentViewController presentViewController:controller animated:animation completion:^{
        if ([self isUINavigationController:controller]) {
            UINavigationController *navi =  (UINavigationController *) controller ;
            _currentViewController =  [navi topViewController];
        }else{
            _currentViewController = controller;
        }
        [_currentModalViewControllers addObject:controller];
        _currentModalViewController = controller;
        if (finish) {
            finish();
        }
        }];
    }
}
- (void)changeCurrentViewController:(UIViewController <ASNavigatable>*)controller isAnimation:(BOOL)animation{
    [[ASNavigator shareModalCenter]dismissCurrentModalViewControlleAnimation:NO completion:^{
        [[ASNavigator shareModalCenter]presentViewController:controller parameters:nil isAnimation:animation completion:nil];
    }];
}

- (void)dismissCurrentModalViewControlleAnimation:(BOOL)animation
                                       completion:(void(^)())finish{
    if (_currentModalViewController) {
            [_currentViewController dismissViewControllerAnimated:animation completion:^{
                [_currentModalViewControllers removeLastObject];
                _currentModalViewController = [_currentModalViewControllers lastObject];
                _currentViewController = _currentModalViewController;
                if (finish) {
                    finish();
                }
            }];
    }
    
}
- (void)popRootViewController:(BOOL)animaition{
    [_rootNaviViewController popToRootViewControllerAnimated:animaition];
}
- (__kindof UIViewController *)fetchVCWithMemoryPath:(NSString *)memory{
    for (UIViewController *controll in _currentModalViewControllers) {
        if ([self isUINavigationController:controll ]) {
            UINavigationController *navi =  (UINavigationController *) controll ;
            for ( UIViewController *vc in navi.viewControllers ) {
                if ([[NSString stringWithFormat:@"%p",vc] isEqualToString:memory]) {
                    return vc;
                }
            }
        }
    }

  
    return nil;
}
#pragma mark Delegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    _currentViewController = viewController;
}
- (BOOL)isUINavigationController:(UIViewController *)controller{
    
    if ([controller isKindOfClass:[UINavigationController class]]){
        return  YES;
    }else {
        return  NO;
    }
}

@end
