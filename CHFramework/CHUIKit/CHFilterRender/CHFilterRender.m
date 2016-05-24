//
//  CHFilterRender.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHFilterRender.h"
#pragma mark - CHFilterMark
@interface CHFilterMarkView:UIView
@property (nonatomic , strong) UIColor *tintColor;
@property (nonatomic, assign)  CGFloat borderWidth;
@property (nonatomic, assign)  CGFloat checkmarkLineWidth;

@property (nonatomic, strong)  UIColor *borderColor;
@property (nonatomic, strong)  UIColor *bodyColor;
@property (nonatomic, strong)  UIColor *checkmarkColor;
@end
@implementation CHFilterMarkView
- (instancetype)initWithColor:(UIColor *)color
                        frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = color;
        self.borderWidth = 1.0;
        self.checkmarkLineWidth = 1.2;
        self.hidden = YES;
        self.borderColor = [UIColor whiteColor];
        self.bodyColor = [UIColor colorWithRed:(20.0 / 255.0) green:(111.0 / 255.0) blue:(223.0 / 255.0) alpha:1.0];
        self.checkmarkColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    // Border
//    [self.borderColor setFill];
//    [[UIBezierPath bezierPathWithOvalInRect:self.bounds] fill];
    
    // Body
    [self.tintColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth)] fill];
    
    // Checkmark
    UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
    checkmarkPath.lineWidth = self.checkmarkLineWidth;
    
    [checkmarkPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (6.0 / 24.0), CGRectGetHeight(self.bounds) * (12.0 / 24.0))];
    [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (10.0 / 24.0), CGRectGetHeight(self.bounds) * (16.0 / 24.0))];
    [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (18.0 / 24.0), CGRectGetHeight(self.bounds) * (8.0 / 24.0))];
    
    [self.checkmarkColor setStroke];
    [checkmarkPath stroke];
}
@end
#define KCheckViewTAG 1001
#pragma mark - CHFilterRender
@class CHFilterMarkView;
@interface CHFilterRender()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *backgroundView;
@property (nonatomic , strong) UIView *containerView;
@property (nonatomic , assign) BOOL hasSelected;
@property (nonatomic , assign) CGFloat itemHeight;
@end
@implementation CHFilterRender
+ (instancetype)new{
    CHFilterRender *filter = [CHFilterRender new];
    if (filter) {
        [filter layoutUI];
    }
    return filter;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    _itemHeight = 40;
    _normalColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
    _selectedColor = [UIColor orangeColor];
    _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    _containerView.hidden = YES;
    _containerView.backgroundColor = [UIColor clearColor];
    _backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.3;
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.rowHeight = 40;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTap)];
    [_backgroundView addGestureRecognizer:tap];
    [_containerView addSubview:_backgroundView];
    [_containerView addSubview:_tableView];
}
- (UIView *)superView:(UIView *)view{
    if (view.superview == nil) {
        return view;
    }else{
        return [self superView:view.superview];
    }

}
- (void)showBelowWithView:(UIView *)view animated:(BOOL)animated{
    CGRect containerRect ;
    UIView *superView = [self superView:view];
//    if (view.superview) {
        containerRect =  CGRectMake(0, CGRectGetMaxY(view.frame), superView.frame.size.width,superView.frame.size.height-view.frame.size.height);
//    }else{
//        containerRect =  CGRectMake(0, CGRectGetMaxY(view.frame), view.frame.size.width,_filterHeight);
//
//    }
    [self showWithFrame:containerRect toView:view.superview animated:animated];


}
- (void)showWithFrame:(CGRect )frame
               toView:(UIView *)view
             animated:(BOOL)animated{
    [self.tableView reloadData];
    self.containerView.userInteractionEnabled = YES;
    CGRect containerRect = frame;
    CGRect tableRect;

    [view addSubview:self.containerView];
    self.containerView.hidden = NO;
    self.containerView.frame = containerRect;
    self.backgroundView.frame = self.containerView.bounds;
    self.tableView.frame = CGRectMake(0, 0, self.containerView.frame.size.width, 0);
    tableRect = _tableView.frame;
    if (_filterHeight == 0 && self.delegate) {
            tableRect.size.height = _itemHeight * [self.delegate filterDataSource].count;
    }else{
            tableRect.size.height = _filterHeight;
    }

    if (animated) {
        [UIView animateWithDuration:0.35f animations:^{
            self.tableView.frame = tableRect;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        self.tableView.frame = tableRect;
    }
    
    [self.containerView setNeedsLayout];
    [self.containerView setNeedsDisplay];
}

- (void)hiddenTap{
    [self hidden:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(shutDownFilterView)]) {
        [self.delegate performSelector:@selector(shutDownFilterView)];
    }

    
}
- (void)hidden:(BOOL)animated{

    @synchronized (self) {
        self.containerView.userInteractionEnabled = NO;
        CGRect tableRect = self.tableView.frame;
        tableRect.size.height = 0;
        if (animated) {
            [UIView animateWithDuration:0.35f animations:^{
                self.tableView.frame = tableRect;
            } completion:^(BOOL finished) {
                self.containerView.hidden = YES;
                [self.containerView removeFromSuperview];
            }];
        }else{
            self.containerView.hidden = YES;
            self.tableView.frame = tableRect;
            [self.containerView removeFromSuperview];
        }
    }

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray <NSString *>* dataSource  ;
    if (self.delegate) {
        dataSource = [self.delegate filterDataSource];
    }
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"filterCell";

    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
           CHFilterMarkView *checkView = [[CHFilterMarkView alloc]initWithColor:self.selectedColor
                                       frame:CGRectMake(self.containerView.frame.size.width-30, 10, 20, 20)];
        checkView.tag = KCheckViewTAG;
        [cell addSubview:checkView];
    }

    if (self.delegate) {

        NSArray <NSString *>* dataSource  = [self.delegate filterDataSource];
        cell.textLabel.text = dataSource[indexPath.row];
        if (_hasSelected && indexPath.row == self.index) {
            [cell viewWithTag:KCheckViewTAG].hidden = NO;
            cell.textLabel.textColor = self.selectedColor;
        }else{
            [cell viewWithTag:KCheckViewTAG].hidden = YES;
            cell.textLabel.textColor = self.normalColor;
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }

    return cell;
}
- (void)setIndex:(NSInteger)index{
    _index = index;
    _hasSelected = YES;
}
- (void)setFilterHeight:(CGFloat)filterHeight{
    _filterHeight = filterHeight;
    CGRect rect = _tableView.frame;
    rect.size.height = filterHeight;
    _tableView.frame = rect;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.index = indexPath.row;

    if ([self.delegate respondsToSelector:@selector(didSelectedViewWithIndex:)]) {
        [self.delegate didSelectedViewWithIndex:indexPath.row];
    }

    
}
- (BOOL)isVisable{
    return !self.containerView.hidden;
}
@end



