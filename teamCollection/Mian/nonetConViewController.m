//
//  nonetConViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/8/8.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "nonetConViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface nonetConViewController ()

@end

@implementation nonetConViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"无网络连接";
    self.view .backgroundColor=[UIColor whiteColor];
    UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 17/320, 64+WIDTH *15/320, WIDTH,HEIGHT *20/568)];
    frist.text=@"请设置你的网络";
    frist.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
    [self.view addSubview:frist];
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 17/320, 64+HEIGHT *42.5/568, WIDTH,HEIGHT* 15/568)];
    
    second.text=@"1.打开设备的\"系统设置\">\"无线局域网\">\"打开\"。";
    second.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    second.font=[UIFont systemFontOfSize:15];
    
    [self.view addSubview:second];
    
    UILabel * third=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 17/320, 64+HEIGHT *65/568, WIDTH*285/320,HEIGHT* 40/568)];
    third.numberOfLines=2;
    third.text=@"2.打开设备的\"系统设置\">\"WLAN\",\"启动WLAN\"后从中选择一个可用的热点连接。";
    third.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    third.font=[UIFont systemFontOfSize:15];
    
    [self.view addSubview:third];
    
    UIView * midView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*110/568, WIDTH,HEIGHT *12.5/568)];
    midView.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.view addSubview:midView];
    UILabel * forth=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 17/320, 64+HEIGHT *137.5/568, WIDTH,HEIGHT *20/568)];
    forth.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
    forth.text=@"如果你已经连接Wi-Fi网络";
    [self.view addSubview:forth];
    
    UILabel * fifth=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 17/320, 64+HEIGHT *165/568, WIDTH*285/320,HEIGHT* 40/568)];
    fifth.text=@"请确认你所接入的Wi-Fi网络已经进入互联网，或者确认你的设备是否被允许访问该热点";
    fifth.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    fifth.numberOfLines=2;
    fifth.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:fifth];
    
    
    
    
}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden=YES;
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
