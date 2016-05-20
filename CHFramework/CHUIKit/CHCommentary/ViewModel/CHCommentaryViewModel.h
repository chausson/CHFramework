//
//  CHCommentaryViewModel.h
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCommentaryCellVM.h"
@interface CHCommentaryViewModel : NSObject
@property (nonatomic, strong, readonly) NSMutableArray <CHCommentaryCellVM *> *cellViewModel;
@property (nonatomic, assign) BOOL isSignIn;//如果YES表示已经登录! 如果NO表示没有登录!
@property (nonatomic, assign) BOOL isFinish;//如果YES表示已经发送成功! 如果NO表示发送失败!
- (void)requestData;
- (void)requestFooterData;
- (void)sendWithMessage:(NSString *)message andCompletion:(void(^)(BOOL))completion;
/**
 *  @brief 初始化viewmodel
 *  @param token代表用户的token listUrl是评论列表地址 sendCommentUrl是发送评论地址 id代表接口参数
 *  @return 返回实例对象
 */
- (instancetype)initWithToken:(NSString *)token ListUrl:(NSString *)Listurl sendCommentUrl:(NSString *)sendCommentUrl identifier:(NSString *)identifier;
@end
