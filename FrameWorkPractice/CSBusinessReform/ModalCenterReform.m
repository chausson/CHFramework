//
//  ModalCenterReform.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ModalCenterReform.h"
#define URL_PLIST_FILENAME @"Business"
static NSMutableDictionary *identiferDic;
@implementation ModalCenterReform

-(instancetype)initWithIdentifer:(NSString *)identifer andParameters:(NSDictionary *)parameter
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:URL_PLIST_FILENAME ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    

    if ([dic objectForKey:identifer]) {
        NSDictionary *refromDic = [dic objectForKey:identifer];
    
        if ([refromDic objectForKey:@"rootViewController"] && [refromDic objectForKey:@"class"]) {
            //有root的规则
            [self initNavigationControllerWithRootClass:[refromDic objectForKey:@"rootViewController"]
             andNaviControllerClass:[refromDic objectForKey:@"class"]];
            
        }else if([refromDic objectForKey:@"class"]) {
            
            [self initControllerWithClassName:[refromDic objectForKey:@"class"]];
         
        }
        _modalParamter = [[NSMutableDictionary alloc]initWithDictionary:refromDic];
    }
    

    if (parameter) {
        [_modalParamter setValuesForKeysWithDictionary:parameter];
    }

 
    
    return self;
}
- (void)initControllerWithClassName:(NSString *)name{
    Class controller = NSClassFromString(name);
    UIViewController <ASNavigatable>*VC = [[controller  alloc] init];
    if (VC) {
        _controller = VC;
        _controller.view.backgroundColor = [UIColor whiteColor];
    }
}
- (void)initNavigationControllerWithRootClass:(NSString *)root
                       andNaviControllerClass:(NSString *)navi{
    Class controller = NSClassFromString(navi);
    Class rootController = NSClassFromString(root);
    UIViewController <ASNavigatable>*VC = [[rootController  alloc] init];
    UINavigationController *nav = [[controller  alloc] initWithRootViewController:VC];
    if (nav) {
        _controller = nav;
    }
    
    
}
@end
