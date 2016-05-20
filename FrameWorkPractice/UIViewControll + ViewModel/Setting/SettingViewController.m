//
//  SettingViewController.m
//  FrameWorkPractice
//
//  Created by YouXieRen on 15/12/5.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import "SettingViewController.h"
#import "CHSettingController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setting:(UIButton *)sender {
    CHSettingController *setting = [[CHSettingController alloc]init];
    [self presentViewController:setting animated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
