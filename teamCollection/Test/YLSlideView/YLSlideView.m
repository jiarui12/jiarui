

#import "YLSlideView.h"
#import "YLSlideTitleView.h"
#import "YGPCache.h"
#import "JRKnowLedgeTableViewController.h"
@interface YLSlideView()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGPoint      _beginScrollOffset;
    NSInteger    _totaiPageNumber;   //内容总数
//    NSMutableSet *_visibleCells;     //可见
//    NSMutableSet *_recycledCells;    //循环
    NSArray      *_titles;
    NSUInteger   _prePageIndex;
    NSMutableArray * _node_ids;
    NSMutableArray * _viewControllers;
}

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic,strong)NSMutableArray * viewControllers;


- (BOOL)isVisibleCellForIndex:(NSUInteger)index;
- (void)configCellWithCell:(YLSlideCell*)cell forIndex:(NSUInteger)index;



@end
static NSString *CellID = @"ControllerCell";
@implementation YLSlideView
-(void)setParentController:(UIViewController *)parentController{
    
    
    
    [parentController addChildViewController:self];
    [parentController.view addSubview:self.view];

}
+ (instancetype)initWithparentController:(UIViewController*)vc forTitles:(NSArray *)titles andNodeIds:(NSArray<UIViewController *> *)viewControllers{

    
    
    id contain=[[self alloc]initWithTitles:titles];

    [contain setViewControllers:viewControllers];

    
    
    
    [contain setParentController:vc];

    
    
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [contain addChildViewController:obj];

    }];

    
    return contain;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"delegate"]) {
        [self reloadData];
    }
}
- (void)dealloc{
   
}
#pragma mark RecycledCell




- (BOOL)isVisibleCellForIndex:(NSUInteger)index{

    BOOL isVisibleCell = NO;
    
//    for (YLSlideCell * cell in _visibleCells) {
//        
//        if (cell.index == index) {
//            isVisibleCell = YES;
//            break;
//        }
//        
//    }
    return isVisibleCell;
}

//- (YLSlideCell*)visibleCellForIndex:(NSUInteger)index{
//
//    YLSlideCell * visibleCell = nil;
//
//
////    for (YLSlideCell * cell in _visibleCells) {
////        
////        if (cell.index == index) {
////            visibleCell = cell;
////            break;
////        }
////    }
//    return visibleCell;
//}

- (void)configCellWithCell:(YLSlideCell*)cell forIndex:(NSUInteger)index{
    
    
}

#pragma make reloadData

- (void)reloadData{

}

//- (void)visibleViewDelegateForIndex:(NSUInteger)index{
//
//    if (_prePageIndex != index) {
//        if ([_delegate respondsToSelector:@selector(slideVisibleView:forIndex:)]) {
//            [_delegate slideVisibleView:[self visibleCellForIndex:index] forIndex:index];
//        }
//    }
//    
//    _prePageIndex = index;
//
//}

#pragma mark UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _slideTitleView.isClickTitleButton = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    


    if (!_slideTitleView.isClickTitleButton) {
        if (_slideTitleView.slideTitleViewScrollBlock) {
            _slideTitleView.slideTitleViewScrollBlock(scrollView.contentOffset.x);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
//    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
//    [self visibleViewDelegateForIndex:currentPage];

    if (_slideTitleView.slideViewWillScrollEndBlock) {
        _slideTitleView.slideViewWillScrollEndBlock(scrollView.contentOffset.x);
    }
    
}

#pragma mark configSlideView

- (instancetype)initWithTitles:(NSArray *)titles{


    
    if (self=[super init]) {
        self.mainScrollview = ({
            
          
            
            
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            _flowLayout = flowLayout;
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flowLayout.minimumLineSpacing = 0;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-40-64-49);
            //设置collectionView的属性
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, YLSildeTitleViewHeight+64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-YLSildeTitleViewHeight-64-49) collectionViewLayout:flowLayout];
            collectionView.pagingEnabled = YES;
            _collectionView = collectionView;
            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.backgroundColor=[UIColor whiteColor];
            collectionView.showsHorizontalScrollIndicator = NO;
            collectionView;
            
            
            
        });
        
        
        [self.view addSubview:_mainScrollview];
        
        self.slideTitleView = ({
            
            CGRect slideTitleFrame;
            slideTitleFrame.origin = CGPointMake(0, 64);
            slideTitleFrame.size   = CGSizeMake(CGRectGetWidth(self.view.frame), 40);
            
            YLSlideTitleView * slideTitleView = [[YLSlideTitleView alloc]initWithFrame:slideTitleFrame forTitles:titles];
            
            slideTitleView;
        });
        
        
        
        
        
        
        
        
        [self.view addSubview:_slideTitleView];
        
        __WEAK_SELF_YLSLIDE
        // slideTitleView 栏目button 点击的监听
        // 滚动到指定的栏目下
        _slideTitleView.slideTitleViewClickButtonBlock = ^(NSUInteger index){
            
            if (weakSelf) {
                
                __STRONG_SELF_YLSLIDE
                CGRect frame   = strongSelf.mainScrollview.bounds;
                frame.origin.x = CGRectGetWidth(strongSelf.view.frame) * index;
                
                [strongSelf.mainScrollview scrollRectToVisible:frame animated:NO];
//                [strongSelf visibleViewDelegateForIndex:index];
            }
        };

    }
    
    return self;
  
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *view = [self.viewControllers[indexPath.item] view];
    
    
    
    [cell.contentView addSubview:view];
    
    view.frame = cell.bounds;
    
    return cell;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewControllers.count;
  
}
#pragma mark Set Get
- (void)setShowsScrollViewHorizontalScrollIndicator:(BOOL)showsScrollViewHorizontalScrollIndicator{
    
    _mainScrollview.showsHorizontalScrollIndicator = showsScrollViewHorizontalScrollIndicator;

}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //禁用滚动到最顶部的属性
    self.collectionView.scrollsToTop = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  

    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com