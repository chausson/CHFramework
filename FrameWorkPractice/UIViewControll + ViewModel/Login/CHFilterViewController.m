//
//  CHFilterViewController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHFilterViewController.h"
#import "CHFilterRender.h"
@interface CHFilterViewController ()<CHFilterRenderDelegate>

@end

@implementation CHFilterViewController{
    CHFilterRender *_filter;
    UIView *_containerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _filter = [[CHFilterRender alloc]init];
    _filter.delegate = self;
    _filter.index = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray <NSString *>*)filterDataSource{
    return @[@"从远到近",@"从近到远",@"从价格低到价格高",@"从最低到最高",@"从最高到最低",@"从最贵到最便宜"];
}
- (IBAction)showFilter:(UIButton *)sender {
    NSLog(@"_filter Visable =%d",_filter.visable);
    [_filter showBelowWithView:self.sectionView animated:YES];
}
- (void)didSelectedViewWithIndex:(NSInteger)index{
    [_filter hidden:YES];
}
- (void)dealloc{
    
}
@end
