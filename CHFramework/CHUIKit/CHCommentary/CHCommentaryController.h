//
//  CHCommentaryController.h
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCommentaryViewModel.h"
#import "CHCommentaryTableView.h"
#import "CHCommentaryCell.h"
#import "CHInputkeyboard.h"
@interface CHCommentaryController : UIViewController<UITableViewDelegate, UITableViewDataSource, CHCommentarySendDelegate>
typedef void(^BefroeSendMessage)(); // 注释
+ (instancetype )new  __unavailable;
- (instancetype )init __unavailable;
/**
 *  @brief 初始化评论的ViewController
 *  @param  viewModel代表VM参数 LoginVC代表登录界面
 *  @return 返回实例对象
 */
- (instancetype )initWithViewModel:(CHCommentaryViewModel *)viewModel;

@property (nonatomic, strong)CHCommentaryViewModel *viewModel;

@property (nonatomic, strong)CHCommentaryTableView *tableView;

@property (nonatomic, strong)CHInputkeyboard *keyBofardView;

- (void)setBeforeSendMessageBlock:(BefroeSendMessage)beforeBlock;

@end
