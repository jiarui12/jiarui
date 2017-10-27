//
//  HistoryLoginViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "HistoryLoginViewController.h"
#import "FastLoginViewController.h"
#import "forgetPassWordViewController.h"
#import "NewLoginViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+HM.h"
#import "PrefixHeader.pch"
#import "Reachability.h"
#import "WKProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "FristViewController.h"
#import "NewBagViewController.h"
#import "errorViewController.h"
#import "NewNewSetViewController.h"
#import "NewFristViewController.h"
#import "JRTabBarController.h"
#import <CommonCrypto/CommonDigest.h>
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface HistoryLoginViewController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)UIView * passWordView;
@property(nonatomic,strong)UIButton * passWordBtn;
@property(nonatomic,strong)JRTabBarController * tab;
@property(nonatomic,strong)UITextField * passWordField;
@property(nonatomic,strong)UIButton * Btn;
@property(nonatomic,strong)UINavigationController * nav1;
@property(nonatomic,strong)UINavigationController * nav2;
@property(nonatomic,strong)UINavigationController * nav3;
@property(nonatomic,strong)UINavigationController * nav4;
@property(nonatomic,strong)UINavigationController * nav5;
@property(nonatomic,strong)NSUserDefaults * user;
@end

@implementation HistoryLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _user=[NSUserDefaults standardUserDefaults];
   self.navigationItem.title=@"登录";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImageView * headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*151.5/375, HEIGHT*94/667, WIDTH-WIDTH*151.5/375-WIDTH*151.5/375, WIDTH-WIDTH*151.5/375-WIDTH*151.5/375)];
    headImage.image=[UIImage imageNamed:@"班组汇图标"];
    headImage.layer.cornerRadius=headImage.frame.size.width/2;
    headImage.clipsToBounds=YES;
    NSString * head=[_user objectForKey:@"headImageViewURL"];
    
    [headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
    
    [self.view addSubview:headImage];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 20, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ change_defult_2x"] forState:UIControlStateNormal];
    
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    [button addTarget:self action:@selector(Change:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*22/375, HEIGHT*(335-43)/667, 200, HEIGHT*32/667)];
    label2.textColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    label2.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label2];
    
    
    UIButton * LoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
    LoginButton.backgroundColor=[UIColor colorWithRed:164/255.0 green:206/255.0 blue:255/255.0 alpha:1.0];    LoginButton.frame=CGRectMake(WIDTH*10/375,64+ HEIGHT*(281-43)/667, WIDTH*355/375, HEIGHT*40/667);
    LoginButton.layer.cornerRadius=4.5;
    LoginButton.tag=120;
    [LoginButton setTitle:@"登录" forState:UIControlStateNormal];
    LoginButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"点击后"] forState:UIControlStateHighlighted];
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginButton];
    
    UIButton * fastBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    fastBtn.frame=CGRectMake(WIDTH*10/375,64+ HEIGHT*(351-43-10)/667, 95, HEIGHT*30/667);
    [fastBtn setTitle:@"手机快速登录" forState:UIControlStateNormal];
    [fastBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [fastBtn addTarget:self action:@selector(Fast:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:fastBtn];
    
    UIButton * forgetButton=[UIButton buttonWithType:UIButtonTypeSystem];
    forgetButton.frame=CGRectMake(WIDTH-65-WIDTH*10/375,64+ HEIGHT*(351-43-10)/667,65, HEIGHT*30/667);
    
    
   
    [forgetButton setTitleColor:[UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(Forget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    UILabel * PhoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*185/667, WIDTH, HEIGHT*16/667)];
    NSUserDefaults * users=[NSUserDefaults standardUserDefaults];
   
    
    
    PhoneLabel.text= [users objectForKey:@"nameStr"];
    PhoneLabel.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
    PhoneLabel.textAlignment=NSTextAlignmentCenter;
    PhoneLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:PhoneLabel];
    
    _passWordView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*66/375,64+HEIGHT*(238.5-43)/667, WIDTH*295/375, 1)];
    
    _passWordView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];

    [self.view addSubview:_passWordView];
    UILabel * passWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,64+HEIGHT*(216-43)/667 , WIDTH*55/375, HEIGHT*17.5/667)];
    passWordLabel.text=@"密码";
    passWordLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    [self.view addSubview:passWordLabel];
    _passWordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _passWordBtn.frame=CGRectMake(WIDTH*341/375, 64+HEIGHT*(218-43)/667, WIDTH* 18/375, HEIGHT*12/667);
    [_passWordBtn setImage:[UIImage imageNamed:@"icon_display_defult_2x"] forState:UIControlStateSelected];
    [_passWordBtn setImage:[UIImage imageNamed:@"icon_display_disabled_2x"] forState:UIControlStateNormal];
    [_passWordBtn addTarget:self action:@selector(showPassWord:) forControlEvents:UIControlEventTouchUpInside];
   
    _passWordField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*66/375,64+ HEIGHT*(217.5-47)/667, WIDTH*300/375, WIDTH*40/667)];
    _passWordField.secureTextEntry=YES;
    _passWordField.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    [_passWordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_passWordField];
     [self.view addSubview:_passWordBtn];

}
-(void)creatTabbar{
    
    _tab=[[JRTabBarController alloc]init];
    
    
}
-(void)Fast:(UIButton *)button{
    
    FastLoginViewController * fast=[[FastLoginViewController alloc]init];
    
    [self.navigationController pushViewController:fast animated:YES];
    
}
-(void)Forget:(UIButton *)button{

    forgetPassWordViewController * f=[[forgetPassWordViewController alloc]init];
    
    [self.navigationController pushViewController:f animated:YES];

}
-(void)textFieldDidChange:(UITextField*)field{
    UIButton * button=(UIButton*)[self.view viewWithTag:120];
    
            if (field == self.passWordField) {
                if (field.text.length<6) {
                    
                    button.backgroundColor=[UIColor colorWithRed:164/255.0 green:206/255.0 blue:255/255.0 alpha:1.0];
                }else{
                    button.backgroundColor=[UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
                }
    
        }
    
    
}

-(void)showPassWord:(UIButton *)button{
    if (button.selected==YES) {
        _passWordField.secureTextEntry=YES;
        
        
        
        button.selected=NO;
    }else if (button.selected==NO){
        
        _passWordField.secureTextEntry=NO;
        button.selected=YES;
    }
    



}
-(void)Login:(UIButton *)button{
  
    
    NSString * userString=[_user objectForKey:@"nameStr"];
  
  
        
    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus]!=NotReachable||[conn currentReachabilityStatus]!=NotReachable) {
       
        /*判断密码不能为空*/
        if(self.passWordField.text.length==0){
            
            
            [self.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showError:@"密码为6-15位"];
                
                
                return;
            });
            
            
        }
       
        
     if (_passWordField.text.length<6) {
                
            [self.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"密码为6-15位"];
                });
                return;
                
            }
            
            
            [self.view endEditing:YES];
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"登录中" animated:YES];
        
            
            NSString * passWord =[self getMd5_32Bit:_passWordField.text];
            NSString * imie = [[UIDevice currentDevice].identifierForVendor UUIDString];
            AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login?phone=%@&passwd=%@&imei=%@&platform=ios",URLDOMAIN,userString,passWord,imie];
            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                
                NSString * ret=dic[@"ret"];
              
                if ([ret isEqualToString:@"success"]) {
                    
                    
                    
                    NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    
                    [_user setObject:Dic[@"companyID"] forKey:@"companyID"];
                    [_user setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                    [_user setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                    [_user setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                    [_user setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                    [_user setObject:Dic[@"token"] forKey:@"token"];
                    [_user setObject:Dic[@"userID"] forKey:@"userID"];
                    [_user setObject:Dic[@"userName"] forKey:@"userName"];
                    
                    
                    
                    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getAvatar4Login.mob?phoneNum=%@",URLDOMAIN,userString];
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
                    
                    
                    
                    NSString * URL=[NSString stringWithFormat:@"%@/BagServer/userHonorInfo.mob",URLDOMAIN];
                    
                    
                    
                    NSDictionary * parameters=@{@"token":Dic[@"token"]};
                    
                    
                    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        
                        if (dic.count!=0) {
                            
                           
                            [_user setObject:dic[@"totalIntegral"] forKey:@"totalIntegral"];
                            [_user setObject:dic[@"totalRanking"] forKey:@"totalRanking"];
                            
                        }
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
                    
                    [self creatTabbar];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                        [UIApplication sharedApplication].keyWindow.rootViewController=_tab;
                        
                    });
                    
                    
                }if ([ret isEqualToString:@"passwd_not_match"]) {
                    [hud dismiss:YES];
                    [MBProgressHUD showError:@"密码不正确"];
                }if ([ret isEqualToString:@"account_not_found"]) {
                    [hud dismiss:YES];
                    [MBProgressHUD showError:@"无此用户"];
                }
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"userID" ]) {
                    
                    
                    
                    NSString * device=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob",URLDOMAIN];
                    NSDictionary * para=@{@"deviceToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"userID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
                    
                    
                    
                    [manager GET:device parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"%@",error);
                    }];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                [hud dismiss:YES];
                [MBProgressHUD showError:@"服务器开小差了~"];
            }];
            
        }else {
        [MBProgressHUD showError:@"网络不太顺畅哦~"];
        
    }
    

}
- (NSString *)getMd5_32Bit:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)input.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
-(void)Change:(UIButton *)button{

    NewLoginViewController * new=[[NewLoginViewController alloc]init];
    new.returnBtn=@"no";
    [self.navigationController pushViewController:new animated:YES];
    
}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{

     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}


@end
