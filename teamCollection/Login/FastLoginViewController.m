//
//  FastLoginViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "FastLoginViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import "JKCountDownButton.h"
#import "WKProgressHUD.h"
#import "InputCodeViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface FastLoginViewController ()
@property(nonatomic,strong)UIView * phoneView;
@property(nonatomic,strong)UIView * passWordView;
@property(nonatomic,strong)UIButton * LoginBtn;
@property(nonatomic,strong)JKCountDownButton * codeBtn;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UITextField * yanField;


@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)int second;

@end

@implementation FastLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"手机快速登录";
    
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*105/667 , WIDTH*55/375, HEIGHT*17.5/667)];
    phoneLabel.text=@"手机号";
    if ([UIScreen mainScreen].bounds.size.width<350) {
        phoneLabel.font=[UIFont systemFontOfSize:15];
    }
    
    
    phoneLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    [self.view addSubview:phoneLabel];
    
    
    _phoneView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*66/375,HEIGHT*126/667 , WIDTH*300/375, 1)];
    _phoneView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.view addSubview:_phoneView];
    

    
    _phoneField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*66/375, HEIGHT*98/667, WIDTH*299/375, HEIGHT*32/667)];
    
    _phoneField.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    _phoneField.keyboardType=UIKeyboardTypeNumberPad;
    _phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneField];
    
    
    _LoginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _LoginBtn.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];
    _LoginBtn.frame=CGRectMake(WIDTH*10/375, HEIGHT*179/667, WIDTH*355/375, HEIGHT*40/667);
    _LoginBtn.layer.cornerRadius=4.5;
    [_LoginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _LoginBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    _LoginBtn.tag=200;
    _LoginBtn.enabled=NO;
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn setBackgroundImage:[UIImage imageNamed:@"点击后"] forState:UIControlStateHighlighted];
    [_LoginBtn addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_LoginBtn];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    
    
}
-(void)testTimer{
   
    
    
    
}
-(void)Login:(UIButton *)button{
   
    

    
  WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    
    
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/send_sms?phone=%@",URLDOMAIN,self.phoneField.text];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [hud dismiss:YES];
        
        if ([dic[@"ret"] isEqualToString:@"phone_not_found"]) {
            
            [MBProgressHUD showError:@"手机号不存在"];
            return;
            
        }
        
        if ([dic[@"state"] isEqualToString:@"2"]) {
           
            
           
            InputCodeViewController * input=[[InputCodeViewController alloc]init];
            
            input.category=@"fast";
            input.phoneNumber=_phoneField.text;
            [self.navigationController pushViewController:input animated:YES];
            
            
        
            
            
            
            
        }if ([dic[@"state"] isEqualToString:@"4085"]) {
            
            [hud dismiss:YES];
            [MBProgressHUD showError:@"短信条数已用完，请明天再试"];
            return;
        }if ([dic[@"state"] isEqualToString:@"406"]) {
            
            [hud dismiss:YES];
            [MBProgressHUD showError:@"请输入正确的手机号"];
            return;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [hud dismiss:YES];
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
    
    

    
    
    

    
}
-(void)textFieldDidChange:(UITextField *)field{
    if (field.text.length==11) {
        
        UIButton * button=[self.view viewWithTag:200];
        button.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        button.enabled=YES;
        
    }else if(field.text.length<11){
        UIButton * button=[self.view viewWithTag:200];
        button.backgroundColor= [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        button.enabled=NO;
        
    }
    if (field == self.phoneField) {
        if (field.text.length > 11) {
            field.text = [field.text substringToIndex:11];
        }
    }

}
-(void)Back:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:YES];
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.phoneField becomeFirstResponder];
    
    self.tabBarController.tabBar.hidden=YES;
    
    
}
@end