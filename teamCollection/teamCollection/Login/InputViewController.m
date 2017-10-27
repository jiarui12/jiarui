//
//  InputViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "InputViewController.h"
#import "SettingViewController.h"
@interface InputViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSString * str;
@property(nonatomic,strong)UILabel * TimeLabel;
@property(nonatomic,strong)UIView * vi;
@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"填写验证码";
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0,70,self.view.frame.size.width, 40)];
    label.text=@"我们发送了验证码到您的手机：";
    label.textAlignment=NSTextAlignmentCenter;
     label.font=[UIFont systemFontOfSize:13.0];
    [self.view addSubview:label];
    UILabel * phoneNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,100, self.view.frame.size.width, 40)];
    
    phoneNumberLabel.text=self.phoneNumber;
    phoneNumberLabel.font=[UIFont systemFontOfSize:24];
    phoneNumberLabel.textAlignment=NSTextAlignmentCenter;
    
    NSLog(@"%@",self.phoneNumber);
    phoneNumberLabel.textColor=[UIColor greenColor];
    [self.view addSubview:phoneNumberLabel];
    UITextField * field=[[UITextField alloc]initWithFrame:CGRectMake(90,144, 250, 20)];
    field.keyboardType=UIKeyboardTypeNumberPad;
    
    field.placeholder=@"请填写验证码";
    [self.view addSubview:field];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(20, 200, self.view.frame.size.width-40, 40);
    [button setTitle:@"验证" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(NextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel* YanLabel=[[UILabel alloc]initWithFrame:CGRectMake(30,144 , 60, 20)];
    YanLabel.text=@"验证码";
    
    YanLabel.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:YanLabel];
    

    UIImageView*bacImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 125, self.view.frame.size.width-40, 42)];
    UIImage *image1 = [UIImage imageNamed:@"text_background_xi"];
    UIImage *image2 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    bacImage.image=image2;
    [self.view addSubview:bacImage];

    UIButton * YanButton=[UIButton buttonWithType:UIButtonTypeSystem];
    YanButton.frame=CGRectMake(0, 180, self.view.frame.size.width, 5);
    [YanButton setTitle:@"收不到验证码？" forState:UIControlStateNormal];
    [YanButton addTarget:self action:@selector(TryAgain:) forControlEvents:UIControlEventTouchUpInside];
    YanButton.titleLabel.font=[UIFont systemFontOfSize:12];

    [self.view addSubview:YanButton];
     _vi=[[UIView alloc]initWithFrame:CGRectMake(0, 175, self.view.frame.size.width, 20)];
    _vi.backgroundColor=[UIColor whiteColor];
    self. TimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, self.view.frame.size.width, 10)];
    self.TimeLabel.font=[UIFont systemFontOfSize:13];
    self.TimeLabel.textAlignment=NSTextAlignmentCenter;
    [_vi addSubview: self.TimeLabel];
    [self.view addSubview:_vi];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
  
}
int i=5;
-(void)testTimer{
    i--;
    _str=[NSString stringWithFormat:@"短信接收大概需要%d秒钟",i];
  self.TimeLabel.text=_str;
    if (i==0||i<0) {
        [_vi removeFromSuperview];
    }
}

-(void)TryAgain:(UIButton*)button{
    UIAlertView* av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"重新发送验证码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    av.delegate=self;
    [av show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSLog(@"确定");
    }if (buttonIndex==0) {
        NSLog(@"取消");
    }

}
-(void)NextStep:(UIButton*)button{

    SettingViewController * setting=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
@end
