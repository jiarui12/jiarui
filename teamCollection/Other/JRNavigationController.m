//
//  JRNavigationController.m
//  teamCollection
//
//  Created by 八九点 on 2017/2/15.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "JRNavigationController.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
@interface JRNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    JRNavigationController * jr=[[JRNavigationController alloc]init];
    
    jr.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    
    
    [jr.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
}
+ (void)initialize
{
  
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//    
//
//    
//    NSLog(@"%@",viewController);
//    
//    if (self.viewControllers.count) {
//        
//        
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        
//        
//    }
//    
//    [super pushViewController:viewController animated:animated];
//
//    
//    
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
