//
//  NewSetPassWordViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/16.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewSetPassWordViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+HM.h"
#import "PrefixHeader.pch"
#import <CommonCrypto/CommonDigest.h>
#import "WKProgressHUD.h"
#import "FristViewController.h"
#import "NewBagViewController.h"
#import "errorViewController.h"
#import "NewNewSetViewController.h"
#import "JRTabBarController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewSetPassWordViewController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)UIView * phoneView;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UIButton *LoginBtn;
@property(nonatomic,strong)UIButton *passWordBtn;
@property(nonatomic,strong)JRTabBarController * tab;
@property(nonatomic,strong)UIButton * Btn;
@property(nonatomic,strong)UINavigationController * nav1;
@property(nonatomic,strong)UINavigationController * nav2;
@property(nonatomic,strong)UINavigationController * nav3;
@property(nonatomic,strong)UINavigationController * nav4;
@property(nonatomic,strong)UINavigationController * nav5;
@property(nonatomic,strong)NSUserDefaults * user;


@end

@implementation NewSetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[NSUserDefaults standardUserDefaults];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"填写密码";
    
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*105/667 , WIDTH*100/375, HEIGHT*17.5/667)];
    phoneLabel.text=@"输入设置密码";
    phoneLabel.font=[UIFont systemFontOfSize:16];
    
    if ([UIScreen mainScreen].bounds.size.width<360) {
        phoneLabel.font=[UIFont systemFontOfSize:14];
    }
    
    phoneLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    [self.view addSubview:phoneLabel];
    
    _passWordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _passWordBtn.frame=CGRectMake(WIDTH*341/375, HEIGHT*110/667, WIDTH* 18/375, HEIGHT*12/667);
    [_passWordBtn setImage:[UIImage imageNamed:@"icon_display_defult_2x"] forState:UIControlStateSelected];
    [_passWordBtn setImage:[UIImage imageNamed:@"icon_display_disabled_2x"] forState:UIControlStateNormal];
    [_passWordBtn addTarget:self action:@selector(showPassWord:) forControlEvents:UIControlEventTouchUpInside];
    

    _phoneView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*110/375,HEIGHT*126/667 , WIDTH*255/375, 1)];
    _phoneView.backgroundColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.view addSubview:_phoneView];
    

    
    _phoneField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*110/375, HEIGHT*105/667, WIDTH*255/375, WIDTH*32/667)];
   
    _phoneField.secureTextEntry=YES;
    [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneField];
    
    
   
    _LoginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
_LoginBtn.backgroundColor=[UIColor colorWithRed:164/255.0 green:206/255.0 blue:255/255.0 alpha:1.0];
    _LoginBtn.frame=CGRectMake(WIDTH*10/375, HEIGHT*179/667, WIDTH*355/375, HEIGHT*40/667);
    _LoginBtn.layer.cornerRadius=4.5;
    [_LoginBtn setTitle:@"进入班组汇" forState:UIControlStateNormal];
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
    
    
        [self.view addSubview:_passWordBtn];
    
}
-(void)creatBtn{
    _tab=[[JRTabBarController alloc]init];
   

}
-(void)Back:(UIBarButtonItem*)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Login:(UIButton *)button{
    
    if(self.phoneField.text.length<6){
        
        
        
    }
    
    
    /*判断密码不能为空*/
    if(self.phoneField.text.length==0){
        [MBProgressHUD showError:@"密码为6-15位"];
        
        
        return;
    }
    /*判断两者不能都为空*/
   
    
    
    
        
       if (self.phoneField.text.length<6||self.phoneField.text.length>15) {
            
            [MBProgressHUD showError:@"密码为6-15位"];
            
            
            return;
            
        }
 WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    NSString * pass=[self getMd5_32Bit:_phoneField.text];
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/register_user?phone=%@&passwd=%@&code=%@",URLDOMAIN,_phoneNum,pass,self.code];
        [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([dic[@"ret"] isEqualToString:@"success"]) {
                
                
                [self.view endEditing:YES];
                
                
        
               
                                  
              
                
                    
                    
                    [self.view endEditing:YES];
                
                  
                    
                    
                
                    NSString * imie = [[UIDevice currentDevice].identifierForVendor UUIDString];
                    
                    NSDictionary * parameter=@{@"phone":_phoneNum,@"passwd":pass,@"imei":imie,@"platform":@"ios"};
                    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
                    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        
                        
                        
                        
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        
                        NSString * ret=dic[@"ret"];
                        
                        if ([ret isEqualToString:@"success"]) {
                            
                            
                            
                            NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                            
                            NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            
                            [_user setObject:_phoneNum forKey:@"nameStr"];
                            
                            [_user setObject:pass forKey:@"passStr"];
                            
                            [_user setObject:imie forKey:@"imie"];
                            
                          
                            [_user setObject:Dic[@"companyID"] forKey:@"companyID"];
                            [_user setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                            [_user setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                            [_user setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                            [_user setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                            [_user setObject:Dic[@"token"] forKey:@"token"];
                            [_user setObject:Dic[@"userID"] forKey:@"userID"];
                            [_user setObject:Dic[@"userName"] forKey:@"userName"];
                            
                            
                            
                            NSString * url=[NSString stringWithFormat:@"%@/BagServer/getAvatar4Login.mob?phoneNum=%@",URLDOMAIN,_phoneNum];
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
                                    [_user setObject:[NSString stringWithFormat:@"%@",dic[@"curLevelNum"]] forKey:@"totalRanking"];
                                }
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"%@",error);
                            }];
                            
                            
                            
                            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"userID" ]) {
                                
                                
                                
                                NSString * device=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob",URLDOMAIN];
                                NSDictionary * para=@{@"deviceToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"userID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
                                
                                
                                
                                [manager GET:device parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
                                    
                                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"%@",responseObject);
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"%@",error);
                                }];
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                            [self creatBtn];
                            
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
                                NSLog(@"%@",responseObject);
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"%@",error);
                            }];
                            
                            
                        }
                        
                        
                        //                [_animitionView removeFromSuperview];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"%@",error);
                        [hud dismiss:YES];
                        [MBProgressHUD showError:@"服务器开小差了~"];
                        //                [_animitionView removeFromSuperview];
                    }];
                    
                }
                
            
         
                
            
            if ([dic[@"ret"] isEqualToString:@"had_register"]) {
                
                [hud dismiss:YES];
                [MBProgressHUD showError:@"手机号已被注册"];
                
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            
        }];
        
        
        

    
    

    
    
    
}

-(void)textFieldDidChange:(UITextField*)field{
       
    
    if (field == self.phoneField) {
        if (field.text.length > 11) {
            field.text = [field.text substringToIndex:11];
        }
        if (field.text.length>0) {
            
            UIButton * button=[self.view viewWithTag:200];
            button.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
            button.enabled=YES;
            
        }
        else{
        
            UIButton * button=[self.view viewWithTag:200];
            button.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];;
            button.enabled=YES;
        
        }
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
-(void)showPassWord:(UIButton *)button{
    
    if (button.selected==YES) {
        _phoneField.secureTextEntry=YES;
        
        
        
        button.selected=NO;
    }else if (button.selected==NO){
        
        _phoneField.secureTextEntry=NO;
        button.selected=YES;
    }
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.tabBarController.tabBar.hidden=YES;


}

@end
