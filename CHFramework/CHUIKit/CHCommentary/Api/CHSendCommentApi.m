//
//  CHSendCommentApi.m
//  CommentaryModule
//
//  Created by 郭金涛 on 16/4/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHSendCommentApi.h"

@implementation CHSendCommentApi{
    NSString *_url;
    NSString *_identifier;
    NSString *_token;
}
- (instancetype)initWithUrl:(NSString *)url identifier:(NSString *)identifier token:(NSString *)token
{
    self = [super init];
    if (self) {
        _url = url;
        _identifier = identifier;
        _token = token;
    }
    return self;
}

-(NSString *)customUrl
{
    return _url;
}
- (CHRequestMethod)requestMethod
{
    return CHRequestMethodPost;
}
- (NSDictionary *)requestParameter
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_identifier forKey:@"parent"];
    [params setObject:self.content forKey:@"content"];
    return params;
}
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *token = [NSString stringWithFormat:@"_MCH_AT=%@", _token];
    [dic setObject:token forKey:@"cookie"];
    return dic;
}
@end
