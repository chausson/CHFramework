//
//  CHContentController.m
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/6.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHContentController.h"
#import "CHSettingCell.h"
#import "CHSignOutCell.h"
#import "CHSettingBackgroundCell.h"
#import "CHSettingItemCell.h"
@interface CHContentController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@end

@implementation CHContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHItemViewModel *cellVM =  self.items[indexPath.row];
    CHSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[cellVM identifier]];
    [cell loadFromData:cellVM];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     CHItemViewModel *cellVM =  self.items[indexPath.row];
   
    if ([cellVM.identifier isEqualToString:[CHSignOutCell identifier]]) {
   
        [self signOut];
    }else if (cellVM.segueIdentifier.length > 0) {
        [self performSegueWithIdentifier:cellVM.segueIdentifier sender:self];
    }else {
        [cellVM action];
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHItemViewModel *cellVM =  self.items[indexPath.row];
    if ([cellVM.identifier isEqualToString:[CHSettingBackgroundCell identifier]]) {
        return 10;
    }else {
        return 50;
    }
}
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)signOut{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定需要退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
@end
