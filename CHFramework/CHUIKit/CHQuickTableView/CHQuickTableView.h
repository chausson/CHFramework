//
//  CHQuickTableView.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/6/6.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHQuickTableView;
@class CHTableViewCell;
@protocol CHQuickTableViewDataSource <NSObject>

@required
- (CHTableViewCell *)ch_TableViewDisplayForCell;

- (NSArray *)ch_TableViewDataSourceForViewModels;

@optional

- (NSArray <NSNumber *>*)ch_TableViewHeightForRows;

@end
@interface CHQuickTableView : UIView

@property (nonatomic, weak) UIViewController <CHQuickTableViewDataSource>* dataSource;

@property (nonatomic, assign) CGFloat cellHeight;// defult is 40.f;

@end
