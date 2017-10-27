//
//  JRTabBarController.m
//  teamCollection
//
//  Created by 八九点 on 2017/2/15.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "JRTabBarController.h"
#import "NewFristViewController.h"
#import "JRNavigationController.h"
#import "NewBagViewController.h"
#import "errorViewController.h"
#import "MemberViewController.h"
#import "NewNewSetViewController.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface JRTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)JRNavigationController * nav1;
@property(nonatomic,strong)JRNavigationController * nav2;
@property(nonatomic,strong)JRNavigationController * nav3;
@property(nonatomic,strong)JRNavigationController * nav4;
@property(nonatomic,strong)JRNavigationController * nav5;
//@property(nonatomic,strong)UINavigationController * nav1;
//@property(nonatomic,strong)UINavigationController * nav2;
//@property(nonatomic,strong)UINavigationController * nav3;
//@property(nonatomic,strong)UINavigationController * nav4;
//@property(nonatomic,strong)UINavigationController * nav5;

@property(nonatomic,strong)UIButton *Btn;
@end

@implementation JRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.delegate=self;
    

    
    
    NewFristViewController* frist=[[NewFristViewController alloc]init];
    
    frist.view.backgroundColor=[UIColor whiteColor];
    frist.tabBarItem.title=@"首页";
    frist.tabBarItem.image=[UIImage imageNamed:@"shouye"];
    frist.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_over"];
    
    _nav1=[[JRNavigationController alloc]initWithRootViewController:frist];
    
    
    
    
    NewBagViewController* member=[[NewBagViewController alloc]init];
    
    member.view.backgroundColor=[UIColor whiteColor];
    member.tabBarItem.title=@"学习";
    member.tabBarItem.image=[UIImage imageNamed:@"shubao"];
    member.tabBarItem.selectedImage=[UIImage imageNamed:@"shunbao_over"];
    _nav2=[[JRNavigationController alloc]initWithRootViewController:member];
    
    
    
 
    
    errorViewController* error=[[errorViewController alloc]init];
    _nav3=[[JRNavigationController alloc]initWithRootViewController:error];
    
    MemberViewController* my=[[MemberViewController alloc]init];
    my.view.backgroundColor=[UIColor whiteColor];
    my.tabBarItem.title=@"标杆";
    my.tabBarItem.image=[UIImage imageNamed:@"biaogan"];
    my.tabBarItem.selectedImage=[UIImage imageNamed:@"biaogan_over"];
    _nav4=[[JRNavigationController alloc]initWithRootViewController:my];
    
    NewNewSetViewController* more=[[NewNewSetViewController alloc]init];
    more.view.backgroundColor=[UIColor whiteColor];
    more.tabBarItem.title=@"我的";
    
    more.tabBarItem.image=[UIImage imageNamed:@"wode"];
    more.tabBarItem.selectedImage=[UIImage imageNamed:@"wode_over"];
    _nav5=[[JRNavigationController alloc]initWithRootViewController:more];
    
    _nav1.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    _nav2.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    _nav3.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    _nav4.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    _nav5.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    [_nav1.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [_nav2.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [_nav3.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [_nav4.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [_nav5.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 30/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _nav1.navigationController.interactivePopGestureRecognizer.enabled = YES;
    _nav2.navigationController.interactivePopGestureRecognizer.enabled = YES;
    _nav3.navigationController.interactivePopGestureRecognizer.enabled = YES;
    _nav4.navigationController.interactivePopGestureRecognizer.enabled = YES;
    _nav5.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self addChildViewController:_nav1];
    [self addChildViewController:_nav2];
    [self addChildViewController:_nav3];
    [self addChildViewController:_nav4];
    [self addChildViewController:_nav5];
   
//    self.viewControllers=@[_nav1,_nav2,_nav3,_nav4,_nav5];
     UIImageView * centerImage=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-27.5, -12.8, 55, 60)];
    centerImage.image=[UIImage imageNamed:@"image_center"];
    centerImage.userInteractionEnabled=YES;
    centerImage.tag=130;
    [self.tabBar addSubview:centerImage];
    
    _Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _Btn.frame=CGRectMake(6.5, 12, 42, 42);
    self.tabBar.backgroundColor=[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    self.tabBar.barTintColor=[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    [_Btn setBackgroundImage:[UIImage imageNamed:@"hui"] forState:UIControlStateNormal];
    [_Btn addTarget:self action:@selector(center:) forControlEvents:UIControlEventTouchUpInside];
    [_Btn setBackgroundImage:[UIImage imageNamed:@"hui_over"] forState:UIControlStateSelected];
    [_Btn setBackgroundImage:[UIImage imageNamed:@"hui_over"] forState:UIControlStateHighlighted];
    _Btn.tag=120;
    [centerImage addSubview:_Btn];
  
}
-(void)center:(UIButton *)button{
    
    
    if (button.selected==YES) {
        return;
    }
    if (button.selected==NO) {
        self.selectedIndex=2;
        
        button.selected=YES;
    }
    if (self.selectedIndex!=2) {
        
        button.selected=NO;
    }
    
    
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    
    
    if (tabBarController.selectedIndex!=2) {
        _Btn.selected=NO;
    }else{
        _Btn.selected=YES;
    }
   
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tabbarClick" object:nil userInfo:@{@"Click":[NSString stringWithFormat:@"%lu",(unsigned long)tabBarController.selectedIndex]}];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{

   

}

-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}
@end
@implementation UINavigationController (Rotation)


- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}
@end
