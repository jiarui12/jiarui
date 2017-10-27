//
//  SupportViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SupportViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.navigationItem.title=@"联系我们";
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel * we=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *100/375,WIDTH *220/375,WIDTH* 100/375,WIDTH* 40/375)];
    we.font=[UIFont systemFontOfSize:WIDTH* 14/375];
    we.backgroundColor=[UIColor whiteColor];
    we.text=@"联系我们：";
    [self.view addSubview:we];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(WIDTH* 150/375,WIDTH *220/375,WIDTH *140/375,WIDTH *40/375);
    [button setTitle:@"400-650-1308" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Telphone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel * email=[[UILabel alloc]initWithFrame:CGRectMake(0,WIDTH* 280/375,WIDTH,WIDTH *40/375)];
    email.font=[UIFont systemFontOfSize:WIDTH *14/375];
    email.textAlignment=NSTextAlignmentCenter;
    email.text=@"联系邮箱：ljb@89mc.com";
    [self.view addSubview:email];
   
    UILabel * weixin=[[UILabel alloc]initWithFrame:CGRectMake(0,WIDTH *340/375,WIDTH,WIDTH* 40/375)];
    weixin.font=[UIFont systemFontOfSize:WIDTH *14/375];
    weixin.text=@"微信公众号：班组汇";
    weixin.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:weixin];
    UILabel * banzu=[[UILabel alloc]init];
    banzu.frame=CGRectMake(0,WIDTH *170/375, WIDTH,WIDTH *40/375);
    banzu.text=@"班组汇";
    banzu.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:banzu];
    UIImageView * headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-WIDTH* 40/375,WIDTH *80/375,WIDTH* 80/375,WIDTH* 80/375)];
    headImage.layer.cornerRadius=10;
    headImage.clipsToBounds=YES;
    headImage.image=[UIImage imageNamed:@"lianxiwomenlogo"];
    [self.view addSubview:headImage];
}
-(void)Telphone:(UIButton*)button{
    
    NSString *number = @"4006501308";
    
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; 
    

}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=NO;
   self.navBarBgAlpha=@"1.0";
}
@end
