//
//  CHWebViewController.m
//  Financial
//
//  Created by Chausson on 16/3/9.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHWebViewController.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>

@interface CHWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic ,strong) NSURLRequest *req;

@end

@implementation CHWebViewController{
    BOOL _isFile;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIDocumentInteractionController *documentController;
}
- (instancetype)initWithURL:(NSString *)url
{
    if (self = [super init]) {
        self.url = [NSURL URLWithString:url];
    }
    return self;
}
- (instancetype)initWithFile:(NSString *)url{
    if (self = [super init]) {
        self.url = [NSURL fileURLWithPath:url];
        _isFile = YES;
    }
    return self;
}

- (void)initialize{

    CGFloat height = self.navigationController.navigationBar.isTranslucent && self.navigationController != nil?64:0;
    
    self.mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.mainWebView];
    if (!_isFile) {
        _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, height, self.view.frame.size.width, 3)];
        _progressView.fadeOutDelay = 0.3;
        _progressView.barAnimationDuration = 0.4;
        // _progressView.progressBarView.backgroundColor = [UIColor blueColor];
        _progressProxy = [[NJKWebViewProgress alloc]init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        _mainWebView.delegate = _progressProxy;
    }

    if (_progressView) {
        [self.view addSubview:_progressView];
    }
    [self.mainWebView loadRequest:self.req];

}
- (NSURLRequest *)req{
    if (!_req) {
        _req = [NSURLRequest requestWithURL:self.url];
    }
    return _req;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];

    // Do any additional setup after loading the view.
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [_progressView setProgress:progress animated:YES];
}

@end
