
/*
 
   CHSlideView 是 UIScrollView 的一个重用视图，新闻类型客户端比较常见这种做法
   CHSlideCell
   CHSlideTitleView
   CHCache
 */


#import <UIKit/UIKit.h>
#import "CHSlideConfig.h"
#import "CHSlideCell.h"

@class CHSlideView;
@class CHSlideTitleView;

#pragma mark CHSlideViewDelegate

/*CHSlideView delegate 方法，设置重用 Cell 和需要创建的页面数 ，在此没有区分 
 dataSource 和 view delegate 。统一实现 CHSlideViewDelegate
 */
@protocol CHSlideViewDelegate <NSObject>

@required
/**
 *  需要创建的页面数量
 */
- (NSInteger)columnNumber;

/**
 *  创建Cell方法，使用重用机制。目前在此处只针对UITableView，有特殊需求的可自行进行修改
 *
 *  @param slideView
 *  @param index     页面相对应的索引路径
 *
 *  @return Cell
 */
- (CHSlideCell *)slideView:(CHSlideView *)slideView
     cellForRowAtIndex:(NSUInteger)index;

/**
 *  当 cell 初始化完成时调用
 *  可以做预加载显示缓存数据
 *
 *  @param cell
 *  @param index
 */
- (void)slideViewInitiatedComplete:(CHSlideCell*)cell forIndex:(NSUInteger)index;
@optional

/**
 *  返回当前页码
 *
 *  @param index 页码
 */
- (void)slideVisibleView:(CHSlideCell*)cell forIndex:(NSUInteger)index;

@end

#pragma mark CHSlideView
@interface CHSlideView : UIView

/*做这种类型自定义需求比较高，在此就没提供更多方便的接口。
 mainScrollview 装栽所有Cell 的一个集合容器
 slideTitleView titles 栏目的容器集合
 */
@property (nonatomic,strong) UIScrollView     *mainScrollview;
@property (nonatomic,strong) CHSlideTitleView *slideTitleView;
@property (nonatomic,strong) UIColor *contentViewColor;
@property (nonatomic,strong) UIColor *tintColor;
@property (nonatomic,assign) CGFloat widthGap; // defult is 10
@property (nonatomic,assign) CGFloat slideTitleViewTitleMax  ;// defult is 16
@property (nonatomic,assign) CGFloat slideTitleViewTitleMin  ;// defult is 14
// default NO 是否显示滚动条
@property (nonatomic,assign)BOOL              showsScrollViewHorizontalScrollIndicator;
// default NO 是否支持滚动标题栏 
@property (nonatomic,assign)BOOL              allowedScrollContentTitle;
// default NO 是否支持缩放字体
@property (nonatomic,assign)BOOL              allowedScaleFontSize; // defult is NO size use slideTitleViewTitleMin

@property (nonatomic,weak) id<CHSlideViewDelegate>delegate;

/**
 *  初始化方法
 *
 *  @param frame
 *  @param titles headView的内容标题
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray *)titles;

/**
 *  重置数据
 */
- (void)reloadData;

/**
 *  重用
 *
 *  @return 可重用的Cell
 */
- (CHSlideCell*)dequeueReusableCell;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com