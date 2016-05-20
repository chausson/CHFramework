//
//  CHLoginServiceCenter.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHLoginServiceCenter : NSObject

+ (instancetype)shareInstance;
/*
 @brief 调用登录接口的服务
 */
- (void)loginAccount:(NSString *)account
            password:(NSString *)password
             urlPath:(NSString *)url
          successful:(void(^)(id result))successful
               error:(void(^)(NSError *error))failure;
/*
 @brief 调用注册接口的服务
 */
- (void)regsterAccount:(NSString *)account
              password:(NSString *)password
             checkCode:(NSString *)checkCode
               urlPath:(NSString *)url
            successful:(void(^)(id result))successful
                 error:(void(^)(NSError *error))failure;
/*
 @brief 调用验证码接口的服务
 */
- (void)checkCodeWithTel:(NSString *)tel
              andUrlPath:(NSString *)url
              successful:(void(^)(id result))successful
                   error:(void(^)(NSError *error))failure;
/*
 @brief 调用重设密码接口的服务
 */
- (void)resetAccount:(NSString *)account
            password:(NSString *)password
           checkCode:(NSString *)checkCode
             urlPath:(NSString *)url
          successful:(void(^)(id result))successful
               error:(void(^)(NSError *error))failure;

@end

