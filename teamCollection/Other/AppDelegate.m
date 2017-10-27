//
//  AppDelegate.m
//  teamCollection
//
//  Created by 八九点 on 16/1/4.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "XMPP.h"
#import "ChatTool.h"
#import "JRNavigationController.h"
#import "NewBagViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "SettingViewController.h"
#import "AFNetworking.h"
#import "iflyMSC/IFlyMSC.h"
#import "PrefixHeader.pch"
#import "NewLoginViewController.h"
#import "HistoryLoginViewController.h"
#import "MBProgressHUD+HM.h"
#import "MTA.h"
#import "biaoganViewController.h"
#import "MTAConfig.h"
#import "NewLoginViewController.h"
#import "InputCodeViewController.h"
#import "FristViewController.h"
#import "HistoryLoginViewController.h"
#import "InputPassWordViewController.h"
#import "errorViewController.h"
#import "NewMyTableViewController.h"
#import "InitializationViewController.h"
#import "NewNewSetViewController.h"
#import "RNCachingURLProtocol.h"
#import <UserNotifications/UserNotifications.h>
#import "FMDB.h"
#import "JRKnowLedgeTableViewController.h"
#import "NewFristViewController.h"
#import "messageNoticeViewController.h"
#import "JRTabBarController.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
@interface AppDelegate ()<UIWebViewDelegate,UITabBarControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)JRNavigationController * nav;
@property(nonatomic,strong)UINavigationController * nav1;
@property(nonatomic,strong)JRNavigationController * nav2;
@property(nonatomic,strong)JRNavigationController * nav3;
@property(nonatomic,strong)JRNavigationController * nav4;
@property(nonatomic,strong)JRNavigationController * nav5;
@property(nonatomic,strong)NSString * code;
@property(nonatomic,strong)NSArray * arr;

@property(nonatomic,strong)UIButton * Btn;
@property(nonatomic,strong)NSMutableArray * otherURL;
@property(nonatomic,strong)NSMutableArray * curVersion;
@property(nonatomic,strong)NSMutableArray * tempCode;
@property(nonatomic,strong)NSMutableArray * templateArr;
@property(nonatomic,strong)NSString * savePath;
@property(nonatomic,strong)NSMutableArray * categoryArr;
@property(nonatomic,strong)NSString * downloadURL;
@property(nonatomic,strong)JRTabBarController * tab;
@property(nonatomic,strong)UIWebView * webView;


@end

@implementation AppDelegate
{
    NSString * temp;
    
    FMDatabase * dataBase;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
       
    
 
         
    
    
    [user setObject:@"0" forKey:@"Click"];
    
    [user setObject:@"" forKey:@"shuaxin"];
    _arr=[NSArray new];
    _otherURL=[NSMutableArray new];
    _tempCode=[NSMutableArray new];
    _curVersion=[NSMutableArray new];
    _templateArr=[NSMutableArray new];
    _savePath=[NSString new];
    _downloadURL=[NSString new];
    _categoryArr=[NSMutableArray new];
    

    
    
    
    UIApplication *app = [UIApplication sharedApplication];
    
    
    //    获取所有除与调度中的数组
    NSArray *locationArr = app.scheduledLocalNotifications;
    if (locationArr)
    {
        for (UILocalNotification *ln in locationArr)
        {
            NSDictionary *dict =  ln.userInfo;
            
            if (dict)
            {
                NSString *obj = [dict objectForKey:@"type"];
                
                if ([obj isEqualToString:@"token"])
                {
                    
                    
                    //取消调度通知
                    [app cancelLocalNotification:ln];
                }
            }
        }
    }

    
    
    

    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -2.0)];
    
 
//    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    
    
    NewLoginViewController * newLogin=[[NewLoginViewController alloc]init];
    newLogin.title=@"登录";
   
    NSString *localVersion = [user objectForKey:@"localVersion"];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString * l=[localVersion substringWithRange:NSMakeRange(0, 1)];
    NSString * c=[currentVersion substringWithRange:NSMakeRange(0, 1)];

    
    
    
    if (localVersion == nil || ![c isEqualToString:l]) {
       
        
        
        
        InitializationViewController * init=[[InitializationViewController alloc]init];
        
        
        
        
//        _nav1=[[UINavigationController alloc]initWithRootViewController:init];
        
        
        
//        _nav1.navigationBarHidden=YES;
        
        
        self.window.rootViewController=init;
        
        
        
    }else{
        
        
        
        [self creatTabbar];
        
            if ([[user objectForKey:@"token"] length]>8) {
        
                [self reLogin];
                
            }
        
       
        
        
        
        
        self.window.rootViewController=_tab;
        
        
//else{
//
//        if ([[user objectForKey:@"nameStr"] length]>3) {
//            HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
//            _nav1=[[JRNavigationController alloc]initWithRootViewController:his];
//            _nav1.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
//            
//            self.window.rootViewController=_nav1;
//            
//        }else{
//        
//        NewLoginViewController * new=[[NewLoginViewController alloc]init];
//        _nav1=[[JRNavigationController alloc]initWithRootViewController:new];
//        self.window.rootViewController=_nav1;
//        
//        }
//    }
}
    

    [NSThread sleepForTimeInterval:0.0];
 
    [self.window makeKeyAndVisible];

    [MTA startWithAppkey:@"ISTE8ZK999UZ"];
    
    
    
    _placeholderView=[[UIImageView alloc]initWithFrame:self.window.bounds];
    [_placeholderView setImage:[UIImage imageNamed:@"ios78_retina_4_2x"]];

    _logoView=[[UIImageView alloc]initWithFrame:CGRectMake(454/2, 135/2,25, 375)];
    _logoView.image=[UIImage imageNamed:@"moreWords"];
    UIImageView * bigWords=[[UIImageView alloc]initWithFrame:CGRectMake(280, 246/2, 25, 270)];
    bigWords.image=[UIImage imageNamed:@"lessWord"];
    [self.placeholderView addSubview:bigWords];
    
    [self.placeholderView addSubview:_logoView];
    
    bigWords.alpha=0.0;
    _logoView.alpha=0.0;
    [self.window addSubview:_placeholderView];
    [self.window bringSubviewToFront:_placeholderView];
    
    
    [UIView animateWithDuration:1 animations:^{
        bigWords.alpha=1.0;
    } completion:^(BOOL finished) {
      
        [UIView animateWithDuration:1 animations:^{
            _logoView.alpha=1.0;
        }];
        
        
    }];
        

    
    [UIView animateWithDuration:2 delay:3 options:UIViewAnimationOptionAllowAnimatedContent  animations:^{
        _placeholderView.alpha=0.0;
    } completion:^(BOOL finished) {
        [_placeholderView removeFromSuperview];
    }];
    
    
    
    if([[[UIDevice currentDevice] systemVersion]floatValue]>=8.0){
        
        UIUserNotificationSettings * s =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:s];
        [application registerForRemoteNotifications];
        
        
    }else{
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    [[UIApplication sharedApplication]registerForRemoteNotifications];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"581a9221"];
    [IFlySpeechUtility createUtility:initString];
    [WXApi registerApp:@"wxe995e0cf95888ec6"];
    
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    
    return YES;
}

-(void)reLogin{
    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
    
    
    
    if ([[UserInfo  objectForKey:@"nameStr"] length]>5) {
        
    
    
    NSString * name=[UserInfo  objectForKey:@"nameStr"];
    NSString * pass = [UserInfo objectForKey:@"passStr"];
    NSString * imie =[UserInfo objectForKey:@"imie"];
    
    
    
    NSDictionary * parameter=@{@"phone":name,@"passwd":pass,@"imei":imie,@"platform":@"ios"};
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
        
        

        

        
        
        
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        if (dic.count>0) {
            
            
            if ([dic[@"ret"] isEqualToString:@"passwd_not_match"]) {
                
                HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
                _nav1=[[JRNavigationController alloc]initWithRootViewController:his];
                _nav1.navigationBar.barTintColor=[UIColor colorWithRed:44/255.0 green:140/255.0 blue:253/255.0 alpha:1.0];
                self.window.rootViewController=_nav1;
            }else{
                
                if (dic[@"data"]) {
                    
                    
                    NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString * token1=Dic[@"token"];
                    if (Dic.count!=0) {
                        NSUserDefaults *UserInfo = [NSUserDefaults standardUserDefaults];
                        [UserInfo setObject:token1 forKey:@"token"];
                        [UserInfo setObject:Dic[@"companyID"] forKey:@"companyID"];
                        [UserInfo setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                        [UserInfo setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                        [UserInfo setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                        [UserInfo setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                        [UserInfo setObject:Dic[@"phoneNum"] forKey:@"phoneNum"];
                        [UserInfo setObject:Dic[@"userID"] forKey:@"userID"];
                        [UserInfo setObject:Dic[@"userNO"] forKey:@"userNO"];
                    
                        static dispatch_once_t onceToken;
                        dispatch_once(&onceToken, ^{
                            //                              self.window.rootViewController=_tab;
                            //创建一个消息对象
                            NSNotification * notice = [NSNotification notificationWithName:@"refreshshouye" object:nil];
                            //发送消息
                            [[NSNotificationCenter defaultCenter]postNotification:notice];
                            

                        });
                        
                        
                        
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
                            notification.soundName =@"bayinhe.caf";
                            
                            //                notification.soundName = @"Bell.caf";
                            // 推送内容
                            notification.alertBody = @"";
                            notification.userInfo=@{@"type":@"token"};
                            //显示在icon上的红色圈中的数字
                            notification.applicationIconBadgeNumber = 0;
                            //添加推送到UIApplication
                            
                            [app scheduleLocalNotification:notification];
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                }
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
    }


}

-(void)creatTabbar{

    _tab=[[JRTabBarController alloc]init];
    

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
 
    
}

-(void)downLoadFile{

    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString * tempURL=[NSString stringWithFormat:@"%@/ba/mp/temp/temp_summary_info",URLDOMAIN];
    [manager POST:tempURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        NSString * state=dic[@"ret"];
        
        if ([state isEqualToString:@"success"]) {
            
            
            NSData * data=[dic[@"list"] dataUsingEncoding:NSUTF8StringEncoding];
            
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSString * baseURL=dic[@"base_url"];
            _arr=arr;
            for (NSDictionary * subDic in arr) {
                [_curVersion addObject:subDic[@"cur_version"]];
                [_otherURL addObject:subDic[@"url"]];
                [_tempCode addObject:subDic[@"temp_code"]];
                [_categoryArr addObject:subDic[@"category"]];
            }
            if (arr.count!=0) {
                
                
                for (int i=0; i<arr.count; i++) {
                    
                    [manager POST:[NSString stringWithFormat:@"%@%@?temp_code=%@&version_code=%@",baseURL,_otherURL[i],_tempCode[i],_curVersion[i]] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        
                        
                        if (Dic[@"list"]) {
                            
                            NSData* data=[Dic[@"list"]dataUsingEncoding:NSUTF8StringEncoding];
                            
                            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            
                            for (NSDictionary * dict in arr) {
                                
                                [_templateArr addObject:dict];
                                
                                
                            }
                            
                        }
                        
                        for (NSDictionary * smallDic in _templateArr) {
                            if (smallDic[@"path_saved"]) {
                                if ([smallDic[@"path_saved"] containsString:@"${ROOT}"]) {
                                    NSString * allString=smallDic[@"path_saved"];
                                    
                                    NSString * smallString=[allString substringFromIndex:7];
                                    
                                    _savePath=[NSString stringWithFormat:@"html_template/%@",smallString];
                                    
                                    
                                    
                                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                    NSString *documentsDirectory = [paths objectAtIndex:0];
                                    
                                    
                                    
                                    
                                    NSString *documentsPath =documentsDirectory;
                                    NSFileManager *fileManager = [NSFileManager defaultManager];
                                    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:_savePath];
                                    // 创建目录
                                    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
                                    if (res) {
                                        //                                NSLog(@"文件夹创建成功");
                                    }else{
                                        //                                NSLog(@"文件夹创建失败");
                                    }
                                    
                                    
                                    
                                }else{
                                    
                                    
                                    _savePath=[NSString stringWithFormat:@"html_template/%@/%@/%@/%@",_categoryArr[i],_tempCode[i],_curVersion[i],smallDic[@"path_saved"]];
                                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                    NSString *documentsDirectory = [paths objectAtIndex:0];
                                    
                                    
                                    
                                    
                                    NSString *documentsPath =documentsDirectory;
                                    NSFileManager *fileManager = [NSFileManager defaultManager];
                                    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:_savePath];
                                    // 创建目录
                                    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
                                    if (res) {
                                        //                                NSLog(@"文件夹创建成功");
                                    }else{
                                        //                                NSLog(@"文件夹创建失败");
                                    }
                                    
                                    
                                }
                                
                                
                                
                            }else{
                                
                                _savePath=[NSString stringWithFormat:@"html_template/%@/%@/%@",_categoryArr[i],_tempCode[i],_curVersion[i]];
                                
                                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                NSString *documentsDirectory = [paths objectAtIndex:0];
                                
                                
                                
                                
                                NSString *documentsPath =documentsDirectory;
                                NSFileManager *fileManager = [NSFileManager defaultManager];
                                NSString *testDirectory = [documentsPath stringByAppendingPathComponent:_savePath];
                                // 创建目录
                                BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
                                if (res) {
                                    //                            NSLog(@"文件夹创建成功");
                                }else{
                                    //                            NSLog(@"文件夹创建失败");
                                }
                                
                                
                                
                                
                            }
                            
                            if (smallDic[@"res_url"]) {
                                
                                _downloadURL=smallDic[@"res_url"];
                                
                                
                            }else{
                                
                                if (smallDic[@"path_saved"]) {
                                    
                                    //                            NSLog(@"1111111%@2222222%@3333333%@",Dic[@"base_url"],smallDic[@"path_saved"],smallDic[@"res_name"]);
                                    if ([smallDic[@"path_saved"] containsString:@"${ROOT}"]) {
                                        _downloadURL=[NSString stringWithFormat:@"%@html_template/%@/%@",Dic[@"base_url"],[smallDic[@"path_saved"] substringFromIndex:7],smallDic[@"res_name"]];
                                    }else{
                                        
                                        _downloadURL=[NSString stringWithFormat:@"%@html_template/%@/%@/%@/%@/%@",Dic[@"base_url"],_categoryArr[i],_tempCode[i],_curVersion[i],smallDic[@"path_saved"],smallDic[@"res_name"]];
                                        
                                        
                                    }
                                    
                                    
                                    
                                }else{
                                    
                                    _downloadURL=[NSString stringWithFormat:@"%@html_template/%@/%@/%@/%@",Dic[@"base_url"],_categoryArr[i],_tempCode[i],_curVersion[i],smallDic[@"res_name"]];
                                    
                                }
                                
                            }
                            
                            
                            
                            
                            NSString *downLoadPath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory(),_savePath,smallDic[@"res_name"]];
                            if ([_downloadURL containsString:@"app_waiting.html"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"appwaiting"];
                                
                            }
                            if ([_downloadURL containsString:@"/default/app_ad/"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"appad"];
                                
                            }
                            if ([_downloadURL containsString:@"error.html"]&&[_downloadURL containsString:@"/default/error/"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"apperror"];
                                
                            }
                            if ([_downloadURL containsString:@"download_kp.html"]&&[_downloadURL containsString:@"/default/download_kp/"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"download"];
                                
                            }if ([_downloadURL containsString:@"wangluoqingqiushibai.html"]&&[_downloadURL containsString:@"/default/wangluoqingqiushibai/"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"wangluoqingqiushibai"];
                                
                            }if ([_downloadURL containsString:@"fuwuqikaixiaochai.html"]&&[_downloadURL containsString:@"/default/fuwuqikaixiaochai/"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"fuwuqikaixiaochai"];
                                
                            }if ([_downloadURL containsString:@"no_net.html"]&&[_downloadURL containsString:@"/default/no_net/"]) {
                                NSUserDefaults * use=[NSUserDefaults standardUserDefaults];
                                [use setObject:[NSString stringWithFormat:@"%@/%@",_savePath,smallDic[@"res_name"]] forKey:@"no_net"];
                                
                            }
                            
                            /**        区分:fileURLWithPath:与urlWithString:        前者用于网络(AFNetWorking),后者用于(NSURLConnection等系统的数据请求类)        */
                            
                            //返回下载后保存文件的路径
                            
                            
                            
                            
                            AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];//默认传输的数据类型是二进制
                            
                            sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
                            
                            //模式是下载模式
                            
                            //                    NSProgress *downloadProgress = nil;
                            
                            /*    第一个参数：将要下载文件的路径    第二个参数：下载进度    第三个参数：（block）：处理下载后文件保存的操作    第四个参数（block）：下载完成的操作    */
                            
                            NSURLSessionDownloadTask *task = [sessionManager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_downloadURL]] progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                
                                //沙盒的Documents路径
                                
                                //                        NSString *downLoadPath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory(),_savePath,smallDic[@"res_name"]];
                                
                                /**        区分:fileURLWithPath:与urlWithString:        前者用于网络(AFNetWorking),后者用于(NSURLConnection等系统的数据请求类)        */
                                
                                //返回下载后保存文件的路径
                                
                                
                                
                                
                                return [NSURL fileURLWithPath:downLoadPath];
                                
                            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error){
                                
                            }
                                                              ];
                            
                            //开始下载
                            [task resume];
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                    }];
                    
                    
                    
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
}



-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
   
    
    NSLog(@"本地通知");
    NSDictionary * dic=notification.userInfo;
    
    
    if ([dic[@"type"] isEqualToString:@"alarm"]) {
//        biaoganViewController * know=[[biaoganViewController alloc]init];
//        
//        
//        
//        
//        NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?kpID=%@&token=%@",URLDOMAIN,[NSString stringWithFormat:@"%@",dic[@"kpID"]],[user objectForKey:@"token"]];
//        [user setObject:[NSString stringWithFormat:@"%@",dic[@"kpID"]] forKey:@"kpID"];
//        know.webUrl=str;
//        know.kpId=dic[@"kpID"];
//        
//        JRNavigationController * nav=[[JRNavigationController alloc]initWithRootViewController:know];
//        
//        
//        
//        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
//        
//        
//        [nav.navigationBar setTitleTextAttributes:
//         @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        
//        
//        
//        [self.tab presentViewController:nav animated:YES completion:^{
//            
//        }];
        
    }else if([dic[@"type"] isEqualToString:@"token"]){
        
        
        [self reLogin];
        
        
    
    }else if ([dic[@"operationId"] isEqualToString:@"c_null"]){
    
        
//        UIAlertView * av=[[UIAlertView alloc]initWithTitle:dic[@"pushMessageTitle"] message:dic[@"pushMessageContent"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        av.tag=111111;
//        
//        [av show];
//    
    }
    

    
   
}

-(void)reLogin1{
    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
    NSString * name=[UserInfo  objectForKey:@"nameStr"];
    NSString * pass = [UserInfo objectForKey:@"passStr"];
    NSString * imie =[UserInfo objectForKey:@"imie"];
    
    
    
    NSDictionary * parameter=@{@"phone":name,@"passwd":pass,@"imei":imie,@"platform":@"ios"};
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        if (dic.count>0) {
            
            
            if ([dic[@"ret"] isEqualToString:@"passwd_not_match"]) {
                
                HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
                _nav1=[[JRNavigationController alloc]initWithRootViewController:his];
                _nav1.navigationBar.barTintColor=[UIColor colorWithRed:44/255.0 green:140/255.0 blue:253/255.0 alpha:1.0];
                self.window.rootViewController=_nav1;
            }else{
                
                if (dic[@"data"]) {
                    
                    
                    NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString * token1=Dic[@"token"];
                    if (Dic.count!=0) {
                        NSUserDefaults *UserInfo = [NSUserDefaults standardUserDefaults];
                        [UserInfo setObject:token1 forKey:@"token"];
                        [UserInfo setObject:Dic[@"companyID"] forKey:@"companyID"];
                        [UserInfo setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                        [UserInfo setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                        [UserInfo setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                        [UserInfo setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                        [UserInfo setObject:Dic[@"phoneNum"] forKey:@"phoneNum"];
                        [UserInfo setObject:Dic[@"userID"] forKey:@"userID"];
                        [UserInfo setObject:Dic[@"userNO"] forKey:@"userNO"];
                        
                        //                              self.window.rootViewController=_tab;
                        //创建一个消息对象
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
                        
                        
                        
                        
                        
                        
                    }
                }
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
    
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
   
    
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url



{
    return [TencentOAuth HandleOpenURL:url]||[WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    
return [TencentOAuth HandleOpenURL:url]||[WXApi handleOpenURL:url delegate:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    [user setObject:[NSString stringWithFormat:@"%@",deviceToken] forKey:@"deviceToken"];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"userID" ]) {
        
        
        
        NSString * device=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob",URLDOMAIN];
        NSDictionary * para=@{@"deviceToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"userID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
        
        
        [manager GET:device parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //                                NSLog(@"这是返回结果%@",responseObject);
//            NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
        
    }
    
    NSLog(@"已经注册");
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSLog(@"注册失败%@" ,[error description]);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
     [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"远程通知");
    
    
    
    
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"有新通知" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即查看", nil];
        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        
        messageNoticeViewController * know=[[messageNoticeViewController alloc]init];
        
        
        JRNavigationController * nav=[[JRNavigationController alloc]initWithRootViewController:know];
        
        
        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
        
        [nav.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 18/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [self.tab presentViewController:nav animated:YES completion:^{
            
        }];
        
        
//        [((UITabBarController *)self.window.rootViewController).selectedViewController pushViewController:nav animated:YES];
        
    }
    
    
    
    
    

    if (userInfo) {
        
    }

}


-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
    
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
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
        
        
        
        NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
        
        if ([str isEqualToString:@"0"]) {
             [MBProgressHUD showSuccess:@"分享成功"];
        }if([str isEqualToString:@"-2"]) {
            [MBProgressHUD showSuccess:@"分享取消"];
        }
        
        
        
    }else{
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode== 0) {
        NSString *code = aresp.code;
//        NSDictionary *dic = @{@"code":code};
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:code forKey:@"code"];
        
    }
    
    
    [self getAccess_token];
        
    }
}
-(void) onReq:(BaseReq*)req{

}
-(void)getAccess_token
{
   
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wxe995e0cf95888ec6",@"0bbe0d976739645606ea8572b54c7ef7",[[NSUserDefaults standardUserDefaults] objectForKey:@"code"]];
    
   
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString * accessToken=dic[@"access_token"];
        NSString * openid=dic[@"openid"];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:accessToken forKey:@"accesstoken"];
        [user setObject:openid forKey:@"openid"];
        [self getUserInfo];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"%@",error);
        
        
    }];
    
    
}
-(void)getUserInfo
{
    
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"accesstoken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"openid"]];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:dic[@"unionid"] forKey:@"unionid"];
        [user setObject:dic[@"openid"] forKey:@"openid"];
        [user setObject:dic[@"nickname"] forKey:@"userName"];
        [user setObject:dic[@"sex"] forKey:@"sex"];
        [user setObject:dic[@"province"] forKey:@"province"];
        [user setObject:dic[@"city"] forKey:@"city"];
        [user setObject:dic[@"country"] forKey:@"country"];
        [user setObject:dic[@"headimgurl"] forKey:@"headimgurl"];
        [user setObject:dic[@"headimgurl"] forKey:@"headImageViewURL"];
        [self weChatLogin];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"%@",error);
        
        
    }];

    
    
}
-(void)weChatLogin{
    

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];

    [self creatTabbar];
    NSString * imie=[[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *url =[NSString stringWithFormat:@"%@/ba/api/login/wx_login?union_id=%@&openid=%@&nickname=%@&sex=%@&province=%@&city=%@&country=%@&headimgurl=%@&imei=%@&platform=ios",URLDOMAIN,[user objectForKey:@"unionid"],[user objectForKey:@"openid"],[user objectForKey:@"userName"],[user objectForKey:@"sex"],[user objectForKey:@"province"],[user objectForKey:@"city"],[user objectForKey:@"country"],[user objectForKey:@"headimgurl"],imie];
    
   
     NSString * URL=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
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

    
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/userHonorInfo.mob",URLDOMAIN];
           
            
            
            NSDictionary * parameters=@{@"token":Dic[@"token"]};
            
          
            [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                if (dic.count!=0) {
                    
                    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                    [user setObject:dic[@"totalIntegral"] forKey:@"totalIntegral"];
                    [user setObject:dic[@"totalRanking"] forKey:@"totalRanking"];
                   
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            
            self.window.rootViewController=_tab;

            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
-(void)applicationDidBecomeActive:(UIApplication *)application{


    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSString * token=[user objectForKey:@"token"];
    if (token.length>8) {
        [self reLogin];
    }
    
   

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==111111) {
        
        if (buttonIndex==0) {
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/cleanTokenInfo.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
            
            NSLog(@"%@",url);
            [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                [user setObject:@"" forKey:@"token"];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                [user setObject:@"" forKey:@"token"];
                
            }];
            XMPPPresence * offline=[XMPPPresence presenceWithType:@"unavailable"];
            [[ChatTool sharedChatTool].xmppStream sendElement:offline];
            [[ChatTool sharedChatTool].xmppStream disconnect];
            HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
            UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
            nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
            
//            [UIApplication sharedApplication].keyWindow.rootViewController=nav;
            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
            [user setObject:@"" forKey:@"token"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewController" object:@"zhangsan" userInfo:nil];

            [self.tab presentViewController:nav animated:YES completion:^{
                
            }];
            
            
            
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}


@end
