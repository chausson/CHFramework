//
//  UIColor+Hex.h
//  FrameWorkPractice
//
//  Created by 郭金涛 on 15/11/11.
//  Copyright © 2015年 李赐岩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor_Hex : UIColor

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
