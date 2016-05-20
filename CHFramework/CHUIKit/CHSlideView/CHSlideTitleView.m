

#import "CHSlideTitleView.h"
#import "CHSlideConfig.h"
#define CHKVORegisterKeyPath(keyPath) [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
#define CHKVORemoveKeyPath(keyPath)   [self removeObserver:self forKeyPath:keyPath];
static NSInteger const CHSlideTitleViewButtonTag = 28271;
static CGFloat const CHButtonHeight = 44;

static inline UIFont *buttonFont(UIButton *button,CGFloat titleSize){
    
    return [UIFont fontWithName:button.titleLabel.font.fontName size:titleSize];
}

@interface CHSlideTitleView()<UIScrollViewDelegate>{

    NSArray    *_titles;
    NSUInteger  _previousPage;
    UIView *_bottomLine;
}
//设置 view 和 button
- (void)configView;
- (void)configButtonWithOffsetx:(CGFloat)offsetx;
//计算字体变化大小
- (CGFloat)titleSizeSpacingWithOffsetx:(CGFloat)sx;
@end

@implementation CHSlideTitleView

- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray*)titles{

    self = [super initWithFrame:frame];
    
    if (self) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-2, 0, 2)];
        _bottomLine.backgroundColor = _tintColor;
        _titles              = [titles copy];
        _previousPage        = 0;
        _tintColor           = [UIColor redColor];
        _widthGap            = 10.0f;
        _slideTitleViewTitleMax = 16.f;
        _slideTitleViewTitleMin = 13.f;
        self.delegate        = self;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = SET_COLOS_CHSLIDE(250, 250, 250);
        [self configView];
        CHKVORegisterKeyPath(@"slideTitleViewTitleMax")
        CHKVORegisterKeyPath(@"slideTitleViewTitleMin")
        CHKVORegisterKeyPath(@"widthGap")
        CHKVORegisterKeyPath(@"tintColor")
        CHKVORegisterKeyPath(@"allowedScaleFontSize")
        [self addSubview:_bottomLine];
    }
    
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self refresh];
}
- (void)dealloc{
    CHKVORemoveKeyPath(@"slideTitleViewTitleMax")
    CHKVORemoveKeyPath(@"slideTitleViewTitleMin")
    CHKVORemoveKeyPath(@"widthGap")
    CHKVORemoveKeyPath(@"tintColor")
    CHKVORemoveKeyPath(@"allowedScaleFontSize")
    
}
- (void)configView{

    //设置 content size
    float buttonWidth = 0.f;

    for (NSUInteger i = 0; i<_titles.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     
        [button.titleLabel setFont:buttonFont(button,_slideTitleViewTitleMin)];
        
        CGSize titleSize = [CHSlideTitleView boudingRectWithSize:CGSizeMake(SCREEN_WIDTH_CHSLIDE, CHSildeTitleViewHeight)
                                                        label:button.titleLabel
                                                        size:_slideTitleViewTitleMax];
        
        CGRect frame;
        frame.origin = CGPointMake(buttonWidth, 0);
        frame.size   = CGSizeMake(titleSize.width+_widthGap, CHButtonHeight);
        [button setFrame:frame];
        
        buttonWidth += CGRectGetWidth(button.frame);

        button.tag             = CHSlideTitleViewButtonTag + i;
        button.backgroundColor = [UIColor clearColor];
        
        [button addTarget:self
                   action:@selector(buttonEvents:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self configButtonWithOffsetx:0];
        
        [self addSubview:button];
    }
    
    self.contentSize = CGSizeMake(buttonWidth, CHSildeTitleViewHeight);
    
    __WEAK_SELF_CHSLIDE
    
    self.slideTitleViewScrollBlock =^(CGFloat offsetx){
        
        
        __STRONG_SELF_CHSLIDE
        [strongSelf configButtonWithOffsetx:offsetx];

    };
    
//    self.slideViewWillScrollEndBlock =^(CGFloat offsetx){
//        
//        __STRONG_SELF_CHSLIDE
//       //设置 Button 可见
//        CGFloat x = offsetx * (60 / self.frame.size.width) - 60;
//      
//        [strongSelf scrollRectToVisible:CGRectMake(x, 0,
//                                                   strongSelf.frame.size.width,
//                                                   strongSelf.frame.size.height)
//                               animated:YES];
//    
//    };
    
}
- (void)refresh{
    //设置 content size
    float buttonWidth = 0.f;

    for (NSUInteger i = 0; i<_titles.count; i++) {
        
        UIButton * button = [self viewWithTag:CHSlideTitleViewButtonTag + i ];

        CGRect frame = button.frame;
        
        frame.origin = CGPointMake(buttonWidth, 0);
        
        CGSize titleSize = [CHSlideTitleView boudingRectWithSize:CGSizeMake(SCREEN_WIDTH_CHSLIDE, CHSildeTitleViewHeight)
                                                           label:button.titleLabel
                                                            size:_slideTitleViewTitleMax];
        
        frame.size   = CGSizeMake(titleSize.width+_widthGap, CHButtonHeight);
        
        [button setFrame:frame];
        
        buttonWidth += CGRectGetWidth(button.frame);
        
        [button.titleLabel setFont:buttonFont(button,_slideTitleViewTitleMin)];
        
    }
    [self configButtonWithOffsetx:_previousPage];
}
//- (void)setWidthGap:(CGFloat)widthGap{
//    _widthGap = widthGap;
//    [self refresh];
//}
//- (void)setTintColor:(UIColor *)tintColor{
//    _tintColor = tintColor;
//    [self refresh];
//  
//}
//- (void)setSlideTitleViewTitleMin:(CGFloat)slideTitleViewTitleMin{
//    _slideTitleViewTitleMin = slideTitleViewTitleMin;
//    [self refresh];
//}
//- (void)setSlideTitleViewTitleMax:(CGFloat)slideTitleViewTitleMax{
//    _slideTitleViewTitleMax = slideTitleViewTitleMax;
//    [self refresh];
//}
- (void)configButtonWithOffsetx:(CGFloat)offsetx{
    
#warning 在重复使用 [UIFont fontWithName:button.titleLabel.font.fontName size:titleSize]方法会占用极大的内存(已反复试验)，每次都需要对Label进行处理。在此处请谨慎使用此方法，此变换效果也是其中一种可根据自行需求进行修改。有更好的方法可告知。

    NSUInteger currentPage   = offsetx/SCREEN_WIDTH_CHSLIDE;
    
    CGFloat titleSizeSpacing = [self titleSizeSpacingWithOffsetx:offsetx/SCREEN_WIDTH_CHSLIDE];
    
    if (_previousPage != currentPage) {
        
        UIButton * previousButton = (UIButton*)[self viewWithTag:_previousPage +CHSlideTitleViewButtonTag];
        
        [previousButton setTitleColor:[UIColor grayColor]
                        forState:UIControlStateNormal];
        
    }
    
    UIButton * currentButton = (UIButton*)[self viewWithTag:currentPage+CHSlideTitleViewButtonTag];
    
    if (_allowedScaleFontSize) {
        [currentButton.titleLabel setFont:[UIFont systemFontOfSize:(_slideTitleViewTitleMax-titleSizeSpacing)]];
    }
   // [currentButton.titleLabel setFont:buttonFont(currentButton,
                                                 //_slideTitleViewTitleMax-titleSizeSpacing)];
    
    [currentButton setTitleColor:_tintColor forState:UIControlStateNormal];
    
    _bottomLine.backgroundColor = _tintColor;
    
    CGRect lineRect = _bottomLine.frame;
    lineRect.size.width = currentButton.frame.size.width;
    lineRect.origin.x = currentButton.frame.origin.x;
    [UIView animateWithDuration:0.15f animations:^{
        _bottomLine.frame = lineRect;
    }];

    UIButton * nextButton = [self viewWithTag:currentPage+1+CHSlideTitleViewButtonTag];
    if (_allowedScaleFontSize) {
        [nextButton.titleLabel setFont:[UIFont systemFontOfSize:(_slideTitleViewTitleMin+titleSizeSpacing)]];
    }

    //[nextButton.titleLabel setFont:buttonFont(currentButton,
                                             // _slideTitleViewTitleMin+titleSizeSpacing)];
    
    [nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    


    
    _previousPage = currentPage;
}

- (CGFloat)titleSizeSpacingWithOffsetx:(CGFloat)sx{
    CGFloat size = sx;
  
        NSInteger scale         = sx*100;
        size  = (scale % 100) * 0.01 * 3;


    return size;
}

- (void)buttonEvents:(UIButton*)button{

    self.isClickTitleButton = YES;
    
    if (_slideTitleViewClickButtonBlock) {
        _slideTitleViewClickButtonBlock(button.tag - CHSlideTitleViewButtonTag);
    }
    
    UIButton *previousButton = [self viewWithTag:_previousPage + CHSlideTitleViewButtonTag];

    [[previousButton titleLabel]setFont:[UIFont systemFontOfSize:_slideTitleViewTitleMin]];
    [previousButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    UIButton *currentButton = [self viewWithTag:button.tag];

    [currentButton setTitleColor:_tintColor forState:UIControlStateNormal];
    
    if (_allowedScaleFontSize) {
        [[previousButton titleLabel]setFont:[UIFont systemFontOfSize:_slideTitleViewTitleMin]];
        [[currentButton titleLabel]setFont:[UIFont systemFontOfSize:_slideTitleViewTitleMax]];
    }
    
    CGRect lineRect = _bottomLine.frame;
    lineRect.size.width = currentButton.frame.size.width;
    lineRect.origin.x = currentButton.frame.origin.x;
    [UIView animateWithDuration:0.15f animations:^{
        _bottomLine.frame = lineRect;
    }];
    
    _previousPage = button.tag - CHSlideTitleViewButtonTag;
    
}

#pragma mark
+ (CGSize)boudingRectWithSize:(CGSize)size label:(UILabel*)label
                         size:(CGFloat)fontSize
{
#warning 如果你是IOS7以下设备使用，请增加相对应的方法
    UIFont * font = label.font;
    font = [font fontWithSize:fontSize];
    NSDictionary * attribute =@{NSFontAttributeName:font};
    
    return   [label.text boundingRectWithSize:size
                                      options:
              NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|
              NSStringDrawingUsesFontLeading
                                   attributes:
              attribute
                                      context:
              nil].size;
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com