//
//  CHLoginViewController.h
//
//  Created by Chausson on 15/11/4.
//  Copyright © Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLoginModalController.h"

@interface CHLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (nonatomic ,weak) CHLoginModalController *loginModalViewController;

@end
