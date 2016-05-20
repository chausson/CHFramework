//
//  CHLoginModalController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHLoginModalController.h"
#import "CHLoginViewController.h"

#define CH_KEY_LOGIN_URL @"CH_LOGIN_FRAMEWORK_URL"
#define CH_KEY_CHECKCODE_URL @"CH_CHECKCODE_FRAMEWORK_URL"
#define CH_KEY_REGISTER_URL @"CH_REGISTER_FRAMEWORK_URL"
#define CH_KEY_RESET_URL @"CH_RESET_FRAMEWORK_URL"
//#define CH_INFO_CLASS @"CH_INFO_CLASS"


@interface CHLoginModalController ()
@property (nonatomic, strong) UINavigationController *loginNavigationController;

@property (nonatomic, strong) NSBundle *loginBundle;

@end

static NSMutableDictionary *userPathPool ;



@implementation CHLoginModalController
void CHLLog(NSString *format, ...) {
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginPathURL = [userPathPool valueForKey:CH_KEY_LOGIN_URL];
        _resetPathURL = [userPathPool valueForKey:CH_KEY_RESET_URL];
        _registerPathURL  = [userPathPool valueForKey:CH_KEY_REGISTER_URL];
        _checkCodePathURL = [userPathPool valueForKey:CH_KEY_CHECKCODE_URL];
        // Get login bundle
        self.loginBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [self.loginBundle pathForResource:@"CHLoginModalController" ofType:@"bundle"];
        if (bundlePath) {
            self.loginBundle = [NSBundle bundleWithPath:bundlePath];
        }
        
        [self setUpLoginController];
        
        // Set instance
        CHLoginViewController *loginViewController = (CHLoginViewController *)self.loginNavigationController.topViewController;
        
        loginViewController.loginModalViewController = self;
    }
    return self;
}
- (void)setUpLoginController{
    // Add LoginViewController as a child
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CHLoginModalController" bundle:self.loginBundle];
    
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    
    [self addChildViewController:navigationController];
    
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
    
    [navigationController didMoveToParentViewController:self];
    
    self.loginNavigationController = navigationController;
}
+ (void)setLoginPathURL:(NSString *)loginPathURL
       checkCodePathURL:(NSString *)checkCodePathURL
        registerPathURL:(NSString *)registerPathURL
           resetPathURL:(NSString *)resetPathURL{
        userPathPool = [[NSMutableDictionary alloc]init];
        [userPathPool setValue:loginPathURL forKey:CH_KEY_LOGIN_URL];
        [userPathPool setValue:checkCodePathURL forKey:CH_KEY_CHECKCODE_URL];
        [userPathPool setValue:registerPathURL forKey:CH_KEY_REGISTER_URL];
        [userPathPool setValue:resetPathURL forKey:CH_KEY_RESET_URL];
}

@end
