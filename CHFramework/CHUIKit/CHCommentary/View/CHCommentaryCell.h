//
//  CHCommentaryCell.h
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCommentaryCellVM.h"
@interface CHCommentaryCell : UITableViewCell

@property(nonatomic,strong)UIButton *nameBtn;

@property(nonatomic,strong)UIImageView *headImage;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIButton *praiseBtn;

@property(nonatomic,strong)UIButton *vipSymbolBtn;

- (void )loadDataWithVM:(CHCommentaryCellVM *)model;
/**
 *  @brief 计算cell高度
 *  @param  cellViewModel
 *  @return 返回cell高度
 */
+ (CGFloat )calculateHengthViewModel:(CHCommentaryCellVM *)viewModel;
+ (NSString *)commentaryIdentifier;


@end