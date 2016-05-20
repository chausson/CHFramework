//
//  CHTabBarViewController.m
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CHTabBarViewController.h"
#import "CHBarItemViewModel.h"


@implementation CHTabBarViewController
- (instancetype)init{
    self = [super init];
    if (self) {
         _viewModel = [[CHTabBarViewModel alloc]init];
        NSMutableArray *viewcontrollerArray = [[NSMutableArray alloc] initWithCapacity:_viewModel.barItemViewModels.count];
        for (CHBarItemViewModel *item in self.viewModel.barItemViewModels) {
            Class class = NSClassFromString(item.uiviewControllName);
           [viewcontrollerArray addObject:[[class alloc] init]];
        }
        self.viewControllers = viewcontrollerArray;
        [self.tabBar setHidden:TRUE];
        [self layoutSubviews];
        @weakify(self);
        [RACObserve(self.viewModel, currentIndex) subscribeNext:^(NSNumber *index) {
            @strongify(self);
            NSInteger indexCount = [index integerValue];
            self.selectedIndex = indexCount;
            [self.customTabBar.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == indexCount) {
                    obj.selected = YES;
                }else{
                    obj.selected = NO;
                }
            }];
        }];
        RAC(self,title ) = RACObserve(self.viewModel, title);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
}
#pragma mark Layout
- (void)layoutSubviews{
    self.customTabBar = [[CHCustomTabBar alloc]initWithTabViewModel:self.viewModel];
    //实现模糊效果
    [self.view addSubview:self.customTabBar];
    [self.customTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.equalTo(@(self.viewModel.height));
    }];
    
}
#pragma mark Public

#pragma mark Private
- (void)selectedItem:(id)notification{
    UIButton *button = (UIButton *)[notification object];
    [self.viewModel selectItem:button.tag];

}
#pragma mark Override

#pragma mark UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
