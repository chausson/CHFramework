//
//  CHRegisterController.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © Chausson . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLoginModalController.h"
@interface CHRegisterController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *fetchCheckCode;
@property (weak, nonatomic) IBOutlet UIButton *hiddenPassword;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocal;
@property (copy, nonatomic) NSString *registerPathURL;
@property (copy, nonatomic) NSString *checkCodePathURL;
@property (nonatomic ,weak) CHLoginModalController *loginModalViewController;
@end
