//
//  CHCommentaryController.m
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHCommentaryController.h"
#import "CHCommentaryTableView.h"
#import <ReactiveCocoa.h>
#import <MJRefresh/MJRefresh.h>

@implementation CHCommentaryController{
    BefroeSendMessage _block;
}
- (instancetype )initWithViewModel:(CHCommentaryViewModel *)viewModel{
    self = [super init];
    if (self) {
        self -> _viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.translucent = NO;
    //列表ViewModel
    NSAssert(self.viewModel != nil, @"%@ VM is nil ",[self class]);
    [self.viewModel requestData];
    self.keyBofardView = [[CHInputkeyboard alloc] initWithOwner:self];
    [self setupTableView];

    [self addSubview];
    [self blindViewModel];

}
#pragma mark Blind
- (void)blindViewModel
{
    @weakify(self)
    [RACObserve(self.viewModel, cellViewModel) subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];

}
#pragma mark Private
- (void)addSubview{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyBofardView];

}
- (void)setupTableView{
    self.tableView = [[CHCommentaryTableView alloc] initWithOwner:self];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel requestData];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel requestFooterData];
    }];
}

#pragma mark TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCommentaryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CHCommentaryCell commentaryIdentifier]];
    if (cell == nil) {
        cell = [[CHCommentaryCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[CHCommentaryCell commentaryIdentifier]];
    }
    [cell loadDataWithVM:[self.viewModel.cellViewModel objectAtIndex:indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.cellViewModel.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [CHCommentaryCell calculateHengthViewModel:[self.viewModel.cellViewModel objectAtIndex:indexPath.row]];
}
- (void)setBeforeSendMessageBlock:(BefroeSendMessage)beforeBlock{
    _block = beforeBlock;
    
}
- (void)pressSendBtn:(NSString *)text
{
    if (_block) {
        _block();
    }
    [self.viewModel sendWithMessage:text andCompletion:nil];

}
-(void)dealloc{
    
}




@end
