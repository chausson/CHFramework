//
//  CHContentController.h
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHItemViewModel.h"
@interface CHContentController : UIViewController
@property (nonatomic ,strong )NSArray <CHItemViewModel *>*items;
@end
