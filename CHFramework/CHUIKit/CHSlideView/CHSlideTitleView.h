
/*
  CHSlideTitleView 栏目标题
 */

#import <UIKit/UIKit.h>
static float const CHSildeTitleViewHeight = 44;

typedef void (^CHSlideTitleViewScrollBlock)(CGFloat offset_x);
typedef void (^CHSlideViewWillScrollEndBlock)(CGFloat offset_x);
typedef void (^CHSlideTitleViewClickButtonBlock)(NSUInteger index);

@interface CHSlideTitleView : UIScrollView

@property (nonatomic,copy) CHSlideTitleViewScrollBlock
slideTitleViewScrollBlock;
@property (nonatomic,copy) CHSlideTitleViewClickButtonBlock slideTitleViewClickButtonBlock;
@property (nonatomic,copy) CHSlideViewWillScrollEndBlock
slideViewWillScrollEndBlock;
/*判断是否点击 Button 或 滚动 UIScrollView 进行页面的切换 */
@property (nonatomic,assign) BOOL isClickTitleButton;
@property (nonatomic,strong) UIColor *tintColor;
@property (nonatomic,assign) CGFloat widthGap; // defult is 10
@property (nonatomic,assign) CGFloat slideTitleViewTitleMax  ;// defult is 16
@property (nonatomic,assign) CGFloat slideTitleViewTitleMin  ;// defult is 14
@property (nonatomic,assign) BOOL    allowedScaleFontSize;
- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray*)titles;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com