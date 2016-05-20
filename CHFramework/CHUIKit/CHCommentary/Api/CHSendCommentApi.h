//
//  CHSendCommentApi.h
//  CommentaryModule
//
//  Created by 郭金涛 on 16/4/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <CHNetworking/CHNetworking.h>

@interface CHSendCommentApi : CHNetRequest
@property (nonatomic, assign)int parent;
@property (nonatomic, strong)NSString *content;
/**
 *  @brief 初始化评论列表API
 *  @param  url是接口地址 identifier代表接口参数 token代表用户token
 *  @return 返回实例对象
 */
- (instancetype)initWithUrl:(NSString *)url
                 identifier:(NSString *)identifier
                      token:(NSString *)token;

@end
