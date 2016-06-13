//
//  LoginViewController.m
//  FrameWorkPractice
//
//  Created by YouXieRen on 15/12/5.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import "LoginViewController.h"
#import "CHLoginModalController.h"
#import "CHUserInfoModel.h"
#import "WebViewController.h"
#import "CHPickerImage.h"
#import "CHCommentaryController.h"
#import "CHFilterViewController.h"
#import "CHSlideViewController.h"
#import "CHQuickTableController.h"
#import <CHNetworking/CHNetworking.h>
#define TOKEN @"8rc3%2BVwxuDpgiOEW%2Fe37%2FMAQjeHM6HFb6K3cNEpmVHQ1Gfvx8YI%2BpkAzov2ysr9ExKdh3MRoPFqlBoRqEqucSSDLPsTP%2FyAr1BHoRG%2BvDO5XBUtGzSvIGBjfEiim%2Fy97peUK8KsIYKi%2FJmNhAS4QtQ%3D%3D"

#define LISTURL @"http://p2pguide.sudaotech.com/platform/app/comment/list"

#define COMMENTURL @"http://p2pguide.sudaotech.com/platform/app/comment"

#define IDENTIFIER @"28"
#define PUSH_AND_INIT_CONTROLLER(class) [self.navigationController pushViewController:[[class alloc]init] animated:YES];

@interface LoginViewController ()<CHLoginModalControllerDelegate>

@end

@implementation LoginViewController{
    NSArray * _data;
    //CHLoginModalController *login;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[CHNetworkConfig sharedInstance] setAllowPrintLog:YES];
    [[CHNetworkConfig sharedInstance] setBaseUrl:@"http://app4tv.sudaotech.com/platform"];
    _data = @[@"CHLogin",@"CHCommentary",@"CHImagePicker",@"CHFilterRender",@"CHSlideView",@"CHWebView",@"CHQuickTableView"];
 

}
- (void)ch_completionLoginWithSuccessful:(NSDictionary *)info{
    NSLog(@"ch_completionLoginWithSuccessful Info = %@",[info description]);
}
- (void)ch_completionLoginWithFailur:(NSError *)error{
    NSLog(@"ch_completionLoginWithFailur Error Info = %@",[error description]);
}
- (void)ch_completionLoginWithCancel{
    NSLog(@"ch_completionLoginWithCancel");
}
- (void )login{

   CHLoginModalController *login = [[CHLoginModalController alloc]init];
    login.needBackButton = YES;
    login.delegate = self;
    
    [self presentViewController:login animated:YES completion:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self login];
    }else if(indexPath.row == 1){
        CHCommentaryViewModel *viewModel = [[CHCommentaryViewModel alloc] initWithToken: TOKEN ListUrl: LISTURL sendCommentUrl: COMMENTURL identifier: IDENTIFIER];
        viewModel.isSignIn = YES;
        CHCommentaryController *controller = [[CHCommentaryController alloc]initWithViewModel:viewModel];
        [self.navigationController pushViewController:controller animated:YES];
    }else if(indexPath.row == 2){
        PUSH_AND_INIT_CONTROLLER([CHPickerImage class])
    }else if(indexPath.row == 3){
        PUSH_AND_INIT_CONTROLLER([CHFilterViewController class])
    }else if(indexPath.row == 4){
        PUSH_AND_INIT_CONTROLLER([CHSlideViewController class])
    }else if(indexPath.row == 5){
        [self web];
    }else{
        PUSH_AND_INIT_CONTROLLER([CHQuickTableController class])
    }
}
- (void)web{
    WebViewController *web  = [[WebViewController alloc]init];
    [self.navigationController pushViewController:web animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

@end
