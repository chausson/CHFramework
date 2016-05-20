//
//  NetBaseService.m
//  FrameWorkPractice
//
//  Created by 李赐岩 on 15/11/9.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import "NetBaseService.h"
#import "AFNetworking.h"
@implementation NetBaseService

+(void)fetchPOSTHTTPMethodWithURL:(NSString *)url parameter:(NSDictionary *)parameters success:(success)successful failure:(failure)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (parameters == nil) {
        NSLog(@"%s parameters is nil", __PRETTY_FUNCTION__);
    }else if (url.length == 0){
        NSLog(@"%s url is nil ", __PRETTY_FUNCTION__);
        return;
    }
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successful(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

+(void)fetchGETHTTPMethodWithURL:(NSString *)url parameter:(NSDictionary *)parameters success:(success)successful failure:(failure)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (parameters == nil) {
        NSLog(@"%s parameters is nil",__PRETTY_FUNCTION__);
    }else if (url.length == 0){
        NSLog(@"%s url is nil", __PRETTY_FUNCTION__);
        return;
    }
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successful(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
    
}







@end
