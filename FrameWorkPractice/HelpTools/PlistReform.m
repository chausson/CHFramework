//
//  PlistReform.m
//  FrameWorkPractice
//
//  Created by 李赐岩 on 15/11/9.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import "PlistReform.h"
#import <Foundation/Foundation.h>
@implementation PlistReform
-(NSDictionary *)fetchDictionaryWithFileName:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return dic;
}


@end
