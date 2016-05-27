//
//  CHRestController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHRestController.h"
#import "SDResetPasswordAPI.h"
#import "SDSendCodeAPI.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CHRestController ()

@end

@implementation CHRestController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    if (self.fetchCheckCode) {
        [[self.fetchCheckCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self fetchCheckCodeAction];
        }];
    }
    if (self.finish) {
        RACSignal *validUser = [RACSignal
                                combineLatest:@[[self.phone rac_textSignal],
                                                [self.checkCode rac_textSignal],
                                                [self.oldPassword rac_textSignal],
                                                [self.freshPassword rac_textSignal],
                                                ]
                                reduce:^(NSString *username, NSString *code,NSString *oldPassword,NSString *freshPassword){
                                    return @(username.length >= 11 && freshPassword.length >= 6 && oldPassword.length >= 6 && code.length > 0);
                                }];
        [validUser subscribeNext:^(NSNumber *value) {
            @strongify(self);
            self.finish.enabled = [value boolValue];
            self.finish.backgroundColor = [value boolValue]?kUIColorFromRGB(0x01a1ff):kUIColorFromRGB(0xb2b2b2);
        }];
        [[self.finish rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self resetPassword];
        }];
    }
}

#pragma mark IBAction
- (void)fetchCheckCodeAction{
    if (self.phone.text.length == 0 && self.phone.text.length != 11) {
        [CHProgressHUD showPlainText:@"请输入正确的手机号码"];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
        return;
    }
    [self registerFirstResponsed];
    [self countDownWithTime:60];
  //  NSAssert(self.checkCodePathURL.length > 0, @"重设密码的Code URL没有设置");
    SDSendCodeAPI *sendCode = [[SDSendCodeAPI alloc]initWithCellPhone:self.phone.text];
    [sendCode startWithSuccessBlock:^(__kindof SDSendCodeAPI *request) {
        if (request.baseResponse.code != 200) {
            [CHProgressHUD showPlainText:request.baseResponse.message];
        }
    } failureBlock:^(__kindof SDSendCodeAPI *request) {
        [CHProgressHUD showPlainText:@"发送验证码，请确认网络后重试"];
    }];
    
}
- (void)resetPassword{
    
  //  NSAssert(self.resetPathURL.length > 0 , @"重设密码的URL没有设置");
    NSString *message ;
    if (self.phone.text.length == 0 || self.oldPassword.text.length == 0 || self.freshPassword.text.length == 0
        || self.checkCode.text.length == 0) {
        message = @"输入的内容不能为空";
    }
    if (![self.oldPassword.text isEqualToString:self.freshPassword.text]) {
        message = @"两次输入的密码不一致";
    }
    if (message.length > 0) {
        [CHProgressHUD showPlainText:message];
        return;
    }
    [CHProgressHUD show:YES];
    SDResetPasswordAPI *reset = [[SDResetPasswordAPI alloc]initWithAccount:self.phone.text password:self.oldPassword.text phoneCode:self.checkCode.text];
    [reset startWithSuccessBlock:^(__kindof SDResetPasswordAPI *request) {
        [CHProgressHUD hideWithText:request.baseResponse.message animated:YES];
        if (request.baseResponse.code == 200) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failureBlock:^(__kindof SDResetPasswordAPI *request) {
        [CHProgressHUD hideWithText:@"重设密码失败请检查网络" animated:YES];
    }];
}
- (void)registerFirstResponsed{
    [self.phone resignFirstResponder];
    [self.checkCode resignFirstResponder];
    [self.oldPassword resignFirstResponder];
    [self.freshPassword resignFirstResponder];
}
- (void)countDownWithTime:(int )time{
    
    __block int _surplusSecond = time;
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //定时循环执行事件
    @weakify(self);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{ //计时器事件处理器
      //  CHLLog(@"Event Handler");
        @strongify(self);
        if (_surplusSecond <= 0) {
            dispatch_source_cancel(timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
            self.fetchCheckCode.enabled = YES;
            dispatch_async(mainQueue, ^{
                [self.fetchCheckCode setBackgroundColor:kUIColorFromRGB(0x01a1ff)];
                [self.fetchCheckCode setTitle:@"重新获取" forState:UIControlStateNormal];
                
            });
        } else {
            _surplusSecond--;
            self.fetchCheckCode.enabled = NO;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *btnInfo = [NSString stringWithFormat:@"%ld秒", (long)(_surplusSecond + 1)];
                [self.fetchCheckCode setTitle:btnInfo forState:UIControlStateDisabled];
                
                [self.fetchCheckCode setBackgroundColor:kUIColorFromRGB(0xb2b2b2)];
                
            });
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
        CHLLog(@"Cancel Handler");
    });
    dispatch_resume(timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
}
@end
