//
//  CommentaryApi.h
//  CommentaryModule
//
//  Created by 郭金涛 on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHNetRequest.h"
#import "CHCommentaryModel.h"

@interface CHCommentaryApi : CHNetRequest
@property (assign ,nonatomic) NSInteger index;
- (NSArray <CHCommentaryModelItems *>*)getItems;
/**
 *  @brief 初始化评论列表API
 *  @param  url是接口地址 identifier代表接口参数
 *  @return 返回实例对象
 */
- (instancetype)initWithUrl:(NSString *)url
                 identifier:(NSString *)identifier;

@end
