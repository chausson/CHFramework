//
//  ASNavigationController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/13.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "ASNavigator.h"
#import "ASNavigationController.h"

@interface ASNavigationController ()

@end

@implementation ASNavigationController
- (void)skipPageProtocol:(NSDictionary *)parameters{
    if (parameters ) {
        UIViewController <ASNavigatable>*VC = (UIViewController <ASNavigatable>*)self.topViewController;
        if ([VC respondsToSelector:@selector(skipPageProtocol:)]) {
            [VC skipPageProtocol:parameters];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//	return UIInterfaceOrientationMaskAll;
//}

#pragma mark 重载导航栏的返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }
} // 压栈时候创建自定义导航栏按钮
-(UIBarButtonItem*)customLeftBackButton{
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame=CGRectMake(0, 10, 50,50);
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
 //   [btn setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backItem;
} // 自定义导航栏按钮

-(void)popself
{
    [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
    
} // 出栈动画
@end
