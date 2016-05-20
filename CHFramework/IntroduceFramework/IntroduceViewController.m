//
//  IntroduceViewController.m
//  FrameWorkPractice
//
//  Created by 李赐岩 on 15/11/9.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import "IntroduceViewController.h"

@implementation IntroduceViewController
-(instancetype)initWithViewModel:(IntroduceViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end


