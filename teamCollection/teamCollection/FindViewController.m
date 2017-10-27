//
//  FindViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "FindViewController.h"
#import "InputViewController.h"
@interface FindViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * field;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"找回密码";
   _field=[[UITextField alloc]init];
    _field.frame=CGRectMake(90, 127.5, 250, 20);
    _field.keyboardType=UIKeyboardTypeNumberPad;
    _field.delegate=self;
    
    

    
    
    _field.placeholder=@"请填写11位手机号";
    [self.view addSubview:_field];
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 127.5, 60, 20)];
    phoneLabel.text=@"手机号";
    phoneLabel.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    
    
    
   
    
    
    
    [self.view addSubview:phoneLabel];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(20, 200, self.view.frame.size.width-40, 40);
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(NextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel * detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 150, 250, 40)];
    detailLabel.text=@"您的手机将会收到短信验证码";
    detailLabel.font=[UIFont systemFontOfSize:14.0];
    [self.view addSubview:detailLabel];

    
    UIImageView*bacImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 110, self.view.frame.size.width-40, 42)];
    UIImage *image1 = [UIImage imageNamed:@"text_background_xi"];
    UIImage *image2 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    bacImage.image=image2;
    [self.view addSubview:bacImage];
    
}
-(void)NextStep:(UIButton *)button{
    [self.view endEditing:YES];
    InputViewController  * Input=[[InputViewController alloc]init];
    NSString * s= _field.text;
    Input.phoneNumber=s;
    [self.navigationController pushViewController:Input animated:YES];
}
-(void )touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
    
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
