//
//  CHLoginOperationWebController.m
//
//
//  Created by Chausson on 15/11/7.
//  Copyright (c) 2015年 Chausson. All rights reserved.
//
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "CHLoginOperationWebController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation CHLoginOperationWebController{
  WebViewJavascriptBridge* _bridge;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.web = [[UIWebView alloc]init];
    self.web.backgroundColor = [UIColor whiteColor];
    self.web.delegate = self;
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];

    
    [RACObserve(self.viewModel, webPath) subscribeNext:^(NSString  *path) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    }];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.web]; /** js调用方法返回注册成功状态*/
    [_bridge registerHandler:@"registerStatus" handler:^(NSString *status, WVJBResponseCallback responseCallback) {
        NSLog(@"是否成功=%@",status);
        responseCallback([NSNumber numberWithInt:[UIScreen mainScreen].bounds.size.height]);
    }];

}

@end
