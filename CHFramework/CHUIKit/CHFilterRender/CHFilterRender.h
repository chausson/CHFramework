//
//  CHFilterRender.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <UIKit/UIKit.h>
@class CHFilterRender;

@protocol CHFilterRenderDelegate <NSObject>

@required

- (NSArray <NSString *>*)filterDataSource;

@optional

- (void)didSelectedViewWithIndex:(NSInteger)index;

@end
@interface CHFilterRender : NSObject

@property (nonatomic , weak ) id <CHFilterRenderDelegate>delegate;
@property (nonatomic , strong) UIColor *selectedColor;
@property (nonatomic , strong) UIColor *normalColor;
@property (nonatomic , assign) NSInteger index;
@property (nonatomic , assign) CGFloat filterHeight; // defult height is 200
@property (nonatomic , readonly , getter=isVisable) BOOL visable; //decide is hidden or not status
- (void)showWithFrame:(CGRect )frame
               toView:(UIView *)view
             animated:(BOOL)animated;

- (void)showBelowWithView:(UIView *)view animated:(BOOL)animated;

- (void)hidden:(BOOL)animated;

@end
