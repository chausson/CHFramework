//
//  IntroduceViewController.h
//  FrameWorkPractice
//
//  Created by 李赐岩 on 15/11/9.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroduceViewModel.h"
@interface IntroduceViewController : UIViewController
- (instancetype)init __unavailable;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __unavailable;
- (instancetype)initWithViewModel:(IntroduceViewModel *)viewModel;

@property (strong, nonatomic ) IntroduceViewModel *viewModel;

@end
