//
//  xiangqingyeViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/30.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "xiangqingyeViewController.h"
#import "HYPageView.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface xiangqingyeViewController ()

@end

@implementation xiangqingyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"介绍",@"相关知识",@"评论"] withViewControllers:@[@"introduceKnowledgeViewController",@"AboutKnowledgeTableViewController",@"NewCommentListTableViewController"] withParameters:@[@"123",@"这是一片很寂寞的天"]];
    pageView.selectedColor=[UIColor whiteColor];
    pageView.unselectedColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.72];
    pageView.topTabBottomLineColor=[UIColor whiteColor];
    pageView.leftSpace=10;
    pageView.rightSpace=10;
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 50, 40);
//    [leftButton setTintColor:[UIColor blackColor]];
    leftButton.transform = CGAffineTransformMakeScale(.7, .7);
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    pageView.leftButton = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setImage:[UIImage imageNamed:@"wexinshare"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 50, 40);
//    [rightButton setTintColor:[UIColor blackColor]];
    rightButton.transform = CGAffineTransformMakeScale(.5, .5);
    pageView.rightButton = rightButton;
    pageView.defaultSubscript = 0;
    [self.view addSubview: pageView] ;
    
    
    
}
-(void)back:(UIBarButtonItem *)button{


    [self.navigationController popViewControllerAnimated:YES];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{



    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
