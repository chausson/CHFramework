//
//  CHBarItemViewModel.h
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBarItemViewModel : NSObject
@property (copy ,nonatomic ,readonly) NSString *title;
@property (copy ,nonatomic ,readonly) NSString *unselectIcon;
@property (copy ,nonatomic ,readonly) NSString *selectedIcon;
@property (copy ,nonatomic ,readonly) NSString *uiviewControllName;
//@property (assign ,nonatomic ,getter = isSelected) BOOL selected;
- (instancetype)initWithUnselectIcon:(NSString *)unselect
                        selectedIcon:(NSString *)selected
                    uiviewcontroller:(NSString *)uiviewcontroll
                               title:(NSString *)title;
@end
