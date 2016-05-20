//
//  CHSlideViewController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHSlideViewController.h"
#import "CHSlideView.h"
#import "CHSlideConfig.h"
#import "CHSlideCell.h"

@interface CHSlideViewController ()<CHSlideViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    CHSlideView * _slideView;
    NSArray *titles;
    NSArray *_testArray;
}
@end

@implementation CHSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客户端ScrollView重用";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars =NO;
    self.modalPresentationCapturesStatusBarAppearance =NO;
    self.navigationController.navigationBar.translucent =NO;
    
    titles = @[@"全部",
               @"正在进行",
               @"未通过",
               @"已完成"];
    
    _slideView = [[CHSlideView alloc]initWithFrame:CGRectMake(0, 0,
                                                              SCREEN_WIDTH_CHSLIDE,
                                                              SCREEN_HEIGHT_CHSLIDE-64)
                                         forTitles:titles];
    
    _slideView.tintColor = [UIColor blueColor];
    _slideView.contentViewColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    _slideView.delegate        = self;
    _slideView.widthGap = CHSCREEN_IPHONE_BELOW_6?35:50;
    
    _slideView.slideTitleViewTitleMin = 15.f;

    _slideView.tintColor = [UIColor orangeColor];
    [self.view addSubview:_slideView];
    
}

- (NSInteger)columnNumber{
    return titles.count;
}

- (CHSlideCell *)slideView:(CHSlideView *)slideView
         cellForRowAtIndex:(NSUInteger)index{
    
    CHSlideCell * cell = [slideView dequeueReusableCell];
    
    if (!cell) {
        cell = [[CHSlideCell alloc]initWithFrame:CGRectMake(0, 0, 320, 500)
                                           style:UITableViewStylePlain];
        cell.delegate   = self;
        cell.dataSource = self;
    }
    
    //    cell.backgroundColor = colors[index];
    
    
    return cell;
}
- (void)slideVisibleView:(CHSlideCell *)cell forIndex:(NSUInteger)index{
    
    NSLog(@"index :%@ ",@(index));
    [cell reloadData]; //刷新TableView
    //    NSLog(@"刷新数据");
}

- (void)slideViewInitiatedComplete:(CHSlideCell *)cell forIndex:(NSUInteger)index{
    
    //可以在这里做数据的预加载（缓存数据）
    NSLog(@"缓存数据 %@",@(index));
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell reloadData];
        
    });
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    cell.textLabel.text = [@(arc4random()%1000) stringValue];
    
    
    return cell;
}

@end
