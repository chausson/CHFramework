//
//  CommentaryApi.m
//  CommentaryModule
//
//  Created by 郭金涛 on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHCommentaryApi.h"

@implementation CHCommentaryApi{
   CHCommentaryModel *_model;
    NSString *_url;
    NSString *_identifier;
}
- (instancetype)initWithUrl:(NSString *)url identifier:(NSString *)identifier
{
    if (self = [super init]) {
        _url = url;
        _identifier = identifier;
    }
    return self;
}
-(NSString *)customUrl
{
    return [NSString stringWithFormat:@"%@/%@", _url, _identifier];
}

- (NSDictionary *)requestParameter{
    return @{@"offset":@(self.index)};
}

- (void)requestCompletionBeforeBlock{
    NSError *err ;
    _model = [[CHCommentaryModel alloc]initWithDictionary:self.response.responseJSONObject error:&err];
}
- (NSArray <CHCommentaryModelItems *>*)getItems{
    if (_model.code == 200) {
        return  _model.data.items?_model.data.items:nil;
    }else{
        return nil;
    }
}
@end
