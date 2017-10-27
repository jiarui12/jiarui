//
//  biaoganViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/9/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "biaoganViewController.h"
#import "JSONKit.h"
#import <WebKit/WebKit.h>
#import "Reachability.h"
#import "FFDropDownMenuView.h"
#import "NewLoginViewController.h"
#import "MTA.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import "AFNetworking.h"
#import "WKProgressHUD.h"
#import "DynamicViewController.h"
#import "WXApi.h"
#import "MBProgressHUD+HM.h"
#import "MBProgressHUD.h"
#import "nonetConViewController.h"
#import "ShootVideoViewController.h"
#import "MJRefresh.h"
#import "TFHpple.h"
#import "ChatViewController.h"
#import "biaoganViewController.h"
#import "myLocalValueViewController.h"
#import "CFDynamicLabel.h"
#import "ImageBrowserViewController.h"
#import "UWDatePickerView.h"
#import "MCDownloadManager.h"
#import "offLineStudyViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "YJWebProgressLayer.h"
#import <AVFoundation/AVFoundation.h>
#import "SGScanningQRCodeVC.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface biaoganViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate,UIActionSheetDelegate,UWDatePickerViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)WKWebView * webView;
@property(nonatomic,strong)UIImage * image;
@property(nonatomic,strong)NSString * Width;
@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)NSUserDefaults * user;
@property(nonatomic,strong)WKProgressHUD *hud;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)NSMutableArray * btnArr;
@property(nonatomic,strong)FFDropDownMenuView *dropdownMenu;
@property(nonatomic,strong)NSString * aloneArr;
@property(nonatomic,strong)NSData * htmlData;
@property(nonatomic,strong)NSString * backButton;
@property(nonatomic,strong)NSString * backButtonEvent;
@property(nonatomic,strong)NSString * closeButton;
@property(nonatomic,strong)NSString * closeButtonText;
@property(nonatomic,strong)NSString * closeButtonEvent;
@property(nonatomic,strong)NSString * rightButtonEvent;
@property(nonatomic,strong)NSURL * headURL;
@property(nonatomic,strong)NSURL * URL;
@property(nonatomic,strong)NSMutableArray * rightButtonArr;
@property(nonatomic,strong)NSMutableDictionary * rightBtnDic;
@property(nonatomic,strong)CFDynamicLabel * testLabel;
@property(nonatomic,strong)YJWebProgressLayer *webProgressLayer;
@property(nonatomic,strong)NSString * kpID;
@property(nonatomic,strong)NSString * kpTitle;
@property(nonatomic,strong)NSDictionary * dic;
@end

@implementation biaoganViewController

{
    MBProgressHUD * HUD;
    
    UWDatePickerView * _pickerView;
    
    BOOL isBrowserShow;
    NSMutableArray *mjPhotos;
    int selectIndex;
    
    NSMutableArray * downloadArr;
}
-(void)refreshClick{
    NSURLRequest * request=[NSURLRequest requestWithURL:_URL];
    
    [self.webView loadRequest:request];
    


}

-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadView" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];

        
        [_webProgressLayer closeTimer];
        [_webProgressLayer removeFromSuperlayer];
        _webProgressLayer = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    _user=[NSUserDefaults standardUserDefaults];
    _rightButtonArr=[NSMutableArray new];

    NSURL * url=[NSURL URLWithString:self.webUrl];
    NSLog(@"这是链接：%@",self.webUrl);
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    
    [center addObserver:self selector:@selector(Shuaxinshuju) name:@"refreshshouye1" object:nil];
    
    _URL=url;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshClick)name:@"liyantang" object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    
    tap.numberOfTapsRequired = 3;
    tap.numberOfTouchesRequired = 1;
    
    
    [self.navigationController.view addGestureRecognizer:tap];
    
    
    [tap addTarget:self action:@selector(tapIconView)];
    
    _button1=[UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame=CGRectMake(0, 0, 10, 20);
    [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
    [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    //    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    config.allowsInlineMediaPlayback=NO;
    config.allowsAirPlayForMediaPlayback=YES;
    config.allowsPictureInPictureMediaPlayback=YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically=NO;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) configuration:config];
    _webView.allowsBackForwardNavigationGestures=YES;
    
    
    
   
    
    
    NSURLRequest* request1 = [NSURLRequest requestWithURL:url];
 
    [self.webView loadRequest:request1];
  
    [self.view addSubview:self.webView];
    
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
//    self.webView.configuration.allowsInlineMediaPlayback = NO;
//    self.webView.configuration.allowsAirPlayForMediaPlayback=NO;
    self.webView.allowsLinkPreview=YES;
    // 添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    // 添加进入条
    

    
    _webProgressLayer = [[YJWebProgressLayer alloc] init];
    _webProgressLayer.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);
    
    [self.navigationController.navigationBar.layer addSublayer:_webProgressLayer];
    
    
    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本
    
    [userCC addScriptMessageHandler:self name:@"closeView"];

    [userCC addScriptMessageHandler:self name:@"showName"];

    [userCC addScriptMessageHandler:self name:@"startShot"];
    [userCC addScriptMessageHandler:self name:@"submit"];
    [userCC addScriptMessageHandler:self name:@"datas"];
    [userCC addScriptMessageHandler:self name:@"chat"];
    [userCC addScriptMessageHandler:self name:@"shuaxin"];
    [userCC addScriptMessageHandler:self name:@"learningReminder"];
    [userCC addScriptMessageHandler:self name:@"downloadVideo"];
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    [userCC addScriptMessageHandler:self name:@"sys"];
    [userCC addScriptMessageHandler:self name:@"queryPhoto"];
    [userCC addScriptMessageHandler:self name:@"frashMeta"];
    [userCC addScriptMessageHandler:self name:@"goback"];
    [userCC addScriptMessageHandler:self name:@"login"];
    HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode=MBProgressHUDModeIndeterminate;
    HUD.labelText=@"拼命加载中...";
    HUD.dimBackground=NO;
    HUD.animationType=MBProgressHUDAnimationFade;
  
    UIButton * downloadBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    downloadBtn.frame=CGRectMake(0, 200, 80, 80);
    
    downloadBtn.backgroundColor=[UIColor redColor];
    [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:downloadBtn];
    UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, HEIGHT*35/568)];
    
    topView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    
    
    UIImageView * jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 300/320,HEIGHT* 10/568, WIDTH * 8/320,HEIGHT *15/568)];
    
    jiantou.image=[UIImage imageNamed:@"quxiao"];
    jiantou.contentMode=UIViewContentModeCenter;
    [topView addSubview:jiantou];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame=CGRectMake(0, 0, WIDTH-WIDTH*35/375, HEIGHT*35/568) ;
    
    
    [button addTarget:self action:@selector(downloadList:) forControlEvents:UIControlEventTouchUpInside];
            
    [topView addSubview:button];
    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,WIDTH, HEIGHT*35/568)];
    label.text=@"已添加至缓存列表";
    label.textColor=[UIColor whiteColor];
   
    label.font=[UIFont systemFontOfSize:16];
    
    label.textAlignment=NSTextAlignmentLeft;
    [topView addSubview:label];
    
    topView.tag=12345;
    topView.hidden=YES;
    
    
    UIButton * hide=[UIButton buttonWithType:UIButtonTypeSystem];
    hide.frame=CGRectMake(WIDTH-WIDTH*35/375, 0, WIDTH*35/375, WIDTH*35/375);
    
    [hide addTarget:self action:@selector(hideTopView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:hide];
    [self.view addSubview:topView];
    
  
//    self.webView.scrollView.bounces=NO;
    
    
    
    
}
-(void)hideTopView{
    
    UIView * topView=[self.view viewWithTag:12345];
    topView.hidden=YES;
}
-(void)downloadList:(UIButton *)button{
    offLineStudyViewController * off=[[offLineStudyViewController alloc]init];
    
    [self.navigationController pushViewController:off animated:YES];
    


}
-(void)download:(UIButton*)button{
    
    UIView * topView=[self.view viewWithTag:12345];
    
      NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    if ([[user objectForKey:@"downloadArr"] count]>0) {
        downloadArr=[NSMutableArray arrayWithArray:[user objectForKey:@"downloadArr"]];
        if ([downloadArr containsObject:[user objectForKey:@"KPDATA"]]) {
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该视频已缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
        }else{
            
            topView.hidden=NO;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                topView.hidden=YES;
            });
            [downloadArr insertObject:[user objectForKey:@"KPDATA"] atIndex:0];
        }
    }else{
        downloadArr =[NSMutableArray new];
        if ([user objectForKey:@"KPDATA"]) {
            [downloadArr addObject:[user objectForKey:@"KPDATA"]];
            topView.hidden=NO;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                topView.hidden=YES;
            });

        }else{
        
            [MBProgressHUD showError:@"资源未找到"];
        
        
        }
    }
    
    [user setObject:downloadArr forKey:@"downloadArr"];
    
    
    
      MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:[user objectForKey:@"KPDATA"][@"videoSour"][@"INIT"]];
    
    
    
      receipt.successBlock = ^(NSURLRequest * _Nullablerequest, NSHTTPURLResponse * _Nullableresponse, NSURL * _NonnullfilePath) {
      
      
    };
    
    receipt.failureBlock = ^(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response,  NSError * _Nonnull error) {
       
    };
    
    [[MCDownloadManager defaultInstance] downloadFileWithURL:[user objectForKey:@"KPDATA"][@"videoSour"][@"INIT"]progress:^(NSProgress * _Nonnull downloadProgress, MCDownloadReceipt *receipt){}destination:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSURL * _Nonnull filePath) {}failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {}];
    
    

}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
   
    NSString * token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    
    
    
    
    if ([message.name isEqualToString:@"startShot"]) {
        if ([message.body isEqualToString:@"start"]) {
            ShootVideoViewController * shoot=[[ShootVideoViewController alloc]init];
            
            UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:shoot];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
    if ([message.name isEqualToString:@"showName"]) {
      
        
        
        
    }
    if ([message.name isEqualToString:@"sys"]) {
        
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        NSString * token=[user objectForKey:@"token"];
        
        if (token.length>5) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            
            if(authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                
                UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相机\"中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [av show];
                
            }else{
                
                SGScanningQRCodeVC * search=[[SGScanningQRCodeVC alloc]init];
                [self.navigationController pushViewController:search animated:YES];
            }
        }else{
            
            NewLoginViewController * his=[[NewLoginViewController alloc]init];
            UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
            nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
            
            
        }
        
    }
    
    if ([message.name isEqualToString:@"closeView"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }if ([message.name isEqualToString:@"chat"]) {
        NSDictionary * dic=(NSDictionary*)message.body;
        ChatViewController * chat=[[ChatViewController alloc]init];
        chat.friendJid=dic[@"userID"];
        chat.name=dic[@"userName"];
        chat.headImage=dic[@"headImage"];
        [self.navigationController pushViewController:chat animated:YES];
        
    }
//    if ([message.name isEqualToString:@"shuaxin"]) {
//        
//        [self loadHeadBtn];
//    }
    if ([message.name isEqualToString:@"2"]) {
     
    }
    if ([message.name isEqualToString:@"learningReminder"]) {
        
        
        
        
        [MTA trackCustomEvent:@"brower_remind" args:[NSArray arrayWithObject:@"arg0"]];

        if (token.length>5) {
           [self setupDateView:DateTypeOfStart];
            
            if ([message.body count]>1) {
            NSDictionary * dic=(NSDictionary * )message.body;
            _kpID=[NSString stringWithFormat:@"%@",dic[@"knowledge_id"]];
            _kpTitle=[NSString stringWithFormat:@"%@",dic[@"knowledge_title"]];
            }
        }else{
            [self loadLoginView];
            
            
        }

        
    }if ([message.name isEqualToString:@"downloadVideo"]) {
        
        
        [MTA trackCustomEvent:@"brower_video_down" args:[NSArray arrayWithObject:@"arg0"]];

        
        if (token.length>8) {
            [self download:nil];
        }else{
            [self loadLoginView];
        
          
        }
        
        
        
    }
    if ([message.name isEqualToString:@"login"]) {
        
        if (token.length>5) {
            
        }else{
            
            [self loadLoginView];
            
            
        }
        
    }
    
    if ([message.name isEqualToString:@"showMobile"]) {
       
        
    }if ([message.name isEqualToString:@"goback"]) {
        if ([message.body isEqualToString:@"3"]) {
            [self.webView goBack];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.webView reload];
            });
            

        }
        if ([message.body isEqualToString:@"2"]) {
            
            [self.webView reload];
        }
        if ([message.body isEqualToString:@"1"]) {
            [self.webView goBack];
           
        }
    }
    
    if ([message.name isEqualToString:@"frashMeta"]) {
            [self.webView evaluateJavaScript:@"document.getElementsByTagName('head')[0].innerHTML" completionHandler:^(id _Nullable arr, NSError * _Nullable error) {
        
                _htmlData=[arr dataUsingEncoding:NSUTF8StringEncoding];
        
        
                [self loadHeadBtn1];
                
            }];
    }if ([message.name isEqualToString:@"queryPhoto"]) {
        NSDictionary *dic=(NSDictionary *)message.body;
        NSArray * arr=[dic[@"url"] componentsSeparatedByString:@","];
        NSMutableArray * arr1=[NSMutableArray arrayWithArray:arr];
        
        [arr1 removeLastObject];
        
        [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:[dic[@"index"] integerValue]-1 imagesBlock:^NSArray *{
            return arr1;
        }];
    }
    
}
-(void)loadLoginView{

    NewLoginViewController * his=[[NewLoginViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    [self presentViewController:nav animated:YES completion:^{
        [self.webView goBack];

    }];


}



- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
    
    
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/add_study_plan.mob",URLDOMAIN];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"]) {
        _dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"title":[[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"],@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"],@"planTime":date};
    }else{
    
    _dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"title":_kpTitle,@"kpID":_kpID,@"planTime":date};
    
    }
    
    
    
    [manager POST:url parameters:_dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * str=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
        if ([str isEqualToString:@"1"]) {
            
            
            NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
            
            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            NSDate* date1 = [df dateFromString:date];
          
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            
            NSDate *pushDate = date1;
            UIApplication *app = [UIApplication sharedApplication];
            if (notification != nil) {
                // 设置推送时间
                notification.fireDate = pushDate;
                // 设置时区
                notification.timeZone = [NSTimeZone systemTimeZone];
                // 设置重复间隔
                notification.repeatInterval = 0;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                
//                notification.soundName = @"Bell.caf";
                // 推送内容
                notification.alertBody = @"是时候学习知识点啦";
                notification.userInfo=@{@"type":@"alarm",@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"]};
                //显示在icon上的红色圈中的数字
                notification.applicationIconBadgeNumber = 1;
                //添加推送到UIApplication
                
                [app scheduleLocalNotification:notification];
                
            }
            
//            else{
//                //获取所有除与调度中的数组
//                NSArray *locationArr = app.scheduledLocalNotifications;
//                if (locationArr)
//                {
//                    for (UILocalNotification *ln in locationArr)
//                    {
//                        NSDictionary *dict =  ln.userInfo;
//                        
//                        if (dict)
//                        {
//                            NSString *obj = [dict objectForKey:@"amer.org"];
//                            
//                            if ([obj isEqualToString:@"key"])
//                            {
//                                //取消调度通知
//                                [app cancelLocalNotification:ln];
//                            }
//                        }
//                    }
//                }
//            }

            
            
            
            
            [self.webView evaluateJavaScript:@"Toast('添加成功','2000')" completionHandler:^(id _Nullable res, NSError * _Nullable error) {
                
            }];
            
        }
        if ([str isEqualToString:@"-1"]) {
            [self.webView evaluateJavaScript:@"Toast('添加失败','2000')" completionHandler:^(id _Nullable res, NSError * _Nullable error) {
                
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    switch (type) {
        case DateTypeOfStart:
            
            break;
            
        case DateTypeOfEnd:
            
            break;
        default:
            break;
    }
    
    
}
- (void)setupDateView:(DateType)type {
    
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor clearColor]];
    _pickerView.delegate = self;
    _pickerView.type = type;
    [self.view addSubview:_pickerView];
    
}

-(void)tapIconView{

    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
    
    _closeButton=@"no";
    
    _backButton=@"no";
    _htmlData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:self.webUrl]];
    
    [self.webView reload];


}

-(void)LoginButton:(UIButton *)button{
    
    NewLoginViewController * new=[[NewLoginViewController alloc]init];
    
    [self.navigationController pushViewController:new animated:YES];
    
}
-(void)fanhui:(UIBarButtonItem*)button{
    
    
    
    if (_closeButtonEvent.length>0) {
        [self.webView evaluateJavaScript:_closeButtonEvent completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            
        }];
    }else{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    }];
    
    
    
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navBarBgAlpha=@"1.0";
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/kpDetail4New.mob?token=%@&kpID=%@&adapterSize=1080",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        if ([dic count]>0) {

            
            
            
            
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:dic[@"kpData"]];
            for (NSString *keyStr in mutableDic.allKeys) {
                
                if ([[mutableDic objectForKey:keyStr] isEqual:[NSNull null]]) {
                    
                    [mutableDic setObject:@"" forKey:keyStr];
                }
                else{
                    
                    [mutableDic setObject:[mutableDic objectForKey:keyStr] forKey:keyStr];
                }
            }
            
            
            [userInfo setObject:mutableDic forKey:@"KPDATA"];

            
            
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        _testLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(100, 300, 180, 21)];
        
        self.testLabel.speed = 0.8;
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 21)];
        
        label.text=self.webView.title;
        label.font=[UIFont systemFontOfSize:18*WIDTH/375];
        [label sizeToFit];
        _testLabel.frame=label.frame;
        if (label.frame.size.width>212*WIDTH/375) {
            _testLabel.frame=CGRectMake(0, 0, 212*WIDTH/375, 21);
        }
        self.testLabel.text=self.webView.title;
        self.testLabel.textColor = [UIColor whiteColor];
        self.testLabel.font = [UIFont systemFontOfSize:WIDTH*18/375];
        self.navigationItem.titleView=self.testLabel;
       
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        NSLog(@"%f",_webView.estimatedProgress);
    }if ([keyPath isEqualToString:@"token"]) {
        [self.webView reload];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ba/mp/me/index?platform=ios&token=%@",URLDOMAIN,[user objectForKey:@"token"]]]]];
        
    }
    
    // 加载完成
    if (!self.webView.loading) {
        [HUD hide:YES];

        
    }
}
-(void)gotoCamer:(UIButton *)button{
    
    
    ShootVideoViewController * shoot=[[ShootVideoViewController alloc]init];
    
    
    [self presentViewController:shoot animated:YES completion:^{
        
    }];
    
}



- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
     [self.webView.scrollView.mj_header endRefreshing];
  
    
//    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
//    Reachability * conn=[Reachability reachabilityForInternetConnection];
//    if ([wifi currentReachabilityStatus]==NotReachable&&[conn currentReachabilityStatus]==NotReachable) {
//        _backView=[[UIView alloc]initWithFrame:self.view.bounds];
//        
//        
//        _backView.backgroundColor=[UIColor whiteColor];
//        
//        UIImageView * wifiImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*8.5/320, HEIGHT*8/568,WIDTH* 15/320, WIDTH* 15/320)];
//        wifiImage.image=[UIImage imageNamed:@"icon_wifi_defult_2x"];
//        
//        
//        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT*35/568)];
//        
//        topView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
//        
//        
//        [topView addSubview:wifiImage];
//        
//        
//        
//        
//        
//        
//        UIImageView * jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 300/320,HEIGHT* 10/568, WIDTH * 8/320,HEIGHT *15/568)];
//        
//        jiantou.image=[UIImage imageNamed:@"icon_go_defult_2x"];
//        [topView addSubview:jiantou];
//        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
//        
//        button.frame=CGRectMake(0, 0, WIDTH, HEIGHT*35/568) ;
//        
//        
//        [button addTarget:self action:@selector(nonetCon:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [topView addSubview:button];
//        
//        
//        
//        
//        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT*35/568)];
//        label.text=@"网络请求失败，请检查您的网络设置";
//        label.textColor=[UIColor whiteColor];
//        
//        label.font=[UIFont systemFontOfSize:16];
//        label.textAlignment=NSTextAlignmentCenter;
//        [topView addSubview:label];
//        
//        UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,64+HEIGHT *190/568, WIDTH,HEIGHT *12.5/568)];
//        frist.text=@"亲，您的手机网络不太顺畅哦~";
//        frist.textAlignment=NSTextAlignmentCenter;
//        frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
//        
//        
//        [_backView addSubview:frist];
//        
//        UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
//        
//        second.text=@"请检查您的手机是否联网";
//        
//        second.textAlignment=NSTextAlignmentCenter;
//        
//        second.font=[UIFont systemFontOfSize:15];
//        
//        second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
//        
//        [_backView addSubview:second];
//        
//        
//        [_backView addSubview:topView];
//        
//        //    [_backView addSubview:button];
//        UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
//        chongxin.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
//        
//        [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
//        
//        chongxin.layer.cornerRadius=4.5;
//        
//        
//        [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
//        
//        [chongxin addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [_backView addSubview:chongxin];
//        
//        
//        UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320, 64+HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
//        big.image=[UIImage imageNamed:@"image_net"];
//        
//        
//        [_backView addSubview:big];
//        
//        
//        [self.view addSubview:_backView];
//        
//        
//    }else{
//        
//        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
//        view.backgroundColor=[UIColor whiteColor];
//        
//        view.tag=1200;
//        
//        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
//        
//        
//        imageView.image=[UIImage imageNamed:@"image_server"];
//        
//        
//        [view addSubview:imageView];
//        
//        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
//        
//        label1.text=@"服务器开小差了~工程师正在召唤它...";
//        label1.font=[UIFont systemFontOfSize:18];
//        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//        
//        label1.textAlignment=NSTextAlignmentCenter;
//        
//        [view addSubview:label1];
//        
//        
//        
//        UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
//        
//        second1.text=@"意见";
//        
//        second1.textAlignment=NSTextAlignmentLeft;
//        
//        second1.font=[UIFont systemFontOfSize:14];
//        
//        second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
//        
//        [view addSubview:second1];
//        
//        UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
//        
//        fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
//        [fankui setTitle:@"反馈" forState:UIControlStateNormal];
//        fankui.titleLabel.font=[UIFont systemFontOfSize:14];
//        [view addSubview:fankui];
//        
//        UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
//        
//        xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
//        
//        [view addSubview:xiahua];
//        
//        
//        UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
//        chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
//        
//        [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
//        
//        chongxin1.layer.cornerRadius=4.5;
//        
//        
//        [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
//        
//        [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [view addSubview:chongxin1];
//        
//        [self.view addSubview:view];
//        
//        
//        
//    }
//    
    
    
}


-(void)shuaxin:(UIButton*)button{
    
    
    [_backView removeFromSuperview];
    _backView=nil;
    UIView * view=[self.view viewWithTag:1200];
    [view removeFromSuperview];
    
    view=nil;
    
    NSURL * url=[NSURL URLWithString:self.webUrl];
    
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}

-(void)Shuaxinshuju{


    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    
    
    // 设置localStorage
    NSString *jsString = [NSString stringWithFormat:@"sessionStorage.setItem('userContent', '%@')", token];
    // 移除localStorage
    // NSString *jsString = @"localStorage.removeItem('userContent')";
    // 获取localStorage
    // NSString *jsString = @"localStorage.getItem('userContent')";
    [self.webView evaluateJavaScript:jsString completionHandler:nil];

}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];

    
    // 设置localStorage
    NSString *jsString = [NSString stringWithFormat:@"sessionStorage.setItem('userContent', '%@')", token];
  
    [self.webView evaluateJavaScript:jsString completionHandler:nil];

    
    
    [_webProgressLayer finishedLoadWithError:nil];
   
    if (token.length>5) {
        
    }else{
//    [self.webView evaluateJavaScript:@"$('#sLWLHidden').hide(); $('#sLWkHidden').hide();" completionHandler:^(id _Nullable res, NSError * _Nullable error) {
//        
//    }];
    }
}


- (void)loadHeadBtn1{
    
    NSMutableArray * modelArr=[NSMutableArray new];
    [_rightButtonArr removeAllObjects];
    
    [self.webView.scrollView.mj_header endRefreshing];
    _closeButton=@"no";
    _backButton=@"no";
   
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:_htmlData];
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//meta"];
    
 
    for (TFHppleElement *hppleElement in itemArray) {
        
            NSString * type=[hppleElement objectForKey:@"type"];
        
            
            if ([type isEqualToString:@"bagRightBtn"]) {
                
                
                
                
                
                _rightBtnDic=[[NSMutableDictionary alloc]initWithObjects:@[[hppleElement objectForKey:@"text"],[hppleElement objectForKey:@"onclick"]] forKeys:@[@"text",@"event"]];
                
                
                [_rightButtonArr addObject:_rightBtnDic];
                
            }else if ([type isEqualToString:@"bagBackBtn"]) {
                
                _backButton=@"yes";
                _backButtonEvent=[hppleElement objectForKey:@"onclick"];
                
                
            }else if ([type isEqualToString:@"bagCloseBtn"]) {
                
                _closeButton=@"yes";
                _closeButtonText=[hppleElement objectForKey:@"text"];
                _closeButtonEvent=[hppleElement objectForKey:@"onclick"];
                
            }
            
    
        }
        


    if (_rightButtonArr.count==0) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
        [self.navigationItem setRightBarButtonItem:right];
        
    }
    
    
    
    
    if ([_backButton isEqualToString:@"no"]&&[_closeButton isEqualToString:@"no"]&&_rightButtonArr.count==0) {
        
        
        _button1=[UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame=CGRectMake(0, 0, 10, 20);
        
        [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
        UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
        [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
        
        button2.frame=CGRectMake(0, 0, 50, 20);
        [button2 setTitle:@"关闭" forState:UIControlStateNormal];
        
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button2 addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:button2];
        [self.navigationItem setLeftBarButtonItems:@[left,left1]];
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
        [self.navigationItem setRightBarButtonItem:right];
        
        
        
    }else{
        
        
        if (_rightButtonArr.count==1) {
            
            UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.frame=CGRectMake(0, 0, 60, 40);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
            [button setTitle:_rightButtonArr[0][@"text"] forState:UIControlStateNormal];
            
            button.titleLabel.textAlignment=NSTextAlignmentRight;
            
            _rightButtonEvent=_rightButtonArr[0][@"event"];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(aloneBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
            [self.navigationItem setRightBarButtonItem:right];
            
            
            
        }if (_rightButtonArr.count>1) {
            
            UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame=CGRectMake(0, 0, 20, 5);
            //            button.backgroundColor=[UIColor redColor];
            
            [button setImage:[UIImage imageNamed:@"youshangjiaotubiao"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(configerView) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
            [self.navigationItem setRightBarButtonItem:right];
            
            
            for (NSDictionary * subDic in _rightButtonArr) {
                __weak typeof(self) weakSelf = self;
                
                
                
                //菜单模型0
                FFDropDownMenuModel *menuModel = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:subDic[@"text"] menuItemIconName:@"menu2"  menuBlock:^{
                    
                    
                    if ([subDic[@"text"] isEqualToString:@"分享"]) {
                        UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"朋友圈",@"微信好友", nil];
                        sheet.tag=1000;
                        [sheet showInView:self.view];
                    }
                    
                    
                    [weakSelf.webView evaluateJavaScript:subDic[@"event"] completionHandler:^(id _Nullable response , NSError * _Nullable error) {
                
                    }];
                    if ([subDic[@"event"] isEqualToString:@"btn2('请添加查看页路径')"]) {
                        myLocalValueViewController * my=[[myLocalValueViewController alloc]init];
                        
                        [self.navigationController pushViewController:my animated:YES];
                    }
                    
                }];
                
                [modelArr addObject:menuModel];
                
                
            }
            
            self.dropdownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:modelArr menuWidth:FFDefaultFloat eachItemHeight:FFDefaultFloat menuRightMargin:FFDefaultFloat triangleRightMargin:FFDefaultFloat];
            
            
        }
        
        
        
        
        
        
        
        if ([_backButton isEqualToString:@"no"]&&[_closeButton isEqualToString:@"yes"]) {
            
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
            
            
            UIBarButtonItem * left12=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [self.navigationItem setLeftBarButtonItems:@[left,left12]];
            
            
            UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button3.frame=CGRectMake(0, 0, 40, 20);
            
            [button3 setTitle:_closeButtonText forState:UIControlStateNormal];
            
            [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button3 addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:button3];
            [self.navigationItem setLeftBarButtonItem:left1];
        }else if ([_backButton isEqualToString:@"yes"]&&[_closeButton isEqualToString:@"yes"]) {
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            _button1.frame=CGRectMake(0, 0, 10, 20);
            [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
            button3.frame=CGRectMake(0, 0, 50, 20);
            [button3 setTitle:@"关闭" forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button3 addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:button3];
            [self.navigationItem setLeftBarButtonItems:@[left,left1]];
        }else if ([_backButton isEqualToString:@"yes"]&&[_closeButton isEqualToString:@"no"]) {
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
            UIBarButtonItem * left12=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [self.navigationItem setLeftBarButtonItems:@[left,left12]];
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            _button1.frame=CGRectMake(0, 0, 10, 20);
            [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
            UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationItem setLeftBarButtonItem:left1];
            
            
        }else if ([_backButton isEqualToString:@"no"]&&[_closeButton isEqualToString:@"no"]) {
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
            UIBarButtonItem * left12=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [self.navigationItem setLeftBarButtonItems:@[left,left12]];
        }
        
    }
    
    
}



- (void)loadHeadBtn{

    NSMutableArray * modelArr=[NSMutableArray new];
    [_rightButtonArr removeAllObjects];
    
    [self.webView.scrollView.mj_header endRefreshing];
    _closeButton=@"no";
    _backButton=@"no";
    _htmlData = [[NSData alloc]initWithContentsOfURL:_headURL];
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:_htmlData];
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//head"];
    
    
    for (TFHppleElement *hppleElement in itemArray) {
        NSArray * metaElementArr=[hppleElement  searchWithXPathQuery:@"//meta"];

        
        
        for (TFHppleElement*tempElement in metaElementArr) {
            NSString * type=[tempElement objectForKey:@"type"];
            
            
            if ([type isEqualToString:@"bagRightBtn"]) {
                
                _rightBtnDic=[[NSMutableDictionary alloc]initWithObjects:@[[tempElement objectForKey:@"text"],[tempElement objectForKey:@"onclick"]] forKeys:@[@"text",@"event"]];
                
               
                [_rightButtonArr addObject:_rightBtnDic];
                
               
                
            }else if ([type isEqualToString:@"bagBackBtn"]) {
                
                
                
                _backButton=@"yes";
                
                
                
                _backButtonEvent=[NSString stringWithFormat:@"%@",[tempElement objectForKey:@"onclick"]];
//                _backButtonEvent=[tempElement objectForKey:@"onclick"];
                
               
                
                
            }else if ([type isEqualToString:@"bagCloseBtn"]) {
                
                _closeButton=@"yes";
                _closeButtonText=[tempElement objectForKey:@"text"];
                _closeButtonEvent=[NSString stringWithFormat:@"%@",[tempElement objectForKey:@"onclick"]];
                
            }
            
            
        }
        
        
        
    }if (_rightButtonArr.count==0) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
        [self.navigationItem setRightBarButtonItem:right];
        
    }
    
    
    
    
    if ([_backButton isEqualToString:@"no"]&&[_closeButton isEqualToString:@"no"]&&_rightButtonArr.count==0) {
        
        
        _button1=[UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame=CGRectMake(0, 0, 10, 20);
        
        [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
        UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
        [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
        
        button2.frame=CGRectMake(0, 0, 50, 20);
        [button2 setTitle:@"关闭" forState:UIControlStateNormal];
        
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button2 addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:button2];
        [self.navigationItem setLeftBarButtonItems:@[left,left1]];
        
        
        
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
        [self.navigationItem setRightBarButtonItem:right];
        
        
        
    }else{
        
        
        if (_rightButtonArr.count==1) {
            
            UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.frame=CGRectMake(0, 0, 60, 40);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
            [button setTitle:_rightButtonArr[0][@"text"] forState:UIControlStateNormal];
            
            button.titleLabel.textAlignment=NSTextAlignmentRight;
            
            _rightButtonEvent=_rightButtonArr[0][@"event"];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(aloneBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
            [self.navigationItem setRightBarButtonItem:right];
            
            
            
        }if (_rightButtonArr.count>1) {
            
            UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame=CGRectMake(0, 0, 20, 5);
            //            button.backgroundColor=[UIColor redColor];
            
            [button setImage:[UIImage imageNamed:@"youshangjiaotubiao"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(configerView) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:button];
            [self.navigationItem setRightBarButtonItem:right];
            
            
            for (NSDictionary * subDic in _rightButtonArr) {
                __weak typeof(self) weakSelf = self;
                //菜单模型0
                FFDropDownMenuModel *menuModel = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:subDic[@"text"] menuItemIconName:@"menu2"  menuBlock:^{
                    
                    
                    if ([subDic[@"text"] isEqualToString:@"分享"]) {
                        UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"朋友圈",@"微信好友", nil];
                        sheet.tag=1000;
                        [sheet showInView:self.view];
                    }
                    
                    
                    [weakSelf.webView evaluateJavaScript:subDic[@"event"] completionHandler:^(id _Nullable response , NSError * _Nullable error) {
                        
                    }];
                    if ([subDic[@"event"] isEqualToString:@"btn2('请添加查看页路径')"]) {
                        myLocalValueViewController * my=[[myLocalValueViewController alloc]init];
                        
                        [self.navigationController pushViewController:my animated:YES];
                    }
                    
                }];
                
                [modelArr addObject:menuModel];
                
                
            }
            
            self.dropdownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:modelArr menuWidth:FFDefaultFloat eachItemHeight:FFDefaultFloat menuRightMargin:FFDefaultFloat triangleRightMargin:FFDefaultFloat];
            
            
        }
        
        
        if ([_backButton isEqualToString:@"no"]&&[_closeButton isEqualToString:@"yes"]) {
            
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
            
            
            UIBarButtonItem * left12=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [self.navigationItem setLeftBarButtonItems:@[left,left12]];
            
            
            UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button3.frame=CGRectMake(0, 0, 40, 20);
            
            [button3 setTitle:_closeButtonText forState:UIControlStateNormal];
            
            [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button3 addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:button3];
            [self.navigationItem setLeftBarButtonItem:left1];
        }else if ([_backButton isEqualToString:@"yes"]&&[_closeButton isEqualToString:@"yes"]) {
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            _button1.frame=CGRectMake(0, 0, 10, 20);
            [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
            button3.frame=CGRectMake(0, 0, 50, 20);
            [button3 setTitle:@"关闭" forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button3 addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:button3];
            [self.navigationItem setLeftBarButtonItems:@[left,left1]];
        }else if ([_backButton isEqualToString:@"yes"]&&[_closeButton isEqualToString:@"no"]) {
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
            UIBarButtonItem * left12=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [self.navigationItem setLeftBarButtonItems:@[left,left12]];
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            _button1.frame=CGRectMake(0, 0, 10, 20);
            [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
            UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationItem setLeftBarButtonItem:left1];
            
            
        }else if ([_backButton isEqualToString:@"no"]&&[_closeButton isEqualToString:@"no"]) {
            _button1=[UIButton buttonWithType:UIButtonTypeCustom];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
            [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeSystem];
            UIBarButtonItem * left12=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [self.navigationItem setLeftBarButtonItems:@[left,left12]];
        }
 
    }
    
 
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL * url = navigationAction.request.URL;
    NSString * a=[NSString stringWithFormat:@"%@",url];
    
    [_webProgressLayer startLoad];
    
    _headURL=[NSURL URLWithString:a];
    
   
     [self loadHeadBtn];
  
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
        
    }
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)aloneBtn:(UIButton *)btn{
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    NSString * token
    
    
   
//    UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"点击了%@",_aloneArr] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//    [av show];
    
    
    if ([btn.titleLabel.text isEqualToString:@"分享"]) {
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * token=[user objectForKey:@"token"];
        if (token.length>5) {
            UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"朋友圈",@"微信好友", nil];
            sheet.tag=1000;
            [sheet showInView:self.view];
        }else{
            NewLoginViewController * his=[[NewLoginViewController alloc]init];
            UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
            nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
            
            
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
        
        
       
        
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
//        [self.webView reload];
        
    }
    
    if ([_rightButtonEvent isEqualToString:@"btn2('提交的操作')"]) {
        myLocalValueViewController * my=[[myLocalValueViewController alloc]init];
        [self.navigationController pushViewController:my animated:YES];
        
    }
    
    
    
[self.webView evaluateJavaScript:_rightButtonEvent completionHandler:^(id _Nullable response, NSError * _Nullable error) {
   
   
    
}];


}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // 获取图片 设置图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    
    // 隐藏当前模态窗口
    [self dismissViewControllerAnimated:YES completion:^{
         WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"图片上传中..." animated:YES];
        AFHTTPSessionManager * session=[AFHTTPSessionManager manager];
        session.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/BagServer/uploadimgalone.mup",URLDOMAIN];
        
        [session POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data=UIImagePNGRepresentation(image);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"imgfile" fileName:fileName mimeType:@"text/html"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic=(NSDictionary *)responseObject;
            NSString * str=dic[@"imgurl"];
            NSString * str1=dic[@"resid"];
            NSString * string=[NSString stringWithFormat:@"javascript:actBean.img_choose_app_post('{imgurl : \"%@\",resid : \"%@\",ret : 0}')",str,str1];
            
            [self.webView evaluateJavaScript:string completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                
                [hud dismiss:YES];
                
                
            }];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [hud dismiss:YES];
        }];
        
    }];
    
    
    
    
}



-(void)Back:(UIBarButtonItem*)button{
    
    
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
  
    
    if (_backButtonEvent.length>0) {
        
        if ([_backButtonEvent isEqualToString:@"click_close"]) {
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
        [self.webView evaluateJavaScript:_backButtonEvent completionHandler:^(id _Nullable response , NSError * _Nullable error) {
            
            
            
        }];
    }else{
    
    
    if ([self.webView canGoBack]) {
         [self.webView goBack];
    }else{
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
      }];
    }
  }
}



-(void)nonetCon:(UIButton *)button{
    
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    
    [self.navigationController pushViewController:no animated:YES];
    
}
-(void)configerView{
    [self.dropdownMenu showMenu];

}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    
//    UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//    [av show];
    
   
    if ([message isEqualToString:@"circle_Andorid.chooseIcon"]) {
        
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        
        imagePicker.delegate =self;
        
        // 设置允许编辑
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        
        // 显示图片选择器
        [self presentViewController:imagePicker animated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }];
        //        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        //        imagePicker.delegate = self;
        //        imagePicker.allowsEditing = YES;
        //        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //        [self presentViewController:imagePicker animated:YES completion:^{
        //        }];
        //        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        //        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        vc.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //        vc.mediaTypes = @[(NSString *)kUTTypeMovie];
        //        vc.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        //        vc.videoQuality = UIImagePickerControllerQualityTypeHigh;
        //        vc.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        //        vc.showsCameraControls = YES;
        //        vc.delegate = self;
        //        [self presentViewController:vc animated:YES completion:nil];
        //        [self presentViewController:vc animated:YES completion:^{
        //        [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:NO];
        //        }];
        
        
    }
    if ([message containsString:@"funciton=detail,parameter"]) {
        
        NSArray * arr = [message componentsSeparatedByString:@"="];
        NSString * str= arr[2];
        
        
        NSString * my=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
        if ([str isEqualToString:my]) {
            biaoganViewController * biaogan=[[biaoganViewController alloc]init];
            
         
            
         biaogan.webUrl =   [NSString stringWithFormat:@"%@/WeChat/getMyInfo.wc?state=%@S%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"],[[NSUserDefaults standardUserDefaults]objectForKey:@"companyID"]];
            
            
            [self.navigationController pushViewController:biaogan animated:YES];
        }else{
            DynamicViewController * dy=[[DynamicViewController alloc]init];
            dy.userID=str;
            [self.navigationController pushViewController:dy animated:YES];
            
        }
    }if ([message containsString:@"js_interface.kpDetail"]) {
        NSArray * arr =[message componentsSeparatedByString:@"("];
        
        NSString * str2=[arr[1] componentsSeparatedByString:@")"][0];
        
        biaoganViewController * detail=[[biaoganViewController alloc]init];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * str1=@"1080";
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],str2,str1];
        detail.webUrl=str;
        detail.kpId=str2;
        [user setObject:str2 forKey:@"kpID"];
        
        
         [self.navigationController pushViewController:detail animated:YES];

    }
    
    
    if ([message containsString:@"wv_bridge.open_album()"]) {
     
    }else if([message containsString:@"settings"]){
     
        
    }else if ([message containsString:@"favorites"]){
        
        
        
    }else if ([message containsString:@"contact_us"]){
        
        
        
        
    }else if ([message containsString:@"contacts"]){
        
       
        
        
    }else if ([message containsString:@"posts"]){
        
        
        
    }else if ([message containsString:@"posts"]){
        
        
        
    }
    

//    
//        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//        [av show];

    if ([message containsString:@"video-preview"]) {
        
        ShootVideoViewController * shoot=[[ShootVideoViewController alloc]init];
        
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:shoot];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
    }
    
    
    completionHandler();
    
    
}


-(void) viewDidDisappear:(BOOL)animated
{
    
    if ([self.webUrl containsString:@"kpDetailHtml5.wc"]) {
        

    }
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [_webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
    
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{


}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    decisionHandler(WKNavigationResponsePolicyAllow);
}
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if (actionSheet.tag==1000) {
        
        [MTA trackCustomEvent:@"brower_share" args:[NSArray arrayWithObject:@"arg0"]];

        
        if (buttonIndex==0) {
            
            
            [MTA trackCustomEvent:@"brower_share_pyq" args:[NSArray arrayWithObject:@"arg0"]];

            
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            
            NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
            
            
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                
                NSString * ret=responseObject[@"ret"];
                
                
                
                if ([ret isEqualToString:@"success"]) {
                    
                    
                    NSDictionary * dic=[user objectForKey:@"KPDATA"];
                    
                    
                    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                    sendReq.bText = NO;//不使用文本信息
                    sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                    //创建分享内容对象
                    WXMediaMessage *urlMessage = [WXMediaMessage message];
                    
                    
                    urlMessage.title = dic[@"title"];//分享标题
                    
                    urlMessage.description = dic[@"summary"];//分享描述
                    
                    NSURL *url = [NSURL URLWithString:dic[@"iconUrl"]];
                    
                    
                    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                    
                    
                    
                    UIImage *img = [UIImage imageWithData:data];
                    NSData * imageData1=UIImageJPEGRepresentation(img,0.000);
                    
                    UIImage * image=[UIImage imageWithData:imageData1];
                    
                    
                    
                    if (imageData1.length>20000) {
                        CGSize size  = CGSizeMake(50, 50);
                        
                        UIGraphicsBeginImageContext(size);
                        [image drawInRect:CGRectMake(0,0,size.width,size.height)];
                        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        NSData * Data  = UIImageJPEGRepresentation(newImage, 0.8);
                        
                        
                        
                        [urlMessage setThumbImage:[UIImage imageWithData:Data]];
                        
                    }else{
                        
                        
                        [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                    }
                    //创建多媒体对象
                    WXWebpageObject * webObj = [WXWebpageObject object];
                    webObj.webpageUrl =[NSString stringWithFormat:@"%@",responseObject[@"url"]] ;//分享链接
                    
                    //完成发送对象实例
                    urlMessage.mediaObject = webObj;
                    sendReq.message = urlMessage;
            
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
            
            
        }
        if (buttonIndex==1) {
            [MTA trackCustomEvent:@"brower_share_wechat" args:[NSArray arrayWithObject:@"arg0"]];

            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            
            NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
            
            
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                
                NSString * ret=responseObject[@"ret"];
                if ([ret isEqualToString:@"success"]) {
                    
                    NSDictionary * dic=[user objectForKey:@"KPDATA"];
                    
                    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                    sendReq.bText = NO;//不使用文本信息
                    sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                    //创建分享内容对象
                    WXMediaMessage *urlMessage = [WXMediaMessage message];
                    
                    urlMessage.title = dic[@"title"];//分享标题
                    urlMessage.description = dic[@"summary"];//分享描述
                    //
                    NSURL *url = [NSURL URLWithString:dic[@"iconUrl"]];
                    
                    
                    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                    
                    
                    UIImage *img = [UIImage imageWithData:data];
                    NSData * imageData1=UIImageJPEGRepresentation(img,0.000);
                    
                    UIImage * image=[UIImage imageWithData:imageData1];
                    
                    
                    
                    if (imageData1.length>20000) {
                        CGSize size  = CGSizeMake(50, 50);
                        
                        UIGraphicsBeginImageContext(size);
                        [image drawInRect:CGRectMake(0,0,size.width,size.height)];
                        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        NSData * Data  = UIImageJPEGRepresentation(newImage, 0.8);
                        
                        [urlMessage setThumbImage:[UIImage imageWithData:Data]];
                        
                    }else{
                        [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                    }
                    //创建多媒体对象
                    WXWebpageObject * webObj = [WXWebpageObject object];
                    webObj.webpageUrl =[NSString stringWithFormat:@"%@",responseObject[@"url"]] ;//分享链接
                    
                    //完成发送对象实例
                    urlMessage.mediaObject = webObj;
                    sendReq.message = urlMessage;
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
            
            
        }
        
        
    }
   
    
}


@end
