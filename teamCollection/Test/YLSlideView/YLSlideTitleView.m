

#import "YLSlideTitleView.h"
#import "YLSlideConfig.h"

static NSInteger const YLSlideTitleViewButtonTag = 28271;
static CGFloat   const YLSlideTitleViewTitleMax  = 19.f;
static CGFloat   const YLSlideTitleViewTitleMin  = 17.f;

static inline UIFont *buttonFont(UIButton *button,CGFloat titleSize){
    
    return [UIFont fontWithName:button.titleLabel.font.fontName size:titleSize];
}

@interface YLSlideTitleView()<UIScrollViewDelegate>{
    
    NSArray    *_titles;
    NSUInteger  _previousPage;
    
}
//设置 view 和 button
- (void)configView;
- (void)configButtonWithOffsetx:(CGFloat)offsetx;
//计算字体变化大小
- (CGFloat)titleSizeSpacingWithOffsetx:(CGFloat)sx;
@end

@implementation YLSlideTitleView

- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray*)titles{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = SET_COLOS_YLSLIDE(255 , 255, 255);
        _titles              = [titles copy];
        _previousPage        = 0;
        self.delegate        = self;
        self.showsHorizontalScrollIndicator = NO;
        [self configView];
        
    }
    
    return self;
}

- (void)configView{
    
    //设置 content size
    float buttonWidth = 0.f;
    for (NSUInteger i = 0; i<_titles.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [button.titleLabel setFont:buttonFont(button,YLSlideTitleViewTitleMin)];
        
        CGSize titleSize = [YLSlideTitleView boudingRectWithSize:CGSizeMake(SCREEN_WIDTH_YLSLIDE, YLSildeTitleViewHeight)
                                                           label:button.titleLabel];
        
        CGRect frame;
        frame.origin = CGPointMake(buttonWidth+5, 0);
        frame.size   = CGSizeMake(titleSize.width+20, 44);
        [button setFrame:frame];
        
        buttonWidth += CGRectGetWidth(button.frame);
        
        button.tag             = YLSlideTitleViewButtonTag + i;
        button.backgroundColor = [UIColor clearColor];
        
        [button addTarget:self
                   action:@selector(buttonEvents:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self configButtonWithOffsetx:0];
        
        [self addSubview:button];
    }
    
  
    
    self.contentSize = CGSizeMake(buttonWidth, YLSildeTitleViewHeight);
    
    __WEAK_SELF_YLSLIDE
    
    self.slideTitleViewScrollBlock =^(CGFloat offsetx){
        
        
        __STRONG_SELF_YLSLIDE
        [strongSelf configButtonWithOffsetx:offsetx];
        
    };
    
    self.slideViewWillScrollEndBlock =^(CGFloat offsetx){
    
        __STRONG_SELF_YLSLIDE
        
         NSUInteger currentPage   = offsetx/SCREEN_WIDTH_YLSLIDE;
        //设置 Button 可见
        UIButton * button=(UIButton *)[strongSelf viewWithTag:currentPage+YLSlideTitleViewButtonTag];
        
       CGFloat X = button.frame.origin.x;
     
        [strongSelf scrollRectToVisible:CGRectMake(X-strongSelf.frame.size.width/2.7, 0,
                                                   strongSelf.frame.size.width,
                                                   strongSelf.frame.size.height)
                               animated:YES];
        
    };
    
}

- (void)configButtonWithOffsetx:(CGFloat)offsetx{
    

    
//    NSLog(@"%f",offsetx);
    
    
    NSUInteger currentPage   = offsetx/SCREEN_WIDTH_YLSLIDE;
    
    CGFloat titleSizeSpacing = [self titleSizeSpacingWithOffsetx:offsetx/SCREEN_WIDTH_YLSLIDE];
//    NSLog(@"%f",titleSizeSpacing);
    if (_previousPage != currentPage) {
        
        UIButton * previousButton = (UIButton*)[self viewWithTag:_previousPage +YLSlideTitleViewButtonTag];
//        [previousButton.titleLabel setFont:[UIFont systemFontOfSize:(YLSlideTitleViewTitleMin)]];
        [previousButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]
                             forState:UIControlStateNormal];
        
    }
    
    UIButton * currentButton = (UIButton*)[self viewWithTag:currentPage+YLSlideTitleViewButtonTag];
    
//    CGRect rect=CGRectMake(currentButton.frame.origin.x, currentButton.frame.origin.y, currentButton.frame.size.width-titleSizeSpacing, currentButton.frame.size.height-titleSizeSpacing);
//    
//    [currentButton setFrame:rect];
    
//    [currentButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:(YLSlideTitleViewTitleMax-titleSizeSpacing)]];
    
//    currentButton.transform=CGAffineTransformMakeScale(1.2-(titleSizeSpacing), 1.2-(titleSizeSpacing));
    
//    [currentButton.titleLabel setFont:[UIFont systemFontOfSize:(YLSlideTitleViewTitleMax-titleSizeSpacing)]];
    
//    NSLog(@"%@",currentButton.titleLabel.font);
//    NSLog(@"%@",NSStringFromCGRect(currentButton.frame));
    // [currentButton.titleLabel setFont:buttonFont(currentButton,
    //YLSlideTitleViewTitleMax-titleSizeSpacing)];
    
    [currentButton setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    UIButton * nextButton =(UIButton*) [self viewWithTag:currentPage+1+YLSlideTitleViewButtonTag];
    
//    [nextButton.titleLabel setFont:[UIFont systemFontOfSize:(YLSlideTitleViewTitleMin+titleSizeSpacing)]];
    //[nextButton.titleLabel setFont:buttonFont(currentButton,
    // YLSlideTitleViewTitleMin+titleSizeSpacing)];
// CGSize  size =  CGSizeMake(52-titleSizeSpacing, 48-titleSizeSpacing);
//    nextButton.frame.size=size;
    
//   CGRect Rect=CGRectMake(nextButton.frame.origin.x, nextButton.frame.origin.y, nextButton.frame.size.width+titleSizeSpacing, nextButton.frame.size.height+titleSizeSpacing);
//    [nextButton setFrame:Rect];
    [nextButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
//     nextButton.transform=CGAffineTransformMakeScale(titleSizeSpacing+1, titleSizeSpacing+1);
    _previousPage = currentPage;
}

- (CGFloat)titleSizeSpacingWithOffsetx:(CGFloat)sx{
    
    NSInteger scale         = sx*100;
    CGFloat   currentScale  = (scale % 100) * 0.01 * 0.2;
//    CGFloat currentScale=2*sx;
    return currentScale;
}

- (void)buttonEvents:(UIButton*)button{
    
    self.isClickTitleButton = YES;
    
    if (_slideTitleViewClickButtonBlock) {
        _slideTitleViewClickButtonBlock(button.tag - YLSlideTitleViewButtonTag);
    }
    
    UIButton *previousButton = [self viewWithTag:_previousPage + YLSlideTitleViewButtonTag];
//    [[previousButton titleLabel]setFont:[UIFont systemFontOfSize:YLSlideTitleViewTitleMin]];
    [previousButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    previousButton.transform=CGAffineTransformMakeScale(1, 1);
    UIButton *currentButton = [self viewWithTag:button.tag];
//    [[currentButton titleLabel]setFont:[UIFont fontWithName:@"Helvetica-Bold" size:YLSlideTitleViewTitleMax]];
//    currentButton.transform=CGAffineTransformMakeScale(1.2, 1.2);
//     [[currentButton titleLabel]setFont:[UIFont systemFontOfSize: YLSlideTitleViewTitleMax]];
    
    [currentButton setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _previousPage = button.tag - YLSlideTitleViewButtonTag;
    
    CGFloat X = currentButton.frame.origin.x;
   
    [self scrollRectToVisible:CGRectMake(X-self.frame.size.width/2.7,0,self.frame.size.width,self.frame.size.height)animated:YES];

    
    
}

#pragma mark
+ (CGSize)boudingRectWithSize:(CGSize)size label:(UILabel*)label
{

    UIFont * font = label.font;
    font = [font fontWithSize:YLSlideTitleViewTitleMax];
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
