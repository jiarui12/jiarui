//
//  NewRegisterViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/16.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewRegisterViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import "WKProgressHUD.h"
#import "InputCodeViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewRegisterViewController ()
@property(nonatomic,strong)UIView * phoneView;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UIButton *LoginBtn;
@end

@implementation NewRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"新用户注册";
    
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*105/667 , WIDTH*55/375, HEIGHT*17.5/667)];
    phoneLabel.text=@"手机号";
    if ([UIScreen mainScreen].bounds.size.width<360) {
        phoneLabel.font=[UIFont systemFontOfSize:14];
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
    
    UIButton * LoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"LoginBtnPress"] forState:UIControlStateHighlighted];
    LoginButton.tag=200;
    LoginButton.enabled=NO;
    LoginButton.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];LoginButton.frame=CGRectMake(WIDTH*10/375, HEIGHT*179/667, WIDTH*355/375, HEIGHT*40/667);
    LoginButton.layer.cornerRadius=4.5;
    [LoginButton setTitle:@"下一步" forState:UIControlStateNormal];
    [LoginButton setTitle:@"下一步" forState:UIControlStateHighlighted];
    LoginButton.titleLabel.font=[UIFont systemFontOfSize:18];
    
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton setTitleColor:[UIColor colorWithRed:174/255.0 green:173/255.0 blue:174/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [LoginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginButton];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    

    UILabel *shuoming=[[UILabel alloc]init];
    shuoming.frame=CGRectMake(WIDTH*10/375, HEIGHT*220/667, WIDTH*355/375, HEIGHT*60/667);
    
    
    
    shuoming.text=@"注:该产品是与企业内部合作的平台，注册是核实企业成员的真实信息，不存在任何私自购买或订阅外部机制流程。";
    
    shuoming.font=[UIFont systemFontOfSize:13];
    shuoming.numberOfLines=0;
    shuoming.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    
    [self.view addSubview:shuoming];
    //    [self.view addSubview:_codeBtn];

}
-(void)Back:(UIBarButtonItem*)button{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Login:(UIButton *)button{
    
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    BOOL isMatch = [pred evaluateWithObject:self.phoneField.text];
//    
//    if (!isMatch) {
//        [MBProgressHUD showError:@"请输入正确的手机号"];
//        return;
//    }
      WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    
    NSLog(@"%@",self.phoneField.text);
    
    
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
//    [user setObject:self.phoneField.text forKey:@"fastLoginCode"];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/send_sms_anyway?phone=%@",URLDOMAIN,self.phoneField.text];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud dismiss:YES];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dic);
        if ([dic[@"ret"] isEqualToString:@"phone_not_found"]) {
            [MBProgressHUD showError:@"手机号不存在"];
            return;
            
        }
        if ([dic[@"ret"] isEqualToString:@"phone_is_existd"]) {
            [MBProgressHUD showError:@"手机号已被注册"];
            return;
 
        }
        if ([dic[@"state"] isEqualToString:@"2"]) {
            [MBProgressHUD hideHUD];
        
            InputCodeViewController * input=[[InputCodeViewController alloc]init];
            input.category=@"register";
            input.phoneNumber=self.phoneField.text;
            
            
            
            [self.navigationController pushViewController:input animated:YES];
            
            
            
            
        }if ([dic[@"state"] isEqualToString:@"4085"]) {
            [MBProgressHUD showError:@"短信条数已用完，请明天再试"];
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

-(void)textFieldDidChange:(UITextField*)field{
    
    
    
    if (field == self.phoneField) {
        if (field.text.length > 11) {
            field.text = [field.text substringToIndex:11];
        }
        if (field.text.length==11) {
            
            UIButton * button=[self.view viewWithTag:200];
            button.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
            button.enabled=YES;
            
        }else if(field.text.length<11){
            UIButton * button=[self.view viewWithTag:200];
            button.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];
            button.enabled=NO;
            
        }
        
        
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    
}
@end
