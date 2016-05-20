//
//  CHLoginButton.m
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/5.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHLoginButton.h"

@implementation CHLoginButton
- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

@end
