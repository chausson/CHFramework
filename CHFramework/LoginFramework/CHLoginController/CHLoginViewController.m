//
//  CHLoginViewController.m
//
//  Created by Chausson on 15/11/4.
//  Copyright © Chausson. All rights reserved.
//

#import "CHUserInfoModel.h"
#import "CHLoginViewController.h"
#import "CHLoginServiceCenter.h"
#import "CHLoginModalController.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#define UINAVGATIONHEIGHT 64
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CHLoginViewController ()

@end

@implementation CHLoginViewController{
   
}
#pragma mark init

#pragma mark Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisetButtonAction];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setHidden:TRUE];

 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:FALSE];
}
#pragma mark Private
- (void)regisetButtonAction{
    @weakify(self);
    if (self.registerBtn) {
        [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self regisetAction:x];
        }];
    }

    if (self.backBtn) {
        self.backBtn.hidden = !self.loginModalViewController.needBackButton;
        [[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self backForword:x];
        }];
    }
    if (self.forgetBtn) {
        [[self.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self resetPassword:x];
        }];
    }
    if (self.loginBtn) {
        RACSignal *validUser = [RACSignal
                                combineLatest:@[[self.username rac_textSignal],
                                                [self.passWordText rac_textSignal],
                                                ]
                                reduce:^(NSString *username, NSString *password){
                                    return @(username.length >= 11 && password.length >= 6 );
                                }];
        [validUser subscribeNext:^(NSNumber *value) {
            @strongify(self);
           self.loginBtn.backgroundColor = [value boolValue]?kUIColorFromRGB(0x01a1ff):kUIColorFromRGB(0xb2b2b2);
        }];
        self.loginBtn.rac_command = [[RACCommand alloc]initWithEnabled:validUser signalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self login];
            return [RACSignal empty];
        }];
    }
}

// 登录响应事件
- (void)login{
    [CHProgressHUD show:YES];
    @weakify(self);
    NSAssert(self.loginModalViewController.loginPathURL.length > 0, @"Please Input Login URL Path When You Used LoginModal");
    [[CHLoginServiceCenter shareInstance]loginAccount:self.username.text password:self.passWordText.text urlPath:self.loginModalViewController.loginPathURL successful:^(id result) {
        [CHProgressHUD hide:YES];
        NSDictionary *info ;
        if (result[@"data"]) {
            info = result[@"data"];
        }
        int code = [result[@"code"]intValue];
        @strongify(self);
        if (code == 200 || info) {
            if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_willCompletionWithSuccess:)]) {
                [self.loginModalViewController.delegate ch_willCompletionWithSuccess:info];
            }
            if (self.loginModalViewController) {
                
                [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
//                    if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithSuccessful:)]) {
//                        [self.loginModalViewController.delegate ch_completionLoginWithSuccessful:info];
//                    }
                }];
            }
        }else{

            NSString *message;
            if (result[@"message"]) {
                message = result[@"message"] ;
            }
            NSError *failureError = [[NSError alloc]initWithDomain:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__] code:code userInfo:@{@"message":message}];
            if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
                [self.loginModalViewController.delegate ch_completionLoginWithFailur:failureError];
            }
     
            CHLLog(@"Login Message = %@",result[@"message"]);
        }
    } error:^(NSError *error) {
        @strongify(self);
        [CHProgressHUD hide:YES];
        if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
            [self.loginModalViewController.delegate ch_completionLoginWithFailur:error];
        }
    }];
    
}
#pragma mark IBAction
- (void)backForword:(UIButton *)sender {

    [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
        if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithCancel)]) {
            [self.loginModalViewController.delegate ch_completionLoginWithCancel];
        }
   //     self.loginModalViewController = nil;
    }];

}
- (void)regisetAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"register" sender:self];
}
- (void)resetPassword:(UIButton *)sender {
    [self performSegueWithIdentifier:@"reset" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:@"register"]) {
        // segue.destinationViewController：获取连线时所指的界面（VC）
        if (self.loginModalViewController) {
        [segue.destinationViewController setValue:self.loginModalViewController forKey:@"loginModalViewController"];
        [segue.destinationViewController setValue:self.loginModalViewController.registerPathURL forKey:@"registerPathURL"];
        [segue.destinationViewController setValue:self.loginModalViewController.checkCodePathURL forKey:@"checkCodePathURL"];
        }
    }else{
        if (self.loginModalViewController) {
            [segue.destinationViewController setValue:self.loginModalViewController forKey:@"loginModalViewController"];
            [segue.destinationViewController setValue:self.loginModalViewController.resetPathURL forKey:@"resetPathURL"];
            [segue.destinationViewController setValue:self.loginModalViewController.checkCodePathURL forKey:@"checkCodePathURL"];
        }
    }
}
- (void)dealloc{
    
}
@end
