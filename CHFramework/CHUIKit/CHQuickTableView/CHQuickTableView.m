//
//  CHQuickTableView.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/6/6.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import "CHQuickTableView.h"
static NSString * cellIdentifier = @"QuickCell";
#pragma mark --CHTableView--
@interface CHTableView :UITableView

@end
@implementation CHTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

@end
//#pragma mark --CHTableViewCell--
//@interface CHTableViewCell :UITableViewCell
//
//
//@end
//@implementation CHTableViewCell
//
//@end
#pragma mark --CHQuickTableView--
@interface CHQuickTableView()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) CHTableView *mainTableView;
@end

@implementation CHQuickTableView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layout];
        [self addSubview:self.mainTableView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
        self.mainTableView.frame = frame;
        [self addSubview:self.mainTableView];
    }
    return self;
}
- (void)layout{
    self.cellHeight = 40.0f;
    self.backgroundColor = [UIColor clearColor];

}
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[CHTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.backgroundColor = [UIColor whiteColor];
    }
    return _mainTableView;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _mainTableView.backgroundColor = backgroundColor;
}
- (void)setDataSource:(UIViewController<CHQuickTableViewDataSource> *)dataSource{
    _dataSource = dataSource;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
}
#pragma mark TableView-dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(ch_TableViewDataSourceForViewModels)]){
        return [self.dataSource ch_TableViewDataSourceForViewModels].count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(ch_TableViewHeightForRows)]) {
        NSArray <NSNumber *>*heights = [self.dataSource ch_TableViewHeightForRows];

        return  [heights[indexPath.row] doubleValue];
    }else{
        return _cellHeight;
    }
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [self.dataSource ch_TableViewDisplayForCell];

    }
    if (_dataArray[indexPath.row]) {
        [cell setValue:_dataArray[indexPath.row] forKey:@"viewModel"];
    }

    return nil;
}
- (void)reloadData{
    [_mainTableView reloadData];
}
@end
