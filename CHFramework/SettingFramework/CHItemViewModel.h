//
//  CHItemViewModel.h
//  FrameWorkPractice
//
//  Created by 肖松 on 16/1/6.
//  Copyright © 2016年 李赐岩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHItemViewModel : NSObject
@property (strong ,nonatomic) NSString *identifier;
@property (strong ,nonatomic) NSString *segueIdentifier;
@property (strong ,nonatomic) NSString *name;

- (void)action;
@end
