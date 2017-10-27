//
//  ShakeViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/2/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "ShakeViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "UIImageView+WebCache.h"
@interface ShakeViewController ()
@property(nonatomic,strong)UIImageView * UpBigImageView;
@property(nonatomic,strong)UIImageView * DownBigImageView;
@property(nonatomic,strong)UIView * shakeView;
@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * flowerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-47.5, self.view.frame.size.height/2-90, 95, 180)];
    flowerImageView.image=[UIImage imageNamed:@"shake_bg_flower"];
    [self.view addSubview:flowerImageView];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
   self.navigationItem.title=@"摇一摇";
   self.UpBigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, (self.view.frame.size.height-64)/2)];
    self.UpBigImageView.image=[UIImage imageNamed:@"shake_top_normal"];
    
    UIImageView * UpSmallImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, (self.view.frame.size.height-64)/2-125, 250, 125)];
    UpSmallImageView.image=[UIImage imageNamed:@"shake_img_up"];
    [self.UpBigImageView addSubview:UpSmallImageView];
    
    [self.view addSubview:self.UpBigImageView];
    self.DownBigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64+((self.view.frame.size.height-64)/2), self.view.frame.size.width, 64+((self.view.frame.size.height-64)/2)) ];
    self.DownBigImageView.image=[UIImage imageNamed:@"shake_bottom_normal"];
    [self.view addSubview:self.DownBigImageView];
    
    UIImageView * DownSmallImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 0, 250, 125)];
    DownSmallImageView.image=[UIImage imageNamed:@"shake_img_down"];
    [self.DownBigImageView addSubview:DownSmallImageView];
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self.shakeView removeFromSuperview];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    NSDictionary * pamater=[NSDictionary dictionaryWithObject:token forKey:@"token"];
    NSString * url=[NSString stringWithFormat:@"%@:8080/BagServer/shakeKnowledge.mob",URLDOMAIN];

    
    
   [manager GET:url parameters:pamater progress:^(NSProgress * _Nonnull downloadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"%@",responseObject);
       NSDictionary * dic=(NSDictionary *)responseObject;
       self.shakeView=[[UIView alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height-64)/2+210 , self.view.frame.size.width-40,80)];
       self.shakeView.backgroundColor=[UIColor redColor];
       UIImageView * iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,70,70)];
       [iconImageView setImageWithURL:[NSURL URLWithString:dic[@"iconURL"]] placeholderImage:[UIImage imageNamed:@"material_default_pic_2"]];
       [self.shakeView addSubview:iconImageView];
       UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(80, 5, 200, 20)];
       label.font=[UIFont systemFontOfSize:15.0];
       label.text=dic[@"title"];
       label.backgroundColor=[UIColor greenColor];
       [self.shakeView addSubview:label];
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error);
   }];
    [UIView animateWithDuration:1 animations:^{
        self.UpBigImageView.frame=CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-64)/2);
        self.DownBigImageView.frame=CGRectMake(0, 64+((self.view.frame.size.height-64)/2)+64, self.view.frame.size.width, 64+((self.view.frame.size.height-64)/2));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.UpBigImageView.frame=CGRectMake(0, 64, self.view.frame.size.width, (self.view.frame.size.height-64)/2);
            self.DownBigImageView.frame=CGRectMake(0, ((self.view.frame.size.height-64)/2)+64, self.view.frame.size.width, 64+((self.view.frame.size.height-64)/2));
        }completion:^(BOOL finished) {
            [self.view addSubview:self.shakeView];
        }];
    }];
    
    
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"结束");
    
}
-(void)Back:(UIBarButtonItem * )button{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
