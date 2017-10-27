//
//  InputCodeViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/15.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "NewSetPassWordViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "InputPassWordViewController.h"
#import "InputCodeViewController.h"
#import "JKCountDownButton.h"
#import "MBProgressHUD+HM.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "WKProgressHUD.h"
#import "FristViewController.h"
#import "NewBagViewController.h"
#import "errorViewController.h"
#import "NewNewSetViewController.h"
#import "JRTabBarController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface InputCodeViewController ()<UITabBarControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)JKCountDownButton*codeBtn;
@property(nonatomic,strong)UITextField * field;
@property(nonatomic,strong)JRTabBarController * tab;
@property(nonatomic,strong)UINavigationController * nav1;
@property(nonatomic,strong)UINavigationController * nav2;
@property(nonatomic,strong)UINavigationController * nav3;
@property(nonatomic,strong)UINavigationController * nav4;
@property(nonatomic,strong)UINavigationController * nav5;
@property(nonatomic,strong)UIButton *Btn;
@property(nonatomic,strong) WKProgressHUD *hud;

@end

@implementation InputCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    self.navigationItem.title=@"填写验证码";
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*25/667, self.view.frame.size.width, 12.5)];
    label.text=[NSString stringWithFormat:@"验证码已发送到手机%@",self.phoneNumber];
    label.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton * butt=[UIButton buttonWithType:UIButtonTypeSystem];
    butt.frame=CGRectMake(WIDTH*41/375,64+ HEIGHT*55/667, WIDTH*293/375,  HEIGHT*51.5/667);
    butt.backgroundColor=[UIColor clearColor];
    [butt addTarget:self action:@selector(tanchu:) forControlEvents:UIControlEventTouchUpInside];
   
    UILabel * bigLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*41/375,64+ HEIGHT*55/667, WIDTH*293/375,  HEIGHT*51.5/667)];
    
    bigLabel.layer.borderWidth=1;
    bigLabel.layer.cornerRadius=4;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 177/255.0, 177/255.0,177/255.0, 1 });
    
    bigLabel.layer.borderColor=borderColorRef;

    
    for (int i=1; i<6; i++) {
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(i*(WIDTH * 48.8/375), HEIGHT*9/667, 1, HEIGHT*33.5/667)];
        
        
        UIView * view2=[[UIView alloc]initWithFrame:CGRectMake(i*(WIDTH * 48.8/375)+1, HEIGHT*9/667, 1, HEIGHT*33.5/667)];
        view.backgroundColor=[UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
        
        view2.backgroundColor=[UIColor colorWithRed:218/255.0 green:218/255.0 blue:221/255.0 alpha:1.0];
        [bigLabel addSubview:view2];
        [bigLabel addSubview:view];
       
        
        
    }
    for (int i=0; i<6; i++) {
        UILabel * inputLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*(WIDTH * 48.8/375), 0, WIDTH * 48.8/375, HEIGHT*51.5/667)];
//        inputLabel.backgroundColor=[UIColor redColor];
        inputLabel.tag=100+i;
        inputLabel.textAlignment=NSTextAlignmentCenter;
        inputLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        inputLabel.font=[UIFont systemFontOfSize:18];
        [bigLabel addSubview:inputLabel];
    }
    
    [self.view addSubview:bigLabel];
   
    _field=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*41/375,64+ HEIGHT*55/667, WIDTH*293/375,  HEIGHT*51.5/667)];
    
    _field.hidden=YES;
     [_field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _field.keyboardType=UIKeyboardTypeNumberPad;
    _field.tag=101;
    
    [self.view addSubview:_field];
    
    [_field becomeFirstResponder];
    UIButton *LoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"LoginBtnPress"] forState:UIControlStateHighlighted];
    
    LoginButton.enabled=NO;
    LoginButton.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];
    LoginButton.frame=CGRectMake(WIDTH*10/375,64+ HEIGHT*130/667, WIDTH*355/375, HEIGHT*40/667);
    LoginButton.layer.cornerRadius=4.5;
    
    if ([_category isEqualToString:@"register"]) {
        
        [LoginButton setTitle:@"下一步" forState:UIControlStateNormal];
        [LoginButton setTitle:@"下一步" forState:UIControlStateHighlighted];

        
    } if ([_category isEqualToString:@"fast"]) {
        
        [LoginButton setTitle:@"进入班组汇" forState:UIControlStateNormal];
        [LoginButton setTitle:@"进入班组汇" forState:UIControlStateHighlighted];
        
        
    }if ([_category isEqualToString:@"forget"]) {
        [LoginButton setTitle:@"下一步" forState:UIControlStateNormal];
        [LoginButton setTitle:@"下一步" forState:UIControlStateHighlighted];
 
    }
    
    LoginButton.titleLabel.font=[UIFont systemFontOfSize:18];
    LoginButton.tag=1000;
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton setTitleColor:[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [LoginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginButton];

    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*118/375, 64+HEIGHT* 195/667, WIDTH*105/375, HEIGHT*15/667)];
     second.text=@"没有收到验证码?";
    second.font=[UIFont systemFontOfSize:13];
    second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];

    [self.view addSubview:second];
    UIButton * Btn=[UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame=CGRectMake(WIDTH*222/375, 64+HEIGHT* 195/667, WIDTH*30/375,  HEIGHT*15/667);
    [Btn setTitle:@"重发" forState:UIControlStateNormal];
    Btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [Btn setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(second:) forControlEvents:UIControlEventTouchUpInside];

    [Btn.titleLabel setFont:[UIFont systemFontOfSize:13]];

    [self.view addSubview:Btn];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*222/375, 64+HEIGHT* 210/667, WIDTH*26/375,  1)];
    view.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    [self.view addSubview:view];
    _codeBtn=[JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.frame=CGRectMake(0,64+ HEIGHT* 190/667, self.view.frame.size.width,HEIGHT*25/667);
    _codeBtn.layer.cornerRadius=10;
    _codeBtn.tag=100;
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeBtn setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
    _codeBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    
    
    _codeBtn.backgroundColor=[UIColor whiteColor];
    
    [_codeBtn startWithSecond:60];
    if ([UIScreen mainScreen].bounds.size.width<350) {
        second.font=[UIFont systemFontOfSize:11];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        _codeBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        
    }
    
    
    [self.view addSubview:_codeBtn];

     [self.view addSubview:butt];
    
    
}
-(void)creatBtn{

    _tab=[[JRTabBarController alloc]init];
    

}
-(void)tanchu:(UIButton *)button{
    [_field becomeFirstResponder];

}
-(void)second:(UIButton *)button{
    _codeBtn.hidden=NO;
    [_codeBtn startWithSecond:60];
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/send_sms_anyway?phone=%@",URLDOMAIN,self.phoneNumber];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dic[@"state"] isEqualToString:@"2"]) {
            [MBProgressHUD showSuccess:@"验证码已发送"];
            
            
        }
        if ([dic[@"state"] isEqualToString:@"4085"]) {
            [MBProgressHUD showError:@"短信条数已用完，请明天再试"];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"服务器开小差了"];
       
    }];
    
}
-(void)Login:(UIButton *)button{
    
   
    
    
if ([_category isEqualToString:@"fast"]) {
    
           [self.field resignFirstResponder];
    
            _hud = [WKProgressHUD showInView:self.view withText:@"登录中" animated:YES];
    
    
            NSString * imie=[[UIDevice currentDevice].identifierForVendor UUIDString];
            AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/sms_login?code=%@&phone=%@&imei=%@&platform=ios",URLDOMAIN,_field.text,self.phoneNumber,imie];
            [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"ret"] isEqualToString:@"success"]) {
    
                    
                    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                    NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    [user setObject:self.phoneNumber forKey:@"nameStr"];
                    
                    
                   
                    
                    NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    
                    
                    NSLog(@"%@",Dic);
                    
                    
                    
                    
                    [user setObject:Dic[@"password"] forKey:@"passStr"];
                    [user setObject:imie forKey:@"imie"];
    
                    [user setObject:Dic[@"companyID"] forKey:@"companyID"];
                    [user setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                    [user setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                    [user setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                    [user setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                    [user setObject:Dic[@"token"] forKey:@"token"];
                    [user setObject:Dic[@"userID"] forKey:@"userID"];
                    [user setObject:Dic[@"userName"] forKey:@"userName"];
                    
                    
                    NSNotification * notice = [NSNotification notificationWithName:@"refreshshouye1" object:nil];
                    //发送消息
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                    
                    
                    
                    
                    
                    
                    
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    
                    //                        NSDate *pushDate = date1;
                    UIApplication *app = [UIApplication sharedApplication];
                    if (notification != nil) {
                        // 设置推送时间
                        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5400];
                        // 设置时区
                        notification.timeZone = [NSTimeZone systemTimeZone];
                        // 设置重复间隔
                        notification.repeatInterval = 0;
                        // 推送声音
                        notification.soundName =@"";
                        
                        //                notification.soundName = @"Bell.caf";
                        // 推送内容
                        notification.alertBody = @"";
                        notification.userInfo=@{@"type":@"token"};
                        //显示在icon上的红色圈中的数字
                        notification.applicationIconBadgeNumber = 0;
                        //添加推送到UIApplication
                        
                        [app scheduleLocalNotification:notification];
                        
                    }
                    
                    
                    

                    
                    
                    
                    
                    NSString * url=[NSString stringWithFormat:@"%@:8090/BagServer/getAvatar4Login.mob?phoneNum=%@",URLDOMAIN,self.phoneNumber];
                    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
                    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
                    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
    
                        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                        [user setObject:result forKey:@"headImageViewURL"];
    
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"%@",error);
                    }];
    
    
    
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"userID" ]) {
    
    
    
                        NSString * device=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob",URLDOMAIN];
                        NSDictionary * para=@{@"deviceToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"userID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
    
    
    
                        [manager GET:device parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
    
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"%@",error);
                        }];
    
    
                    }
    
    
    
    
    
                    NSString * URL=[NSString stringWithFormat:@"%@/BagServer/userHonorInfo.mob",URLDOMAIN];
    
    
    
                    NSDictionary * parameters=@{@"token":Dic[@"token"]};
    
    
                    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
                        if (dic.count!=0) {
    
                            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                            [user setObject:dic[@"totalIntegral"] forKey:@"totalIntegral"];
                            [user setObject:dic[@"totalRanking"] forKey:@"totalRanking"];
    
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"%@",error);
                    }];
    
                    [self creatBtn];
          
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].keyWindow.rootViewController=_tab;
                    });
    
                }if ([dic[@"ret"] isEqualToString:@"code_expired"]) {
    
                    UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    av.delegate=self;
                    [av show];
                    [_hud dismiss:YES];
                }if ([dic[@"ret"] isEqualToString:@"code_not_match"]) {
                    [_hud dismiss:YES];
                    UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    av.delegate=self;
                    [av show];
                }if ([dic[@"ret"] isEqualToString:@"failure"]) {
                    [_hud dismiss:YES];
                    UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"登录失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    av.delegate=self;
                    
                    [av show];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               [_hud dismiss:YES];
                UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                av.delegate=self;
                [av show];
            }];

    
    return;
}if ([_category isEqualToString:@"forget"]) {
   
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/verify_sms?phone=%@&code=%@",URLDOMAIN,self.phoneNumber,_field.text];
    
   
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        NSLog(@"%@",dic);
        
        
        if ([dic[@"ret"] isEqualToString:@"success"]) {
            
            [self creatBtn];
            InputPassWordViewController * new=[[InputPassWordViewController alloc]init];
            
            
            new.Tabbar=_tab;
            new.phoneNumber=self.phoneNumber;
           
            [self.navigationController pushViewController:new animated:YES];
            
            
            
        }
        if ([dic[@"ret"] isEqualToString:@"had_expired"]) {
            
             [_hud dismiss:YES];
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            av.delegate=self;
            [av show];
        } if ([dic[@"ret"] isEqualToString:@"not_match"]) {
             [_hud dismiss:YES];
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            av.delegate=self;
            [av show];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_hud dismiss:YES];
        [MBProgressHUD showError:@"服务器开小差了"];
        
        
    }];

    
    return;
}

    if ([_category isEqualToString:@"register"]) {
        
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/verify_sms?phone=%@&code=%@",URLDOMAIN,self.phoneNumber,_field.text];
    
   
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
       
        
        
        if ([dic[@"ret"] isEqualToString:@"success"]) {
            NewSetPassWordViewController * new=[[NewSetPassWordViewController alloc]init];
            new.phoneNum=self.phoneNumber;
            new.code=_field.text;
            [self.navigationController pushViewController:new animated:YES];
            
            
            
        }
        if ([dic[@"ret"] isEqualToString:@"had_expired"]) {
            [_hud dismiss:YES];
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            av.delegate=self;
            [av show];
            
            
        } if ([dic[@"ret"] isEqualToString:@"not_match"]) {
           [_hud dismiss:YES];
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"验证码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            av.delegate=self;
            [av show];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"服务器开小差了"];
        
        [_hud dismiss:YES];
    }];

    
    }

}
-(void)textFieldDidChange:(UITextField*)field{
    //
    //        if (field == self.passWordField) {
    //            if (field.text.length>0) {
    //                _passWordBtn.hidden=NO;
    //            }else{
    //                _passWordBtn.hidden=YES;
    //
    //            }
    //
    //    }
    NSLog(@"%@",field.text);
    
        if (field.text.length > 6) {
            field.text = [field.text substringToIndex:6];
            
            
            
            
        }
    if (field.text.length>3) {
        UIButton * button=[self.view viewWithTag:1000];
        
        
        button.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
        button.enabled=YES;

    }else{
    UIButton * button=[self.view viewWithTag:1000];
        button.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];

    }
    
    
    if (field.text.length==0) {
        
        UILabel * label=[self.view viewWithTag:100];
        label.text=nil;
        
        
    }
    if (field.text.length==1) {
        UILabel * label=[self.view viewWithTag:100];
        label.text=field.text;
        UILabel * label1=[self.view viewWithTag:101];
       
        label1.text=nil;
    }
    if (field.text.length==2) {
        UILabel * label=[self.view viewWithTag:101];
        NSRange rang=NSMakeRange(1, 1);
        label.text=[field.text substringWithRange:rang];
        UILabel * label1=[self.view viewWithTag:102];
       
        label1.text=nil;
    }
    if (field.text.length==3) {
        UILabel * label=[self.view viewWithTag:102];
        NSRange rang=NSMakeRange(2, 1);
        label.text=[field.text substringWithRange:rang];
        UILabel * label1=[self.view viewWithTag:103];
       
        label1.text=nil;
    }
    if (field.text.length==4) {
        UILabel * label=[self.view viewWithTag:103];
        NSRange rang=NSMakeRange(3, 1);
        label.text=[field.text substringWithRange:rang];
        
        
        UILabel * label2=[self.view viewWithTag:104];
       
        label2.text=nil;
        
        
        
    }
    if (field.text.length==5) {
        UILabel * label=[self.view viewWithTag:104];
        NSRange rang=NSMakeRange(4, 1);
        label.text=[field.text substringWithRange:rang];
        UILabel * label1=[self.view viewWithTag:105];
        
        label1.text=nil;
    }
    if (field.text.length==6) {
        UILabel * label=[self.view viewWithTag:105];
        NSRange rang=NSMakeRange(5, 1);
        label.text=[field.text substringWithRange:rang];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.field becomeFirstResponder];

}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    [self.field becomeFirstResponder];
    
    self.tabBarController.tabBar.hidden=YES;
    
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    
    if (tabBarController.selectedIndex!=2) {
        
        
        
        _Btn.selected=NO;
    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"tabbarClick" object:nil userInfo:@{@"Click":[NSString stringWithFormat:@"%lu",(unsigned long)tabBarController.selectedIndex]}];
    
}
-(void)center:(UIButton *)button{
    
    if (button.selected==YES) {
        return;
    }
    if (button.selected==NO) {
        _tab.selectedIndex=2;
        
        button.selected=YES;
    }
    if (_tab.selectedIndex!=2) {
        
        button.selected=NO;
    }
    
    
    
    
}

@end
