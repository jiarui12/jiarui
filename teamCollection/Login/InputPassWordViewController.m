//
//  InputPassWordViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/11.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "InputPassWordViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import <CommonCrypto/CommonDigest.h>
#import "NewLoginViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface InputPassWordViewController ()
@property(nonatomic,strong)UIView * phoneView;
@property(nonatomic,strong)UIView * passWordView;
@property(nonatomic,strong)UIButton * passWordBtn;
@property(nonatomic,strong)UIButton * passWordBtn1;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UITextField * yanField;


@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)int second;

@end

@implementation InputPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*105/667 , WIDTH*60/375, HEIGHT*17.5/667)];
    phoneLabel.text=@"新密码";
    phoneLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    phoneLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:phoneLabel];
    
    UILabel * passWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*165/667 , WIDTH*90/375, HEIGHT*17.5/667)];
    passWordLabel.text=@"重复密码";
    passWordLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    passWordLabel.font=[UIFont systemFontOfSize:16];
    
    [self.view addSubview:passWordLabel];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"设置新密码";
    self.tabBarController.tabBar.hidden=YES;
    
    if ([UIScreen mainScreen].bounds.size.width<350) {
         passWordLabel.font=[UIFont systemFontOfSize:14];
           phoneLabel.font=[UIFont systemFontOfSize:14];
        passWordLabel.frame=CGRectMake(WIDTH*10/375,HEIGHT*165/667 , WIDTH*90/375, HEIGHT*17.5/667);
    }
    
    _phoneView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*66/375,HEIGHT*126/667 , WIDTH*295/375, 1)];
    _phoneView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.view addSubview:_phoneView];
    
    _passWordView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*80/375, HEIGHT*186/667, WIDTH*280/375, 1)];
    
    _passWordView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.view addSubview:_passWordView];
    
    _phoneField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*66/375, HEIGHT*98/667, WIDTH*300/375, HEIGHT*32/667)];
        _phoneField.secureTextEntry=YES;
   
    
    [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneField];
    
    
    _yanField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*80/375, HEIGHT*165/667, WIDTH*280/375, HEIGHT*21/667)];

    _yanField.secureTextEntry=YES;
    [_yanField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    [self.view addSubview:_yanField];
    UIButton * LoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
    LoginButton.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    LoginButton.frame=CGRectMake(WIDTH*10/375, HEIGHT*226/667, WIDTH*355/375, HEIGHT*40/667);
    LoginButton.layer.cornerRadius=4.5;
    [LoginButton setTitle:@"找回密码" forState:UIControlStateNormal];
    LoginButton.titleLabel.font=[UIFont systemFontOfSize:18];
    
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginButton];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    
    _passWordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _passWordBtn.frame=CGRectMake(WIDTH*340/375, HEIGHT*165/667, WIDTH* 18/375, HEIGHT*12/667);
    [_passWordBtn setBackgroundImage:[UIImage imageNamed:@"icon_display_disabled_2x"] forState:UIControlStateNormal];
    [_passWordBtn setBackgroundImage:[UIImage imageNamed:@"icon_display_defult_2x"] forState:UIControlStateSelected];
    [_passWordBtn addTarget:self action:@selector(showPassWord:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_passWordBtn];
    
    
    _passWordBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _passWordBtn1.frame=CGRectMake(WIDTH*340/375, HEIGHT*105/667, WIDTH* 18/375, HEIGHT*12/667);
    [_passWordBtn1 setBackgroundImage:[UIImage imageNamed:@"icon_display_disabled_2x"] forState:UIControlStateNormal];
    [_passWordBtn1 setBackgroundImage:[UIImage imageNamed:@"icon_display_defult_2x"] forState:UIControlStateSelected];
    [_passWordBtn1 addTarget:self action:@selector(showPassWord:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_passWordBtn1];
    
    
    
}
-(void)showPassWord:(UIButton *)button{

    if (button==_passWordBtn) {
        
        if (button.selected==YES) {
            _yanField.secureTextEntry=YES;
            
            
            
            button.selected=NO;
        }else if (button.selected==NO){
            
            _yanField.secureTextEntry=NO;
            button.selected=YES;
        }

        
    }if (button==_passWordBtn1) {
        
        
        if (button.selected==YES) {
            _phoneField.secureTextEntry=YES;
            
            
            
            button.selected=NO;
        }else if (button.selected==NO){
            
            _phoneField.secureTextEntry=NO;
            button.selected=YES;
        }

        
    }

}
-(void)Login:(UIButton *)button{
   
    
    if(self.phoneField.text.length==0&&self.yanField.text.length!=0){
        [MBProgressHUD showError:@"密码为6-15位"];
        return;
    }
    /*判断密码不能为空*/
    if(self.yanField.text.length==0&&self.phoneField.text.length!=0){
        [MBProgressHUD showError:@"密码为6-15位"];
        
        
        return;
    }
    /*判断两者不能都为空*/
    if(self.phoneField.text.length==0&&self.yanField.text.length==0){
        [MBProgressHUD showError:@"密码为6-15位"];
        return;
        
    }
    if(self.phoneField.text.length!=0&&self.yanField.text.length!=0){
        
        if ([self.phoneField.text isEqualToString:self.yanField.text]) {
            
        
        
        
        if (self.phoneField.text.length>5&&self.phoneField.text.length<16) {
        
        NSString * passWord = [self getMd5_32Bit:self.phoneField.text];
            
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/initPassword.mob?phoneNum=%@&password=%@&flag=4",URLDOMAIN,self.phoneNumber,passWord];
            [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                
                NSString * result=[NSString stringWithFormat:@"%@",dic[@"result"]];
                
                if ( [result isEqualToString:@"1"]) {
                   
                    [self.view endEditing:YES];
                    
                    [MBProgressHUD showSuccess:@"修改成功"];
                    
                    NSString * imie = [[UIDevice currentDevice].identifierForVendor UUIDString];
                    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
                    
                    NSDictionary * parameter=@{@"phone":_phoneNumber,@"passwd":passWord,@"imei":imie,@"platform":@"ios"};
                    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
                    
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            
                            
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                            
                            
                            NSString * ret=dic[@"ret"];
                            if ([ret isEqualToString:@"success"]) {
                                
                                [UserInfo setObject:_phoneNumber forKey:@"nameStr"];
                                [UserInfo setObject:passWord forKey:@"passStr"];
                                [UserInfo setObject:imie forKey:@"imie"];
                                
                                NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                                
                                NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                
                                [UserInfo setObject:Dic[@"companyID"] forKey:@"companyID"];
                                [UserInfo setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                                [UserInfo setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                                [UserInfo setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                                [UserInfo setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                                [UserInfo setObject:Dic[@"token"] forKey:@"token"];
                                [UserInfo setObject:Dic[@"userID"] forKey:@"userID"];
                                [UserInfo setObject:Dic[@"userName"] forKey:@"userName"];
                                
                                
                                NSNotification * notice = [NSNotification notificationWithName:@"refreshshouye" object:nil];
                                //发送消息
                                [[NSNotificationCenter defaultCenter]postNotification:notice];

                                
                                
                                NSString * url=[NSString stringWithFormat:@"%@/BagServer/getAvatar4Login.mob?phoneNum=%@",URLDOMAIN,self.phoneField.text];
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
                                        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                                        [user setObject:dic[@"totalIntegral"] forKey:@"totalIntegral"];
                                        [user setObject:[NSString stringWithFormat:@"%@",dic[@"curLevelNum"]] forKey:@"totalRanking"];
                                        
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"%@",error);
                                }];
                                
                                
                                
                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]) {
                                    
                                    
                                    
                                    NSString * device=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob",URLDOMAIN];
                                    NSDictionary * para=@{@"deviceToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"userID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
                                    
                                    
                                    
                                    [manager GET:device parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
                                        
                                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        NSLog(@"%@",error);
                                    }];
                                    
                                    
                                }
                                
                            }if ([ret isEqualToString:@"passwd_not_match"]) {
                                [MBProgressHUD showError:@"密码不正确"];
                                
                            }if ([ret isEqualToString:@"account_not_found"]) {
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
                            
                            
                            //                [_animitionView removeFromSuperview];
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"%@",error);
                            [MBProgressHUD showError:@"服务器开小差了~"];
                            //                [_animitionView removeFromSuperview];
                        }];
                        
                    });
                    
                    
                    
                [UIApplication sharedApplication].keyWindow.rootViewController=_Tabbar;
                        
                   
                    
                    
                }if ([result isEqualToString:@"0"]) {
                    
                    
                    [MBProgressHUD showError:@"修改失败，稍后再试"];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                
                [MBProgressHUD showError:@"网络连接错误"];
                
                
                
                
            }];
            
        }else{
        
            [MBProgressHUD showError:@"密码为6-15位"];
          
        
        
        
        
        }
        
        
        }else{
        
            [MBProgressHUD showError:@"两次密码输入不一致"];
            

        
        }
        
        
        
        
        
    }
    
    
    
}
-(void)textFieldDidChange:(UITextField *)field{
    
}
-(void)Back:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSString *)getMd5_32Bit:(NSString *)input {
    const char * cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)input.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

@end
