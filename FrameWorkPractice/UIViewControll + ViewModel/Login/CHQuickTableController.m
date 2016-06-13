//
//  CHQuickTableController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/6/7.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHQuickTableController.h"
#import "CHQuickTableView.h"
#import "CHQuickTableViewModel.h"
@interface CHQuickTableController()<CHQuickTableViewDataSource>
@property (nonatomic , strong) CHQuickTableViewModel *viewModel;
@end
@implementation CHQuickTableController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CHQuickTableView *tableView = [[CHQuickTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    tableView.backgroundColor = [UIColor blueColor];
    self.viewModel  = [[CHQuickTableViewModel alloc]init];
    tableView.cellHeight = 100;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSArray *)ch_TableViewDataSourceForViewModels{
    
    return self.viewModel.cellViewModel;
}

@end
