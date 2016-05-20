//
//  ModalCenterReform.h
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ASNavigator.h"
@interface ModalCenterReform : NSObject
@property (strong, nonatomic) NSMutableDictionary *modalParamter;
@property (strong, nonatomic) UIViewController <ASNavigatable>*controller;

- (instancetype)initWithIdentifer:(NSString *)identifer
                    andParameters:(NSDictionary *)parameter;


@end
