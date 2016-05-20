//
//  CHRestController.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLoginModalController.h"
@interface CHRestController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *fetchCheckCode;
@property (weak, nonatomic) IBOutlet UIButton *finish;
@property (weak, nonatomic) IBOutlet UITextField *checkCode;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *freshPassword;

@property (nonatomic ,weak) CHLoginModalController *loginModalViewController;
@property (copy, nonatomic) NSString *checkCodePathURL;
@property (copy, nonatomic) NSString *resetPathURL;
@end
