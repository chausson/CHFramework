//
//  WebViewController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/12.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "WebViewController.h"
#import "CHWebViewController.h"
@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Url";
            break;
        case 1:
            cell.textLabel.text = @"Remote File";
            break;
        case 2:
            cell.textLabel.text = @"Local File";
            break;
            
        default:
            break;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CHWebViewController *web ;
    switch (indexPath.row) {
        case 0:
            web  =[[CHWebViewController alloc]initWithURL:@"http://www.baidu.com"];
            
            break;
        case 1:{

            web  =[[CHWebViewController alloc]initWithURL:@"http://img4.imgtn.bdimg.com/it/u=842388172,3583022668&fm=15&gp=0.jpg"];
        }
            break;
        case 2:{
            NSString *path = [[NSBundle mainBundle]pathForResource:@"hello" ofType:@"pdf"];
            web  =[[CHWebViewController alloc]initWithFile:path];
        }break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:web animated:YES];
}


@end
