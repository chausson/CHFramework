//
//  CHLoginModalController.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
FOUNDATION_EXPORT void CHLLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);
@class CHLoginModalController;
@protocol CHLoginModalControllerDelegate <NSObject>
@optional

- (void)ch_willCompletionWithSuccess:(NSDictionary *)info;

- (void)ch_completionLoginWithSuccessful:(NSDictionary *)info;

- (void)ch_completionLoginWithFailur:(NSError *)error;

- (void)ch_completionLoginWithCancel;

@end
@interface CHLoginModalController : UIViewController

@property (nonatomic, weak) id<CHLoginModalControllerDelegate> delegate;

@property (nonatomic , assign) BOOL isSupportOriginateRegister;

@property (nonatomic , assign) BOOL needBackButton;

@property (nonatomic , copy ,readonly) NSString *loginPathURL;

@property (nonatomic , copy ,readonly) NSString *checkCodePathURL;

@property (nonatomic , copy ,readonly) NSString *registerPathURL;

@property (nonatomic , copy ,readonly) NSString *resetPathURL;

/* 初次使用需要配置链接的url*/
+ (void)setLoginPathURL:(NSString *)loginPathURL
       checkCodePathURL:(NSString *)checkCodePathURL
        registerPathURL:(NSString *)registerPathURL
           resetPathURL:(NSString *)resetPathURL __attribute__((deprecated));
/* 如果登录使用webview显示 需要提供url链接地址*/
//@property (nonatomic , copy) NSString *resetPasswordPath;
//
//@property (nonatomic , copy) NSString *registerPath;

@end
