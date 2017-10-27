//
//  SupportViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"技术支持";
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel * we=[[UILabel alloc]initWithFrame:CGRectMake(50, 200, 70, 40)];
    we.font=[UIFont boldSystemFontOfSize:14];
    we.backgroundColor=[UIColor whiteColor];
    we.text=@"联系我们：";
    [self.view addSubview:we];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(100, 200, 140, 40);
    [button setTitle:@"400-701-2389" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Telphone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel * email=[[UILabel alloc]initWithFrame:CGRectMake(50, 260, 240, 40)];
    email.font=[UIFont boldSystemFontOfSize:14];
    email.text=@"联系邮箱：ljb@89mc.com";
    [self.view addSubview:email];
   
    UILabel * weixin=[[UILabel alloc]initWithFrame:CGRectMake(50, 320, 240, 40)];
    weixin.font=[UIFont boldSystemFontOfSize:14];
    weixin.text=@"微信平台：bajiudianguanlizixun";
    [self.view addSubview:weixin];
    UILabel * banzu=[[UILabel alloc]init];
    banzu.frame=CGRectMake(0, 150, self.view.frame.size.width, 40);
    banzu.text=@"班组汇";
    banzu.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:banzu];
    UIImageView * headImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 80, 80, 80)];
    headImage.image=[UIImage imageNamed:@"ic_launcher"];
    [self.view addSubview:headImage];
}
-(void)Telphone:(UIButton*)button{
    
    NSString *number = @"4007012389";
    
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; 
    

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
