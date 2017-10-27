//
//  NewLoginViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewLoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "FristViewController.h"
#import "NewBagViewController.h"
#import "NewRegisterViewController.h"
#import "FastLoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import "forgetPassWordViewController.h"
#import "SupportViewController.h"
#import "WKProgressHUD.h"

#import "errorViewController.h"
#import "UIImageView+WebCache.h"
#import "NewNewSetViewController.h"

#import "NewFristViewController.h"
#import "JRTabBarController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewLoginViewController ()<TencentSessionDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)UIView * phoneView;
@property(nonatomic,strong)UIView * passWordView;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UITextField * passWordField;
@property(nonatomic,strong)TencentOAuth * tencentOAuth;
@property(nonatomic,strong)UIButton * passWordBtn;
@property(nonatomic,strong)JRTabBarController * tab;
@property(nonatomic,strong)UINavigationController * nav1;
@property(nonatomic,strong)UINavigationController * nav2;
@property(nonatomic,strong)UINavigationController * nav3;
@property(nonatomic,strong)UINavigationController * nav4;
@property(nonatomic,strong)UINavigationController * nav5;
@property(nonatomic,strong)UIButton * Btn;
@end

@implementation NewLoginViewController
{
    BOOL isMatch;

}
-(void)creatTab{
    
    _tab=[[JRTabBarController alloc]init];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];




    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    UIImageView * headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*151.5/375, HEIGHT*94/667, WIDTH-WIDTH*151.5/375-WIDTH*151.5/375, WIDTH-WIDTH*151.5/375-WIDTH*151.5/375)];
    
    headImage.tag=1222;
    headImage.layer.cornerRadius=headImage.frame.size.width/2;
    headImage.clipsToBounds=YES;
    NSString * head=[user  objectForKey:@"headImageViewURL"];
    [headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
    
    [self.view addSubview:headImage];
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title=@"登录";
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*193/667 , WIDTH*60/375, HEIGHT*17.5/667)];
    phoneLabel.text=@"手机号";
    phoneLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    phoneLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:phoneLabel];
    UILabel * passWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,HEIGHT*253/667 , WIDTH*55/375, HEIGHT*17.5/667)];
    passWordLabel.text=@"密码";
    passWordLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    passWordLabel.font=[UIFont systemFontOfSize:16];
    [passWordLabel sizeToFit];
    [self.view addSubview:passWordLabel];
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    
    
//    if ([self.returnBtn isEqualToString:@"no"]) {
//        button1.hidden=NO;
//    }else{
//    
//        button1.hidden=YES;
//    }
    
    
    
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(WIDTH/2-70-10, HEIGHT*621/667, 80, HEIGHT*14/667);
    [button setTitle:@"新用户注册" forState:UIControlStateNormal];
     [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];

    [button setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
  
    _phoneView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*66/375,HEIGHT*216/667 , WIDTH*295/375, 1)];
    _phoneView.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self.view addSubview:_phoneView];
    
    _passWordView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*66/375, HEIGHT*276/667, WIDTH*295/375, 1)];
    
    _passWordView.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self.view addSubview:_passWordView];
    
    _passWordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_passWordBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHT*3/667, WIDTH*4.5/375, HEIGHT*3/667, WIDTH*4.5/375.0)];
    _passWordBtn.frame=CGRectMake(WIDTH*337/375, HEIGHT*253/667, WIDTH* 27/375, HEIGHT*18/667);
    [_passWordBtn setImage:[UIImage imageNamed:@"icon_display_defult_2x"] forState:UIControlStateSelected];
    [_passWordBtn setImage:[UIImage imageNamed:@"icon_display_disabled_2x"] forState:UIControlStateNormal];
    [_passWordBtn addTarget:self action:@selector(showPassWord:) forControlEvents:UIControlEventTouchUpInside];
    _phoneField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*66/375, HEIGHT*180/667, WIDTH*300/375, HEIGHT*44/667)];

    _phoneField.clearButtonMode = UITextFieldViewModeAlways;
   
    _phoneField.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    _phoneField.keyboardType=UIKeyboardTypeNumberPad;
    [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneField];
    
    _passWordField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH*66/375, HEIGHT*240/667, WIDTH*250/375, HEIGHT*44/667)];
    _passWordField.secureTextEntry=YES;
    _passWordField.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    [_passWordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_passWordField];
    [self.view addSubview:_passWordBtn];
    UIButton * LoginButton=[UIButton buttonWithType:UIButtonTypeSystem];
   

   
    LoginButton.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];
    LoginButton.tag=1100;
    LoginButton.frame=CGRectMake(WIDTH*10/375, HEIGHT*316/667, WIDTH*355/375, HEIGHT*40/667);
    LoginButton.layer.cornerRadius=4.5;
    [LoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [LoginButton setTitle:@"登录" forState:UIControlStateHighlighted];
    LoginButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"LoginBtnPress"] forState:UIControlStateHighlighted];
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [LoginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginButton];
    
    UIButton * fastBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    fastBtn.frame=CGRectMake(WIDTH*10/375, HEIGHT*364/667, 95, HEIGHT*30/667);
    [fastBtn setTitle:@"手机快速登录" forState:UIControlStateNormal];
    [fastBtn setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [fastBtn addTarget:self action:@selector(Fast:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:fastBtn];
    
    UIButton * forgetButton=[UIButton buttonWithType:UIButtonTypeSystem];
    forgetButton.frame=CGRectMake(WIDTH-65-WIDTH*10/375, HEIGHT*364/667,65, HEIGHT*30/667);
    [forgetButton setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [forgetButton addTarget:self action:@selector(findPassWord:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:forgetButton];
    
    UIView * leftView=[[UIView alloc]initWithFrame:CGRectMake( WIDTH*10/375, HEIGHT*361.5/667, WIDTH*330/750, 1)];
    
    leftView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
//    [self.view addSubview:leftView];
    
    UIView * rightView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*400/750, HEIGHT*361.5/667, WIDTH*330/750, 1)];
    
    rightView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
//    [self.view addSubview:rightView];
   
    UILabel * or=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 360/750, HEIGHT*354/667, WIDTH*30/750, WIDTH*30/750)];
    
    or.text=@"or";
    or.font=[UIFont systemFontOfSize:13];
    or.textColor=[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
//    [self.view addSubview:or];
    
    
    
    
    

    
       
    
    
    UIButton * weChat=[UIButton buttonWithType:UIButtonTypeCustom];
    weChat.frame=CGRectMake(WIDTH*150/375, HEIGHT*476/667, WIDTH*75/375, HEIGHT*25/667);
    [weChat setImage:[UIImage imageNamed:@"image_logo_wechat_2x"] forState:UIControlStateNormal];
    [weChat setImage:[UIImage imageNamed:@"image_logo_wechat_2x"] forState:UIControlStateHighlighted];
//    weChat.imageEdgeInsets=UIEdgeInsetsMake(HEIGHT*6.5/667, WIDTH*132/375, HEIGHT*6.5/667, WIDTH*170/375.0);
    [weChat setImageEdgeInsets:UIEdgeInsetsMake(HEIGHT*5/667, WIDTH*13.5/375, HEIGHT*5/667, WIDTH*45/375.0)];
//    weChat.layer.borderWidth=1.0;
    weChat.layer.cornerRadius=4.5;
    CGColorSpaceRef colorS=CGColorSpaceCreateDeviceRGB();
    CGColorRef borderC = CGColorCreate(colorS,(CGFloat[]){ 51/255.0, 147/255.0, 244/255.0, 1 });
    weChat.layer.borderColor=borderC;
    
    [weChat setBackgroundImage:[UIImage imageNamed:@"threeLoginPressed"] forState:UIControlStateHighlighted];
    
    [weChat setTitle:@"微信" forState:UIControlStateNormal];
    [weChat setTitleColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
    [weChat.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [weChat addTarget:self action:@selector(weChatLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:weChat];

    
    if ([WXApi isWXAppInstalled]) {
        
        
        
        
    }
   
    
    UIButton * QQButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [QQButton setImage:[UIImage imageNamed:@"image_logo_QQ_2x"] forState:UIControlStateNormal];
     [QQButton setImage:[UIImage imageNamed:@"image_logo_QQ_2x"] forState:UIControlStateHighlighted];
    QQButton.frame=CGRectMake(WIDTH*150/375, HEIGHT*414/667, WIDTH*75/375, HEIGHT*25/667);
    [QQButton setImageEdgeInsets:UIEdgeInsetsMake(HEIGHT*5/667, WIDTH*15/375, HEIGHT*5/667, WIDTH*46/375)];
    QQButton.layer.cornerRadius=4.5;
    [QQButton addTarget:self action:@selector(QQLogin:) forControlEvents:UIControlEventTouchUpInside];
    QQButton.layer.borderColor=borderC;
    [QQButton setBackgroundImage:[UIImage imageNamed:@"threeLoginPressed"] forState:UIControlStateHighlighted];
    [QQButton setTitle:@"Q Q" forState:UIControlStateNormal];
    [QQButton setTitleColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
    [QQButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    if ([QQApiInterface isQQInstalled]) {
        
    }
    
    UIImageView * registerImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-70+15, HEIGHT*621/667, 15, 15)];
    
    
    registerImage.image=[UIImage imageNamed:@"icon_register_defult@2x"];
    
    
    
    UIButton * helpButton=[UIButton buttonWithType:UIButtonTypeSystem];
    helpButton.frame=CGRectMake(WIDTH/2+25, HEIGHT*621/667, 40, HEIGHT*14/667);
    [helpButton setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
    [helpButton setTitle:@"帮助" forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(Help:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpButton];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2+15, HEIGHT* 620/667,0.5,15)];
    view.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    self.tabBarController.tabBar.hidden=YES;
    
    
}
-(void)textFieldDidChange:(UITextField*)field{

    
    
    
    
    if (field == self.phoneField) {
        if (field.text.length > 10) {
           isMatch = YES;
            [self loadImage];
        }
    }
    
    BOOL  mat = false;
    if (field == self.passWordField) {
        if (field.text.length > 5) {
            mat=YES;
        }else{
        
            mat = NO;
        }
    }
    
   
    if (isMatch && mat) {
        UIButton * btn=[self.view viewWithTag:1100];
        btn.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    }else{
    
        UIButton * btn=[self.view viewWithTag:1100];
        btn.backgroundColor=[UIColor colorWithRed:142/255.0 green:215/255.0 blue:246/255.0 alpha:1.0];
    }
    
    

    if (field == self.phoneField) {
        if (field.text.length > 11) {
            field.text = [field.text substringToIndex:11];
        }
    }
    if (field == self.passWordField) {
        if (field.text.length > 15) {
            field.text = [field.text substringToIndex:15];
        }
    }

}
-(void)Help:(UIButton*)button{
    SupportViewController * support=[[SupportViewController alloc]init];
    
    [self.navigationController pushViewController:support animated:YES];
    
    
}
-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSDictionary * subDic=response.jsonResponse;
    NSString * nickname=subDic[@"nickname"];
    
    
   
    if (nickname.length!=0) {
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"登录中" animated:YES];
        
        
        NSString * imie = [[UIDevice currentDevice].identifierForVendor UUIDString];
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/qq_login?openid=%@&nickname=%@&sex=1&province=%@&city=%@&country=%@&headimgurl=%@&imei=%@&platform=ios",URLDOMAIN,[user objectForKey:@"QQopenID"],nickname,subDic[@"province"],subDic[@"city"],@"中国",subDic[@"figureurl_1"],imie];
        
        
  
        
        [user setObject:subDic[@"figureurl_1"] forKey:@"headImageViewURL"];
        [user setObject:nickname forKey:@"userName"];
        NSString * URL=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           [hud dismiss:YES];
            if ([dic[@"ret"] isEqualToString:@"success"]) {
                
                
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
                
                [user setObject:Dic[@"companyID"] forKey:@"companyID"];
                [user setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                [user setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                [user setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                [user setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                [user setObject:Dic[@"token"] forKey:@"token"];
                [user setObject:Dic[@"userID"] forKey:@"userID"];
                [user setObject:nickname forKey:@"userName"];
                
                [MBProgressHUD showSuccess:@"登录成功"];
                
                
                
                
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
                [self creatTab];
                
                [UIApplication sharedApplication].keyWindow.rootViewController=_tab;

                
                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController popViewControllerAnimated:YES];
//                    
//                    
//                });
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [hud dismiss:YES];
            NSLog(@"%@",error);
        }];
        
        
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
-(void)weChatLogin:(UIButton *)button{

    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }else{
        
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请安装微信客户端" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [av show];
    }
    

    
           
    
    

}
-(void)onResp:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode== 0) {
        NSString *code = aresp.code;
        NSDictionary *dic = @{@"code":code};
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:dic forKey:@"code"];
        
        
    }
    
    
}

-(void)findPassWord:(UIButton *)button{

  
    
    
    
    forgetPassWordViewController * forget=[[forgetPassWordViewController alloc]init];
    
    
    [self.navigationController pushViewController:forget animated:YES];
    
    
    
    
    
    
    
    
    
    
    
}
-(void)QQLogin:(UIButton*)button{
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1102107765" andDelegate:self];
    NSMutableArray * permissions= [NSMutableArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", nil];
    
    
    [_tencentOAuth authorize:permissions inSafari:NO];

}
- (void)tencentDidLogin
{
    
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        
    
        [user setObject:_tencentOAuth.openId forKey:@"QQopenID"];
        [self getQQUserInfo];
    }
    else
    {
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}
- (void)getQQUserInfo {
    
    if(![_tencentOAuth getUserInfo]){
        
        NSLog(@"获取qq用户信息失败");
        
    }
    
}


//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    //    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        
        
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
        
    }
}

-(void)Register:(UIBarButtonItem *)button{
   NewRegisterViewController * Register=[[NewRegisterViewController alloc]init];
    
    [self.navigationController pushViewController:Register animated:YES];
    
}
-(void)Fast:(UIButton *)button{

    FastLoginViewController * fast=[[FastLoginViewController alloc]init];
    [self.navigationController pushViewController:fast animated:YES];

}
-(void)Login:(UIButton *)button{
    
    
    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus]!=NotReachable||[conn currentReachabilityStatus]!=NotReachable) {
        
        /*判断账号不可以为空*/
        if(self.phoneField.text.length==0&&self.passWordField.text.length!=0){
             [self.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [MBProgressHUD showError:@"请输入11位手机号"];
                
                

                return;
            });
            
           
        }
        /*判断密码不能为空*/
        if(self.passWordField.text.length==0&&self.phoneField.text.length!=0){
            
            
            [self.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showError:@"密码为6-15位"];
                
                
                return;
            });

            
        }
        /*判断两者不能都为空*/
        if(self.phoneField.text.length==0&&self.passWordField.text.length==0){
            [self.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showError:@"请输入11位手机号"];
                
                
                
                return;
            });

        }
        
        if(self.phoneField.text.length!=0&&self.passWordField.text.length!=0){
          
            
            NSString * phoneArr=_phoneField.text;
            
            
            NSString * passStr= _passWordField.text;
//            /*书写正则表达式判断输入的是否为手机号*/

            if (_passWordField.text.length<6||_passWordField.text.length>15) {
            
                [self.view endEditing:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"密码为6-15位"];

                });
                 return;

            }
            
            
            [self.view endEditing:YES];
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"登录中" animated:YES];
            
            
            NSString * passWord =[self getMd5_32Bit:passStr];
            NSString * imie = [[UIDevice currentDevice].identifierForVendor UUIDString];
            NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
            
            NSDictionary * parameter=@{@"phone":phoneArr,@"passwd":passWord,@"imei":imie,@"platform":@"ios"};
            AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
            
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
            
                 
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    
                   
                    NSString * ret=dic[@"ret"];
                    [hud dismiss:YES];
                    if ([ret isEqualToString:@"success"]) {
                        
                        [UserInfo setObject:phoneArr forKey:@"nameStr"];
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
                        
                        NSLog(@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]);
                        
                        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"userID" ]) {
                            
                            
                            
                            NSString * device=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob",URLDOMAIN];
                            NSDictionary * para=@{@"deviceToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"userID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
                            
                            
                            
                            [manager GET:device parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
                                
                            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                
                                
                               
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"%@",error);
                            }];
                            
                            
                        }
                        
                        [self creatTab];
                        
                        [UIApplication sharedApplication].keyWindow.rootViewController=_tab;
                        
                        
                        NSNotification * notice = [NSNotification notificationWithName:@"refreshshouye" object:nil];
                        //发送消息
                        [[NSNotificationCenter defaultCenter]postNotification:notice];

                        
                        
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
                            NSLog(@"%@",responseObject);
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"%@",error);
                        }];
                        
                        
                    }
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"%@",error);
                    [hud dismiss:YES];
                    [MBProgressHUD showError:@"服务器开小差了~"];
                }];

//            });
            
            
        }
        
        
    }else {
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"登录中" animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud dismiss:YES];
        });
        
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
-(void)Back:(UIBarButtonItem*)button{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;


}
-(void)viewWillDisappear:(BOOL)animated
{
 self.tabBarController.tabBar.hidden = NO;
   
}


-(void)loadImage{
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getAvatar4Login.mob?phoneNum=%@",URLDOMAIN,self.phoneField.text];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        
        UIImageView * imageView=[self.view viewWithTag:1222];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:result]placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:result forKey:@"headImageViewURL"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


@end
