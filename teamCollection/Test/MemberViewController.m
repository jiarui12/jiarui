//
//  MemberViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/13.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MemberViewController.h"

#import <WebKit/WebKit.h>
#import "Reachability.h"
#import "ChatViewController.h"

#import "biaoganViewController.h"

#import "UIImage+GIF.h"
#import "NewLoginViewController.h"

#import "PrefixHeader.pch"
#import "MBProgressHUD+HM.h"
#import "AFNetworking.h"
#import "DynamicViewController.h"
#import "WKProgressHUD.h"
#import "MBProgressHUD+HM.h"
#import "nonetConViewController.h"
#import "ShootVideoViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface MemberViewController ()<memberViewController,UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property(nonatomic,strong)WKWebView * webView;
@property(nonatomic,strong)UIImage * image;
@property(nonatomic,strong)NSString * Width;
@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)NSUserDefaults * user;
@property(nonatomic,strong)WKProgressHUD *hud;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIProgressView * progressView;
@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   _user=[NSUserDefaults standardUserDefaults];
    self.navigationItem.title=@"标杆";

    _button1=[UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame=CGRectMake(0, 0, 10, 20);
    [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
    [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
//    NSURL * url=[NSURL URLWithString:@"https://www.baidu.com/"];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    //    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"wv_bridge"];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-49-64) configuration:config];
    _webView.allowsBackForwardNavigationGestures=YES;
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/WeChat/exampleRank.wc?platform=ios&userID=%@&companyID=%@&token=%@",URLDOMAIN,[_user objectForKey:@"userID"],[_user objectForKey:@"companyID"],[_user objectForKey:@"token"]]];
    
    NSURLRequest* request1 = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request1];
    
    [self.view addSubview:self.webView];
    
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
    
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
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.frame = CGRectMake(0, 42, self.view.frame.size.width, 1);
    self.progressView.progressTintColor=[UIColor greenColor];
    [self.navigationController.navigationBar addSubview:self.progressView];

    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本
    [userCC addScriptMessageHandler:self name:@"startShot"];
    [userCC addScriptMessageHandler:self name:@"submit"];
    [userCC addScriptMessageHandler:self name:@"datas"];
    [userCC addScriptMessageHandler:self name:@"chat"];
    [userCC addScriptMessageHandler:self name:@"shuaxin"];
    [userCC addScriptMessageHandler:self name:@"learningReminder"];
    [userCC addScriptMessageHandler:self name:@"downloadVideo"];
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    
    [userCC addScriptMessageHandler:self name:@"queryPhoto"];
    [userCC addScriptMessageHandler:self name:@"frashMeta"];

    
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"chat"]) {
        NSDictionary * dic=(NSDictionary*)message.body;
        ChatViewController * chat=[[ChatViewController alloc]init];
        chat.friendJid=dic[@"userID"];
        chat.name=dic[@"userName"];
        chat.headImage=dic[@"headImage"];
        chat.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:chat animated:YES];
        
    }
    

}

-(void)LoginButton:(UIButton *)button{

    NewLoginViewController * new=[[NewLoginViewController alloc]init];
    new.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:new animated:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
    
    if (token.length>5) {
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/WeChat/exampleRank.wc?platform=ios&userID=%@&companyID=%@&token=%@",URLDOMAIN,[_user objectForKey:@"userID"],[_user objectForKey:@"companyID"],[_user objectForKey:@"token"]]];
        
        NSURLRequest* request1 = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request1];
    }else{
        [self.webView removeFromSuperview];
    
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor whiteColor];
        
        view.tag=12;
        
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
        
        
        imageView.image=[UIImage imageNamed:@"weidengluyemian"];
        
        
        [view addSubview:imageView];
        
        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*175/568, WIDTH, 20)];
        
        label1.text=@"标杆目前暂无排名哦~";
        label1.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label1.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label1];
        
        UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*205/568, WIDTH, 20)];
        
        label2.text=@"登录后将看到更多伙伴排名";
        label2.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label2.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label2.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label2];

        
        
        UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
        chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
        
        [chongxin1 setTitle:@"登录" forState:UIControlStateNormal];
        
        chongxin1.layer.cornerRadius=4.5;
        
        
        [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [chongxin1 setBackgroundColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0]];
        
        [chongxin1 addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:chongxin1];
        
        [self.view addSubview:view];
        

    }
    
    
    

}
-(void)Login:(UIButton *)button{
    NewLoginViewController * his=[[NewLoginViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        //        self.navigationItem.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"progress: %f", self.webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.webView.estimatedProgress==1.000000) {
            [self.progressView removeFromSuperview];
            _progressView=nil;
        }
        
        
    }if ([keyPath isEqualToString:@"token"]) {
        [self.webView reload];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ba/mp/me/index?platform=ios&token=%@",URLDOMAIN,[user objectForKey:@"token"]]]]];
        
    }
    
    // 加载完成
    if (!self.webView.loading) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}
-(void)gotoCamer:(UIButton *)button{
    
  

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%@",error);
    
    
    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus]==NotReachable&&[conn currentReachabilityStatus]==NotReachable) {
        _backView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        
        _backView.backgroundColor=[UIColor whiteColor];
        
        UIImageView * wifiImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*8.5/320, HEIGHT*8/568,WIDTH* 15/320, WIDTH* 15/320)];
        wifiImage.image=[UIImage imageNamed:@"icon_wifi_defult_2x"];
        
        
        
        
        
        
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT*35/568)];
        
        topView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        
        
        [topView addSubview:wifiImage];
        
        
        
        
        
        
        UIImageView * jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 300/320,HEIGHT* 10/568, WIDTH * 8/320,HEIGHT *15/568)];
        
        jiantou.image=[UIImage imageNamed:@"icon_go_defult_2x"];
        [topView addSubview:jiantou];
        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
        
        button.frame=CGRectMake(0, 0, WIDTH, HEIGHT*35/568) ;
        
        
        [button addTarget:self action:@selector(nonetCon:) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:button];
        
        
        
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT*35/568)];
        label.text=@"网络请求失败，请检查您的网络设置";
        label.textColor=[UIColor whiteColor];
        
        label.font=[UIFont systemFontOfSize:16];
        label.textAlignment=NSTextAlignmentCenter;
        [topView addSubview:label];
        
        UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,64+HEIGHT *190/568, WIDTH,HEIGHT *12.5/568)];
        frist.text=@"亲，您的手机网络不太顺畅哦~";
        frist.textAlignment=NSTextAlignmentCenter;
        frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        
        
        [_backView addSubview:frist];
        
        UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
        
        second.text=@"请检查您的手机是否联网";
        
        second.textAlignment=NSTextAlignmentCenter;
        
        second.font=[UIFont systemFontOfSize:15];
        
        second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        
        [_backView addSubview:second];
        
        
        [_backView addSubview:topView];
        
        UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
        chongxin.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
        
        [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
        
        chongxin.layer.cornerRadius=4.5;
        
        
        [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
        
        [chongxin addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_backView addSubview:chongxin];
        
        
        UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320, 64+HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
        big.image=[UIImage imageNamed:@"image_net"];
        
        
        [_backView addSubview:big];
        
        
        [self.view addSubview:_backView];
        
        
    }else{
        
        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor whiteColor];
        
        view.tag=1200;
        
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
        
        
        imageView.image=[UIImage imageNamed:@"image_server"];
        
        
        [view addSubview:imageView];
        
        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
        
        label1.text=@"服务器开小差了~工程师正在召唤它...";
        label1.font=[UIFont systemFontOfSize:18];
        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label1.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label1];
        
        
        
        UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
        
        second1.text=@"意见";
        
        second1.textAlignment=NSTextAlignmentLeft;
        
        second1.font=[UIFont systemFontOfSize:14];
        
        second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        
        [view addSubview:second1];
        
        UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
        
        fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
        [fankui setTitle:@"反馈" forState:UIControlStateNormal];
        fankui.titleLabel.font=[UIFont systemFontOfSize:14];
        [view addSubview:fankui];
        
        UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
        
        xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
        
        [view addSubview:xiahua];
        
        
        UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
        chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
        
        [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
        
        chongxin1.layer.cornerRadius=4.5;
        
        
        [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
        
        [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:chongxin1];
        
        [self.view addSubview:view];
        
        
    }
    
    
    
}


-(void)shuaxin:(UIButton*)button{

   
    [_backView removeFromSuperview];
    _backView=nil;
    UIView * view=[self.view viewWithTag:1200];
    [view removeFromSuperview];
    
    view=nil;
    
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/WeChat/exampleRank.wc?platform=ios&userID=%@&companyID=%@&token=%@",URLDOMAIN,[_user objectForKey:@"userID"],[_user objectForKey:@"companyID"],[_user objectForKey:@"token"]]];
    
    NSURLRequest* request1 = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request1];
    
}




- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    [_progressView removeFromSuperview];
    
    _progressView=nil;
    
    
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.frame = CGRectMake(0, 42, self.view.frame.size.width, 1);
    self.progressView.progressTintColor=[UIColor greenColor];
    [self.navigationController.navigationBar addSubview:self.progressView];
    
    
    NSString * url=[navigationAction.request.URL absoluteString];
    
    
    
    if ([url containsString:@"exampleRank.wc"]) {
        _button1.hidden=YES;
        self.tabBarController.tabBar.hidden=NO;
        UITableView * image=[self.tabBarController.view viewWithTag:130];
        image.hidden=NO;
        [self.webView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49-64)];
    }else{
        _button1.hidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        UITableView * image=[self.tabBarController.view viewWithTag:130];
        image.hidden=YES;
         [self.webView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49-64)];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
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
                NSLog(@"response: %@ error: %@", response, error);
                NSLog(@"call js alert by native");
                [hud dismiss:YES];
                
            }];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    }];
    
    
    
}





-(void)Back:(UIBarButtonItem*)button{

    [self.webView goBack];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)nonetCon:(UIButton *)button{
    
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    no.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:no animated:YES];
    
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
//    UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//    [av show];
    
    
    NSLog(@"%@",message);
    
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
        //                        imagePicker.delegate = self;
        //                       imagePicker.allowsEditing = YES;
        //                       imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //                        imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //
        //
        //
        //        [self presentViewController:imagePicker animated:YES completion:^{
        //
        //        }];
        
        //
        //        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        //        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        vc.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //        vc.mediaTypes = @[(NSString *)kUTTypeMovie];
        //
        //        vc.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        //        vc.videoQuality = UIImagePickerControllerQualityTypeHigh;
        ////            vc.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        //        vc.showsCameraControls = YES;
        //        vc.delegate = self;
        ////        [self presentViewController:vc animated:YES completion:nil];
        //[self presentViewController:vc animated:YES completion:^{
        //      [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:NO];
        
        //}];
        
        
    }if ([message containsString:@"funciton=detail,parameter"]) {
        
        NSArray * arr = [message componentsSeparatedByString:@"="];
        NSString * str= arr[2];
        
        
        NSString * my=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
        if ([str isEqualToString:my]) {
            
            biaoganViewController * detail=[[biaoganViewController alloc]init];
            detail.webUrl=[NSString stringWithFormat:@"%@/WeChat/getMyInfo.wc?state=%@S%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],[[NSUserDefaults standardUserDefaults] objectForKey:@"companyID"]];
            
            
            [self.navigationController pushViewController:detail animated:YES];
            
            
            
        }else{
            DynamicViewController * dy=[[DynamicViewController alloc]init];
            
            
            dy.userID=str;
            [self.navigationController pushViewController:dy animated:YES];
            
        }
        
        
    }if ([message containsString:@"js_interface.kpDetail"]) {
        NSArray * arr =[message componentsSeparatedByString:@"("];
        
        NSString * str2=[arr[1] componentsSeparatedByString:@")"][0];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * str1=@"1080";
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],str2,str1];
        
        NSLog(@"%@",str);
        
        
        [user setObject:str2 forKey:@"kpID"];
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/kpDetail4New.mob",URLDOMAIN];
        NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
        
        NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":str2,@"adapterSize":@"1080"};
        
        [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    }
    
    
    if ([message containsString:@"wv_bridge.open_album()"]) {
           }else if([message containsString:@"settings"]){
      
        
    }else if ([message containsString:@"favorites"]){
        
      
        
        
    }else if ([message containsString:@"contact_us"]){
        
        
        
        
    }else if ([message containsString:@"contacts"]){
        
      
        
        
    }else if ([message containsString:@"posts"]){
        
       
        
    }else if ([message containsString:@"posts"]){
        
      
        
        
    }
    
    
    
    
    
    completionHandler();
    
    
    
    
    
}






@end
