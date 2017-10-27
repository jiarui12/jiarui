//
//  InitializationViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/8/9.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "InitializationViewController.h"
#import "NewLoginViewController.h"
#import "NewFristViewController.h"
#import "NewBagViewController.h"

#import "errorViewController.h"
#import "NewNewSetViewController.h"
#import "JRTabBarController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface InitializationViewController ()<UIScrollViewDelegate,UITabBarControllerDelegate>

@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)JRTabBarController * tab;
@property(nonatomic,strong)UINavigationController * nav1;
@property(nonatomic,strong)UINavigationController * nav2;
@property(nonatomic,strong)UINavigationController * nav3;
@property(nonatomic,strong)UINavigationController * nav4;
@property(nonatomic,strong)UINavigationController * nav5;
@property(nonatomic,strong)UIButton * Btn;
@end

@implementation InitializationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * imagearr=@[@"waitting_1",@"waitting_2",@"waitting_3",@"waitting_4"];
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image=[UIImage imageNamed:@"diyicidenglu"];
    [self.view addSubview:image];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    
    //    获取所有除与调度中的数组
    NSArray *locationArr = app.scheduledLocalNotifications;
    if (locationArr)
    {
        for (UILocalNotification *ln in locationArr)
        {
            NSDictionary *dict =  ln.userInfo;
            
            if (dict)
            {
                NSString *obj = [dict objectForKey:@"type"];
                
                if ([obj isEqualToString:@"alarm"])
                {
                    
                    
                    //取消调度通知
                    [app cancelLocalNotification:ln];
                }
            }
        }
    }
    _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    for (int i=0; i<imagearr.count; i++) {
        
        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        image.image=[UIImage imageNamed:imagearr[i]];
        image.userInteractionEnabled=YES;
        if (i==imagearr.count-1) {
            UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(self.view.frame.size.width/2-120/2,HEIGHT *530/667,120, 45) ;
            [button setBackgroundImage:[UIImage imageNamed:@"weidianji"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"dianji"] forState:UIControlStateHighlighted];
            [image addSubview:button];
            [button addTarget:self action:@selector(jinru:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        [_scrollView addSubview:image];
        
        
        
    }
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(WIDTH*imagearr.count, HEIGHT);
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    
    _pageControl.center=CGPointMake(WIDTH/2, HEIGHT *590/667);
    _pageControl.numberOfPages=[imagearr count];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:28/255.0 green:174/255.0 blue:242/255.0 alpha:1.0];
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1.0];


   
[self.view addSubview:_scrollView];
}
-(void)jinru:(UIButton *)button{
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    if (token.length>0) {
        [self creatTab];
        [UIApplication sharedApplication].keyWindow.rootViewController=_tab;
    }else{
        [self creatTab];
        [UIApplication sharedApplication].keyWindow.rootViewController=_tab;

    }
    
    NSString* version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [user setObject:version forKey:@"localVersion"];
    
    [UIView animateWithDuration:1.5 animations:^{
        _scrollView.alpha=0.0;
    } completion:^(BOOL finished) {
        
    }];

    
   
}
-(void)creatTab{
    
    _tab=[[JRTabBarController alloc]init];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.pageControl.currentPage = currentPage;
}

@end
