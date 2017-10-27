//
//  SettingViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"设置新密码";
    int y=130;
    UITextField * field=[[UITextField alloc]init];
    field.frame=CGRectMake(80, y-2.5, 300, 20);
    field.backgroundColor=[UIColor whiteColor];
    field.placeholder=@"请输入6-12位数字或字母";
    
    field.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:field];
 
    
    UITextField * field2=[[UITextField alloc]init];
    field2.frame=CGRectMake(95, y+47.5, 300, 20);
    field2.backgroundColor=[UIColor whiteColor];
    field2.placeholder=@"请再次确认您的密码";
    
    field.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:field2];

    UIImageView*bacImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, y-15, self.view.frame.size.width-40, 42)];
    UIImage *image1 = [UIImage imageNamed:@"text_background_xi"];
    UIImage *image2 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    bacImage.image=image2;
    [self.view addSubview:bacImage];
    UIImageView*bacImage1=[[UIImageView alloc]initWithFrame:CGRectMake(20, y+35,self.view.frame.size.width-40 , 42)];
    bacImage1.image=image2;
    [self.view addSubview:bacImage1];
    
    UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame=CGRectMake(20, y+100, self.view.frame.size.width-40, 40);
    [button3 setTitle:@"确定" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button3.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [button3 addTarget:self action:@selector(ActivateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UILabel* YanLabel=[[UILabel alloc]initWithFrame:CGRectMake(30,y-2, 60, 20)];
    YanLabel.text=@"新密码";
    YanLabel.font=[UIFont systemFontOfSize:15];
    YanLabel.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:YanLabel];
    UILabel* YanLabel1=[[UILabel alloc]initWithFrame:CGRectMake(30,y+48, 80, 20)];
    YanLabel1.text=@"确认密码";
    YanLabel1.font=[UIFont systemFontOfSize:15];
    YanLabel1.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:YanLabel1];
}
-(void)ActivateClick:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
   
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
