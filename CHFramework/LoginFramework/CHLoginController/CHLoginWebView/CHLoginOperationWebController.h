//
//  CHLoginOperationWebController.h
//
//
//  Created by Chausson on 15/11/7.
//  Copyright (c) 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLoginOperationWebViewModel.h"
@interface CHLoginOperationWebController : UIViewController<UIWebViewDelegate>
@property (strong ,nonatomic)UIWebView *web;
@property (strong ,nonatomic)CHLoginOperationWebViewModel *viewModel;
@end
