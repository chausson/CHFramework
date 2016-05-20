//
//  CHRegisterController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import "CHRegisterController.h"
#import "CHLoginServiceCenter.h"

#import <CHProgressHUD/CHProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CHRegisterController ()

@end

@implementation CHRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisetButtonAction];
}
#pragma mark Private
- (void)regisetButtonAction{
    @weakify(self);
    if (self.registerBtn) {
        RACSignal *validUser = [RACSignal
                                combineLatest:@[[self.phoneField rac_textSignal],
                                                [self.checkCodeField rac_textSignal],
                                                [self.passwordField rac_textSignal],
                                                ]
                                reduce:^(NSString *username, NSString *code,NSString *password){
                                    return @(username.length >= 11 && password.length >= 6 && code.length > 0);
                                }];
        [validUser subscribeNext:^(NSNumber *value) {
            @strongify(self);
            self.registerBtn.enabled = [value boolValue];
            self.registerBtn.backgroundColor = [value boolValue]?kUIColorFromRGB(0x01a1ff):kUIColorFromRGB(0xb2b2b2);
        }];
        [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self registerAccount];
        }];
    }
    if (self.fetchCheckCode) {
        [[self.fetchCheckCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self fetchCheckCodeAction];
        }];
    }
    if (self.protocal) {
        [[self.protocal rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
         
        }];
    }
    if (self.hiddenPassword) {
        self.hiddenPassword.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
            @strongify(self);
            self.passwordField.secureTextEntry = !input.selected;
            input.selected = !input.selected;
            return [RACSignal empty];
        }];
    }
    
}

// 登录响应事件
- (void)registerAccount{


    NSAssert(self.registerPathURL.length > 0, @"Please Input Login URL Path When You Used LoginModal");
    if (self.phoneField.text.length == 0 || self.passwordField.text.length == 0 || self.checkCodeField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"输入的内容不能为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSAssert(self.registerPathURL.length > 0, @"Register Path URL Is Nil");
    [self registerFirstResponsed];
    [CHProgressHUD show:YES];
    @weakify(self);
    [[CHLoginServiceCenter shareInstance] regsterAccount:self.phoneField.text password:self.passwordField.text checkCode:self.checkCodeField.text urlPath:self.registerPathURL successful:^(id result) {
        @strongify(self);
        [CHProgressHUD hide:YES];
        if ([result[@"code"] intValue] == 200) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:result[@"messgae"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }


    } error:^(NSError *error) {
        [CHProgressHUD hide:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"注册失败，请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        CHLLog(@"Register Error = %@",[error description]);
    }];
 
    
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
                CHLLog(@"Event Handler");
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
- (void)registerFirstResponsed{
    [self.phoneField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
}
#pragma mark IBAction
- (void)fetchCheckCodeAction{
    if (self.phoneField.text.length == 0 && self.phoneField.text.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self registerFirstResponsed];
    [self countDownWithTime:60];
    NSAssert(self.checkCodePathURL.length > 0, @"Register Path URL Is Nil");
    [CHProgressHUD show:YES];
    [[CHLoginServiceCenter shareInstance] checkCodeWithTel:self.phoneField.text andUrlPath:self.checkCodePathURL successful:^(id result) {
        [CHProgressHUD hide:YES];
        if ([result[@"code"] intValue] == 200) {
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:result[@"messgae"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    } error:^(NSError *error) {
        [CHProgressHUD hide:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"发送验证码，请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        CHLLog(@"Register Error = %@",[error description]);
    }];
    
}

- (void)regisetAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"register" sender:self];
}
- (void)resetPassword:(UIButton *)sender {
    [self performSegueWithIdentifier:@"reset" sender:self];
}
- (void)dealloc{
    
}
    


@end
