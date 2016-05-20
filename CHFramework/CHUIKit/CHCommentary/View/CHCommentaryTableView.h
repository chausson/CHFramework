//
//  CHCommentaryTableView.h
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHCommentaryController;
@interface CHCommentaryTableView : UITableView
/**
 *  @brief  初始化表格API
 *  @param  controller预导入视图控制器
 *  @return 返回实例对象
 */
- (instancetype)initWithOwner:(CHCommentaryController <UITableViewDelegate,UITableViewDataSource>*)controller;
@end
