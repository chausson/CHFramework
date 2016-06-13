//
//  CHQuickTableViewModel.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/6/7.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHQuickCellViewModel.h"
@interface CHQuickTableViewModel : NSObject
@property (nonatomic ,strong) NSArray <CHQuickCellViewModel *>*cellViewModel;
@end
