//
//  NetBaseService.h
//  FrameWorkPractice
//
//  Created by 李赐岩 on 15/11/9.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^success)();
typedef void(^failure)();
@interface NetBaseService : NSObject
/**
 * @brief POST网络请求
 *@parm 域名, 参数, 成功失败block
 */
+ (void)fetchPOSTHTTPMethodWithURL:(NSString *)url
                        parameter:(NSDictionary *)parameters
                          success:(success)successful
                          failure:(failure)failure;
/**
 * @brief get网络请求
 * @parm 域名, 参数, 成功失败block
 */
+ (void)fetchGETHTTPMethodWithURL:(NSString *)url
                        parameter:(NSDictionary *)parameters
                          success:(success)successful
                          failure:(failure)failure;


@end
