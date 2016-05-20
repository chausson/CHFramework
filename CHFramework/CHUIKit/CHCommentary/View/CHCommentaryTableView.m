//
//  CHCommentaryTableView.m
//  CommentaryModule
//
//  Created by Chausson on 16/4/19.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import "CHCommentaryController.h"
#import "CHCommentaryTableView.h"

@implementation CHCommentaryTableView
- (instancetype)initWithOwner:(CHCommentaryController <UITableViewDelegate,UITableViewDataSource>*)controller{
    CGFloat viewY;
    CGFloat viewHeight;
    CGFloat keyboardHeight = controller.keyBofardView.frame.size.height;
    if (controller.navigationController.navigationBar && controller.navigationController.navigationBar.translucent == NO) {
        
        viewY = 0;
        viewHeight = controller.view.frame.size.height - 64-keyboardHeight;
    }
    else{
        viewY = 20;
        viewHeight = controller.view.frame.size.height - 20-keyboardHeight;

    }
    
   CGRect rect = CGRectMake(0, viewY, controller.view.frame.size.width, viewHeight);

    self = [super initWithFrame:rect style:UITableViewStylePlain];
       NSLog(@"rect=%@",NSStringFromCGRect(rect));
    if (self) {
        self.delegate = controller;
        self.dataSource = controller;
    }
    return self;
}
@end
