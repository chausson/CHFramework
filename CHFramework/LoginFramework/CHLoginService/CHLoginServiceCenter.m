//
//  CHLoginServiceCenter.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "CHLoginServiceCenter.h"

@implementation CHLoginServiceCenter
+ (instancetype)shareInstance{
    static CHLoginServiceCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[CHLoginServiceCenter alloc]init];
        
    });
    return center;
}
- (void)loginAccount:(NSString *)account
            password:(NSString *)password
             urlPath:(NSString *)url
          successful:(void(^)(id result))successful
               error:(void(^)(NSError *error))failure{
    
 
    [[self assemblyMangaer] POST:url parameters:@{@"cellphone":account,
                                   @"password":password} progress:^(NSProgress * _Nonnull uploadProgress) {
                                   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       if (successful) {
                                           successful(responseObject);
                                       }
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       if (failure) {
                                           failure(error);
                                       }
                                   }];
}
- (void)regsterAccount:(NSString *)account
              password:(NSString *)password
             checkCode:(NSString *)checkCode
               urlPath:(NSString *)url
            successful:(void(^)(id result))successful
                 error:(void(^)(NSError *error))failure{
    [[self assemblyMangaer] POST:url parameters:@{@"cellphone":account,
                                                 @"password":password,
                                                 @"phoneCode":checkCode}  progress:^(NSProgress * _Nonnull uploadProgress) {
                                                     
                                                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                     if (successful) {
                                                         successful(responseObject);
                                                     }
                                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                     if (failure) {
                                                         failure(error);
                                                     }
                                                 }];
}
- (void)checkCodeWithTel:(NSString *)tel
              andUrlPath:(NSString *)url
              successful:(void(^)(id result))successful
                   error:(void(^)(NSError *error))failure{
    [[self assemblyMangaer] POST:url parameters:@{@"cellphone":tel} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successful) {
            successful(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)resetAccount:(NSString *)account
            password:(NSString *)password
           checkCode:(NSString *)checkCode
             urlPath:(NSString *)url
          successful:(void(^)(id result))successful
               error:(void(^)(NSError *error))failure{
    [[self assemblyMangaer] POST:url parameters:@{@"cellphone":account,
                                                  @"newPassword":password,
                                                  @"phoneCode":checkCode} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successful) {
            successful(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (AFHTTPSessionManager *)assemblyMangaer{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    return manager;
}
@end
