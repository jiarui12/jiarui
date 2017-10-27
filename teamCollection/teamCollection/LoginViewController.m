//
//  LoginViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "SourceManager.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "ActivateViewController.h"
#import "SupportViewController.h"
#import "FindViewController.h"
#import "SaoViewController.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "PrefixHeader.pch"
#import "SetViewController.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import "Reachability.h"
@interface LoginViewController ()<XMPPStreamDelegate>
@property(nonatomic,strong)UITextField * field;
@property(nonatomic,strong)UITextField * field2;
@property(nonatomic,strong)UIView * animitionView;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)XMPPStream * stream;
@property (nonatomic, strong) Reachability *conn;
@property (nonatomic, strong,readonly)XMPPvCardTempModule *vCard;//电子名片
@property (nonatomic, strong,readonly)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储
@property (nonatomic, strong,readonly)XMPPRoster *roster;//花名册模块
@property (nonatomic, strong,readonly)XMPPMessageArchivingCoreDataStorage *msgStorage;
@end

@implementation LoginViewController







- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    int ButtonY=self.view.frame.size.height-80;
   
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    int y=200;
    int i=70;
    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-(i/2),100, i, i)];
    _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;;
    _headImageView.clipsToBounds=YES;
    _headImageView.image=[UIImage imageNamed:@"man_default_icon"];
    [self.view addSubview:_headImageView];
    _field=[[UITextField alloc]init];
    _field.frame=CGRectMake(60, y-2.5, 300, 20);
    _field.backgroundColor=[UIColor whiteColor];
    _field.placeholder=@"请填写您的手机号码";
    [_field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    _field.keyboardType=UIKeyboardTypeNumberPad;
    
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(30, y-2.5, 20, 20)];
    image.image=[UIImage imageNamed:@"icon_account_login_lebal"];
    [self.view addSubview:image];
    
    _field2=[[UITextField alloc]init];
    _field2.frame=CGRectMake(60, y+47.5, 300, 20);
    _field2.backgroundColor=[UIColor whiteColor];
    _field2.placeholder=@"请填写您的密码";
    _field2.secureTextEntry=YES;
    _field2.clearButtonMode=YES;
    _field.keyboardType=UIKeyboardTypeNumberPad;
  
    
    
    UIImageView * imageV=[[UIImageView alloc]initWithFrame:CGRectMake(30, y+45+2.5, 20, 20)];
    imageV.image=[UIImage imageNamed:@"icon_password_login_lebal"];
    [self.view addSubview:imageV];
    
    UIImageView*bacImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, y-15, self.view.frame.size.width-40, 42)];
    UIImage *image1 = [UIImage imageNamed:@"text_background_xi"];
    UIImage *image2 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    bacImage.image=image2;
    [self.view addSubview:bacImage];
    UIImageView*bacImage1=[[UIImageView alloc]initWithFrame:CGRectMake(20, y+35,self.view.frame.size.width-40 , 42)];
    bacImage1.image=image2;
    [self.view addSubview:bacImage1];

    UIView * view2=[[UIView alloc]initWithFrame:CGRectMake(20, y-15, self.view.frame.size.width-40, 5)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    

    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(20, ButtonY, 100, 50);
    [button setTitle:@"账号激活" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ActivateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame=CGRectMake(20+(self.view.frame.size.width-40)/3, ButtonY, 100, 50);
    [button1 setTitle:@"找回密码" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(FindClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame=CGRectMake(20+(self.view.frame.size.width-40)/3*2,ButtonY, 100, 50);
    [button2 setTitle:@"技术支持" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SupportClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame=CGRectMake(20, y+100, self.view.frame.size.width-40, 40);
    [button3 setTitle:@"登录" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button3.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [button3 addTarget:self action:@selector(LoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
      NSString * str= button2.titleLabel.text;
    CGSize detailSize = [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
  CGFloat f=( 100-detailSize.width);
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(((20+(self.view.frame.size.width-40)/3)+f+20+detailSize.width)/2, ButtonY+20, 1, 10)];
    view.backgroundColor=[UIColor grayColor];
    [self.view addSubview:view];

  
    UIView * view1=[[UIView alloc]initWithFrame:CGRectMake((20+(self.view.frame.size.width-40)/3*2+20+(self.view.frame.size.width-40)/3+100)/2,ButtonY+20, 1, 10)];
    view1.backgroundColor=[UIColor grayColor];
    [self.view addSubview:view1];
     [self.view addSubview:_field2];
    [self.view addSubview:_field];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn=[Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}
-(void)FindClick:(UIButton*)button{
    FindViewController * find=[[FindViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
}
-(void)ActivateClick:(UIButton*)button{
    ActivateViewController*ac=[[ActivateViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];

}
-(void)SupportClick:(UIButton*)button{
    SupportViewController*sup=[[SupportViewController alloc]init];
    [self.navigationController pushViewController:sup animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)LoginButton:(UIButton *)button{
    
    [self.view endEditing:YES];

    if(self.field.text.length==0&&self.field2.text.length!=0){
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }
    if(self.field2.text.length==0&&self.field.text.length!=0){
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }
    if(self.field.text.length==0&&self.field2.text.length==0){
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入账号和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }

    if(self.field.text.length!=0&&self.field2.text.length!=0){
   [self addLoadingAnimotion];
        NSString * nameStr=  _field.text;
        NSString * passStr= _field2.text;
        
        NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        BOOL isMatch = [pred evaluateWithObject:nameStr];
        
        if (!isMatch) {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        NSString * passwordStr=[self getMd5_32Bit:passStr];
        NSString * identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
        NSDictionary * parameter=@{@"account":nameStr,@"password":passwordStr,@"imie":identifierNumber};
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@:8080/BagServer/login.mob",URLDOMAIN];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
   
        
        NSNumber * number=dic[@"result"];
        NSString * result=[NSString stringWithFormat:@"%@",number];
        NSString * token1=dic[@"token"];
        if ([result isEqualToString:@"1"]) {
            self.field2.text=nil;
            MainViewController * main=[[MainViewController alloc]init];
            main.token=token1;
            SetViewController * set=[[SetViewController alloc]init];
            set.token=token1;
            NSUserDefaults *UserInfo = [NSUserDefaults standardUserDefaults];
            [UserInfo setObject:token1 forKey:@"token"];
            [UserInfo setObject:dic[@"companyID"] forKey:@"companyID"];
            [UserInfo setObject:dic[@"companyNO"] forKey:@"companyNO"];
            [UserInfo setObject:dic[@"openfireDomain"] forKey:@"openfireDomain"];
            [UserInfo setObject:dic[@"openfireIP"] forKey:@"openfireIP"];
            [UserInfo setObject:dic[@"openfirePort"] forKey:@"openfirePort"];
            [UserInfo setObject:dic[@"phoneNum"] forKey:@"phoneNum"];
            [UserInfo setObject:dic[@"userID"] forKey:@"userID"];
            [UserInfo setObject:dic[@"userNO"] forKey:@"userNO"];
           
            
            [self.navigationController pushViewController:main animated:YES];
            
            [self connectToHost];
        }if([result isEqualToString:@"2"]){
            
            [MBProgressHUD showError:@"公司账号不存在"];
        }
        if([result isEqualToString:@"3"]){
            
            [MBProgressHUD showError:@"公司账号已暂停"];
        }
        if([result isEqualToString:@"4"]){
            
            [MBProgressHUD showError:@"用户账号不存在"];
        }
        if([result isEqualToString:@"5"]){
            
            [MBProgressHUD showError:@"密码不正确"];
        }
        if([result isEqualToString:@"6"]){
            
            [MBProgressHUD showError:@"公司账号已停用"];
        }
        if([result isEqualToString:@"7"]){
            
            [MBProgressHUD showError:@"企业状态无效"];
        }
        if([result isEqualToString:@"8"]){
            
            [MBProgressHUD showError:@"账号未激活"];
        }if([result isEqualToString:@"9"]){
            
            [MBProgressHUD showError:@"账号已停用"];
        }
        if([result isEqualToString:@"10"]){
            
            [MBProgressHUD showError:@"试用账号已到期"];
        }
        
        
        
        [_animitionView removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"服务器开小差了~"];
        [_animitionView removeFromSuperview];
    }];

    }
    
}

- (NSString *)getMd5_32Bit:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, input.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}


-(void)addLoadingAnimotion{

    _animitionView =[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2-20, 40, 40)];
    
    UIImageView* mainImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    NSMutableArray * Image=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"loading0001.png"],[UIImage imageNamed:@"loading0002.png"],[UIImage imageNamed:@"loading0003.png"],[UIImage imageNamed:@"loading0004.png"],[UIImage imageNamed:@"loading0005.png"],[UIImage imageNamed:@"loading0006.png"],[UIImage imageNamed:@"loading0007.png"],[UIImage imageNamed:@"loading0008.png"],[UIImage imageNamed:@"loading0009.png"],[UIImage imageNamed:@"loading00010.png"],[UIImage imageNamed:@"loading00011.png"],[UIImage imageNamed:@"loading00012.png"], nil];
    [mainImageView setAnimationImages:Image];
    [mainImageView setAnimationDuration:3];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    [_animitionView addSubview:mainImageView];
    [self.view addSubview:_animitionView];
    
}

-(void)textFieldDidChange:(UITextField * )textField{
    if (textField==self.field) {
        if (textField.text.length==11) {
            [self loadImage];
        }
    }
  
}

-(void)loadImage{

    
    NSString * url=[NSString stringWithFormat:@"%@:8090/BagServer/getAvatar4Login.mob?phoneNum=%@",URLDOMAIN,self.field.text];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];

   
      [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      
  } progress:^(NSProgress * _Nonnull uploadProgress) {
      NSLog(@"%@",uploadProgress);
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
      [_headImageView setImageWithURL:[NSURL URLWithString:result]placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
      NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
      [user setObject:result forKey:@"headImageViewURL"];
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"%@",error);
  }];

       
}
-(void)setupXMPPStream{
    _stream=[[XMPPStream alloc]init];
    
    
    XMPPReconnect * reconnect=[[XMPPReconnect alloc]init];
    [reconnect activate:_stream];
    XMPPvCardCoreDataStorage * vCards=[XMPPvCardCoreDataStorage sharedInstance];
    _vCard=[[XMPPvCardTempModule alloc]initWithvCardStorage:vCards];
    [_vCard activate:_stream];
    
    XMPPvCardAvatarModule * avatar=[[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    [avatar activate:_stream];
    
    _rosterStorage=[[XMPPRosterCoreDataStorage alloc]init];
    XMPPRoster  * roster=[[XMPPRoster alloc]initWithRosterStorage:_rosterStorage];
    [roster activate:_stream];
    
    
    _msgStorage=[[XMPPMessageArchivingCoreDataStorage alloc]init];
    XMPPMessageArchiving * msga=[[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_msgStorage];
    [msga activate:_stream];
    
  
    

}

-(void)connectToHost{
    
    NSLog(@"开始连接到服务器");
    if (!_stream) {
        [self setupXMPPStream];
    }
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
   
    
   
    
    NSString * jidString=[NSString stringWithFormat:@"%@%@",[user objectForKey:@"userID"],[user objectForKey:@"openfireDomain"]];
    
     XMPPJID *myJID = [XMPPJID jidWithString:jidString resource:@"iPhone"];
    _stream.myJID=myJID;
    _stream.hostName=[NSString stringWithFormat:@"%@",[user objectForKey:@"openfireIP"] ];

    _stream.hostPort=5222;
  

    _stream.enableBackgroundingOnSocket=YES;
    [_stream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
  
    
  
    NSError * err=nil;
    
    if (![_stream connectWithTimeout:XMPPStreamTimeoutNone error:&err]) {
        NSLog(@"%@",err);
    }

    
    
    
}
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    
        [self sendPwdToHost];
    
    
}
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"与主机断开连接%@",error);
}

-(void)sendPwdToHost{
    
    NSError * err=nil;
    [_stream authenticateWithPassword:@"bagserver" error:&err];
    if (err) {
        NSLog(@"%@",err);
    }
    
}

-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    
   
    
    
        dispatch_async(dispatch_get_main_queue(), ^{
           NSLog(@"%@",_rosterStorage.mainThreadManagedObjectContext);
        });
        
  
    
   
    [self sendOnlineToHost];
}
-(void)sendOnlineToHost{

    NSLog(@"发送在线消息");
    XMPPPresence * presentce=[XMPPPresence presence];
    NSLog(@"%@",presentce);
    
    [_stream sendElement:presentce];
    
    SourceManager * manager=[SourceManager defaultManager];
    manager.msgStorage=_msgStorage;
    
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"授权失败%@",error);
}
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"%@",message.body);
    
    
  
    
    NSString * str=[NSString stringWithFormat:@"%@",message.body];
            NSLog(@"这是str%@",str);
            NSData *JSONData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];

  

    
    
    
        //{"aps":{'alert':"zhangsan\n have dinner":'sound':'default',badge:'12'}}
    
    
    if ([UIApplication sharedApplication].applicationState !=UIApplicationStateActive) {
        NSLog(@"在后台");
        
        UILocalNotification * localNoti=[[UILocalNotification alloc]init];
        if(userInfo){
        
            localNoti.alertBody=userInfo[@"pushMsg"];
        }else{
            localNoti.alertBody=message.body;
        }
        
        
        
        localNoti.fireDate=[NSDate date];
        
        localNoti.soundName=@"default";
         
      
        
        localNoti.userInfo=userInfo;
        [UIApplication sharedApplication].applicationIconBadgeNumber=[UIApplication sharedApplication].applicationIconBadgeNumber+1;
        
        [[UIApplication sharedApplication]scheduleLocalNotification:localNoti];

    }else {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
               UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",message.body] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                 [av show];
            });
            
        });
    
    

        

    }
}

-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"%@",presence.fromStr);
}


//-(void)postNotification:(XMPPResultType)resultType{
//    
//    // 将登录状态放入字典，然后通过通知传递
//    NSDictionary *userInfo = @{@"loginStatus":@(resultType)};
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:LoginStatusChangeNotification object:nil userInfo:userInfo];
//}
-(void)dealloc
{
    [self.conn stopNotifier];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(void)networkStateChange{
    [self checkNetworkState];
}
-(void)checkNetworkState{
    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus]!=NotReachable) {
        NSLog(@"WiFi");
    }else if([conn currentReachabilityStatus]!=NotReachable){
        NSLog(@"2G/3G/4G");
//        [MBProgressHUD showMessage:@"请注意当前使用网络为2G/3G/4G"];
    }else{
        [MBProgressHUD showError:@"无网络连接，请检查您的网络设置"];
       
    }
    
}
@end
