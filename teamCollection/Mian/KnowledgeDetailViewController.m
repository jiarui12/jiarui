//
//  KnowledgeDetailViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "KnowledgeDetailViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "KnowDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "UWDatePickerView.h"
#import "CommentViewController.h"
#import "PrefixHeader.pch"
#import "offLineStudyViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "NewLoginViewController.h"
#import <WebKit/WebKit.h>
#import "commentListViewController.h"
#import "nonetConViewController.h"
#import "Reachability.h"
#import "MBProgressHUD+HM.h"
#import "WKProgressHUD.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface KnowledgeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,KnowledgeDetailDelegate,UIActionSheetDelegate,UWDatePickerViewDelegate,NSURLSessionDownloadDelegate,TencentApiInterfaceDelegate,TencentSessionDelegate,UIAlertViewDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)WKWebView * WKView;
@property(nonatomic,strong)NSString * Width;
@property(nonatomic,strong)NSMutableDictionary * videoSource;
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UWDatePickerView * pickerView;
@property(nonatomic,strong)UIWebView * webView;

@property(nonatomic,strong)NSString * urlString;
@property(nonatomic,strong)UIButton * collectionButton;

@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong)NSURLSessionDownloadTask* downloadTask;


@property(nonatomic,strong)UILabel * progressLabel;

@property(nonatomic,strong)NSMutableArray * kpDataArray;
@property(nonatomic,strong)NSMutableArray * kpURLArray;
@property(nonatomic,strong)WKProgressHUD * hud;

@property(nonatomic,strong)NSMutableArray * KPID;


@end


@implementation KnowledgeDetailViewController
{
    
}
-(void)tencentDidLogin{

}
-(void)tencentDidNotNetWork
{


}
-(void)tencentDidNotLogin:(BOOL)cancelled{


}
- (NSURLSession *)session
{
    if (nil == _session) {
        
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width =[UIScreen mainScreen].applicationFrame.size.width;
    if (width<400) {
        _Width=@"720";
    }if (width>400) {
        _Width=@"1080";
    }
    
    _collectionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _collectionButton.frame=CGRectMake(0, 0, 30, 30);
    [_collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_white_48dp_star"] forState:UIControlStateNormal];
    [_collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_outline_white_48dp_star"] forState:UIControlStateNormal];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:_collectionButton];
    [_collectionButton addTarget:self action:@selector(collectionKnowledge:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(0, 0, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"abc_ic_menu_share_holo_dark"] forState:UIControlStateNormal];
    UIBarButtonItem * right1=[[UIBarButtonItem alloc]initWithCustomView:shareButton];
    [shareButton addTarget:self action:@selector(shareKnowledge:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    
    
    
    if ([self.fenlei isEqualToString:@"微课"]) {
        
        [self getVideoUrl];
    }
   
    
    self.progressLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
    
    _kpDataArray=[NSMutableArray new];
    _kpURLArray=[NSMutableArray new];
    
                 /*取消自动布局*/
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"详情";
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView addSubview:self.progressLabel];
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    
    NSURL * url=[NSURL URLWithString:self.webUrl];

    
    
    
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];

    
    
    NSArray * imageNameArr=@[@"kp_detail_calendar_normal",@"kp_detail_zoom_normal",@"kp_detail_comment_normal",@"kp_detail_download_normal"];
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    _bottomView.backgroundColor=[UIColor whiteColor];
   
    for (int i = 0; i<3; i++) {

        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(30+i*(self.view.frame.size.width/2.2-30), 5, 30, 30);
        [button setBackgroundImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget: self action:@selector(clickBottomView:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
        
    }
     [self.view addSubview:self.bottomView];
    
    
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
}
-(void)reload:(UIButton*)button{
    NSLog(@"reload");

}

-(void)getVideoUrl{
   
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [_hud dismiss:YES];
    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus]==NotReachable&&[conn currentReachabilityStatus]==NotReachable) {
        _backView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        
        _backView.backgroundColor=[UIColor whiteColor];
        
        UIImageView * wifiImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*8.5/320, HEIGHT*8/568,WIDTH* 15/320, WIDTH* 15/320)];
        wifiImage.image=[UIImage imageNamed:@"icon_wifi_defult_2x"];
        
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, HEIGHT*35/568)];
        
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
        
        //    [_backView addSubview:button];
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
-(void)nonetCon:(UIButton *)button{
   
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    
    [self.navigationController pushViewController:no animated:YES];

}
-(void)shuaxin:(UIButton *)button{
    NSLog(@"shuaxin");
    
    
    [_backView removeFromSuperview];
    
    _backView=nil;
    
    
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-40)];
  
    NSURL * url=[NSURL URLWithString:self.webUrl];
    
    
    
    
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];
    

    
    
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowDetailTableViewCell * cell=[KnowDetailTableViewCell cellWithTableView:tableView];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    return cell;
}
-(void)Back:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
}
              /*  点击按钮跳到视频播放器  */
-(void)PresentVideoPlayerController:(UIButton *)button
{
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
   
    
 
    
    
    




    
    
}
-(void)clickBottomView:(UIButton *)button{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (button.tag==0) {
        NSLog(@"学习闹钟");
        if (token.length>5) {
            [self setupDateView:DateTypeOfStart];
        }else{
        
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            av.tag=120;
            
            [av show];
        
        
        }
        
        
        
        
     
        
    }
    if (button.tag==1) {
        NSLog(@"字体大小");
        
        
        
        if (token.length>5) {
            UIActionSheet * ac=[[UIActionSheet alloc]initWithTitle:@"选择字体大小" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"大字号",@"中字号",@"小字号", nil];
            
            ac.tag=120;
            
            [ac showInView:self.view];
        }else{
            
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            av.tag=120;
            
            [av show];
            
            
        }

        
        
        
    }
    if(button.tag==2){
        NSLog(@"评论列表");
        
        
        
        
        if (token.length>5) {
            
//            AllWebViewController  * my=[[AllWebViewController alloc]init];
//            
//            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//            NSString * webUrl=[NSString stringWithFormat:@"%@/WeChat/toComment.wc?platform=ios&userID=%@&companyID=%@&kpID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],self.kpId];
//            my.webUrl=webUrl;
//            my.Title=@"评论";
//            NSLog(@"%@",webUrl);
//            [self.navigationController pushViewController:my animated:YES];
            
        }else{
            
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            av.tag=120;
            
            [av show];
            
            
        }
        
        

        
       
    }
    if(button.tag==3){
//        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//        
//       NSString * kpString=[NSString stringWithFormat:@"string%@",[user objectForKey:@"kpID"]];
//        
//        
//        NSString * KPID=[user objectForKey:kpString];
//        if ([KPID isEqualToString:@"1"]) {
//            
//            
//            
//             [PishumToast showToastWithMessage:@"您已经缓存过本知识点" Length:TOAST_MIDDLE ParentView:self.view];
//            
//            return;
//            
//        }
//        
//        
//        
//         [PishumToast showToastWithMessage:@"知识点缓存中" Length:TOAST_MIDDLE ParentView:self.view];
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/downloadKP4Exam.mob",URLDOMAIN];
        
    
        NSDictionary * para=@{@"token":[user objectForKey:@"token"],@"kpID":[user objectForKey:@"kpID"],@"adapterSize":_Width};
        
       
        
[manager GET:url parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
  
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
    
    NSDictionary * dic=(NSDictionary *)responseObject;
    

    
     NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSArray * arr=[user objectForKey:@"kpData"];
    NSArray * Arr=[user objectForKey:@"kpURL"];
    NSArray * array=[user objectForKey:@"KPID"];
    if (arr) {
        _kpDataArray=[NSMutableArray arrayWithArray:arr];
        _kpURLArray=[NSMutableArray arrayWithArray:Arr];
        _KPID=[NSMutableArray arrayWithArray:array];
    }
    [_kpDataArray addObject:dic[@"kpData"]];
    [_kpURLArray addObject:self.webUrl];
    [_KPID addObject:[user objectForKey:@"kpID"]];
   
    [user setObject:_kpDataArray forKey:@"kpData"];
    [user setObject:_kpURLArray forKey:@"kpURL"];
    [user setObject:_KPID forKey:@"KPID"];
    [NSString stringWithFormat:@"string%@",[user objectForKey:@"kpID"]];
    NSString * kpString=[NSString stringWithFormat:@"string%@",[user objectForKey:@"kpID"]];
    
    [user setObject:@"1" forKey:kpString];
    
    

    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
}];
        
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"功能开发中~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [av show];
        
        
    }
}
-(void)downloadVideoUseUrl:(NSString *)url{

//    NSLog(@"url==%@",url);
//    
//    NSURL * URL=[NSURL URLWithString:url];
//    self.downloadTask=[self.session downloadTaskWithURL:URL];
//    
//    [self.downloadTask resume];
    

}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    
    NSLog(@"%@",file);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:file forKey:self.kpId];
    
    [mgr moveItemAtPath:location.path toPath:file error:nil];
    
    // 提示下载完成
    [[[UIAlertView alloc] initWithTitle:@"下载完成" message:downloadTask.response.suggestedFilename delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.progressLabel.text = [NSString stringWithFormat:@"下载进度:%f",(double)totalBytesWritten/totalBytesExpectedToWrite];
}












-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
      NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if (actionSheet.tag==1000) {
        if (buttonIndex==0) {
            
            
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            
            NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
            
           
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                
                NSLog(@"%@",responseObject);
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
                   
                    
                    NSLog(@"%@",url);
                    
                    
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
                    
                    
                    NSLog(@"%@",sendReq);
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                    
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
            
            
                    }
        if (buttonIndex==1) {
            
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
                    
                    //                    NSLog(@"%@",urlMessage);
                    
                    urlMessage.title = dic[@"title"];//分享标题
                    urlMessage.description = dic[@"summary"];//分享描述
                    //
                    NSURL *url = [NSURL URLWithString:dic[@"iconUrl"]];
                    
                    
                    NSLog(@"%@",url);
                    
                    
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
                    
                    
                    NSLog(@"%@",sendReq);
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                    
                    
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
            
            
        } if (buttonIndex==2) {
            TencentOAuth *auth = [[TencentOAuth alloc] initWithAppId:@"1102107765" andDelegate:self];
            NSLog(@"%@",auth);
             NSDictionary * dic=[user objectForKey:@"KPDATA"];
            NSString *utf8String = @"";
            NSString *title = dic[@"title"];
            NSString *description = dic[@"summary"];
            NSString *previewImageUrl = dic[@"iconUrl"];
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:title
                                        description:description
                                        previewImageURL:[NSURL URLWithString:previewImageUrl]];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            //将内容分享到qq
            //QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            //将内容分享到qzone
            QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
            NSLog(@"%d",sent);
            
        }if (buttonIndex==3) {
            
            
            
            
            
            
            
            
            
            
            TencentOAuth *auth = [[TencentOAuth alloc] initWithAppId:@"1102107765"
                                                         andDelegate:self];
            NSLog(@"%@",auth);
            NSDictionary * dic=[user objectForKey:@"KPDATA"];
            NSString *utf8String = @"http://www.163.com";
            NSString *title = dic[@"title"];
            NSString *description = dic[@"summary"];
            NSString *previewImageUrl =dic[@"iconUrl"];
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:title
                                        description:description
                                        previewImageURL:[NSURL URLWithString:previewImageUrl]];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            //将内容分享到qq
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];

            NSLog(@"%d",sent);
            
        }


        
        
    }
    if (actionSheet.tag==120) {
        
        
        if (buttonIndex==0) {
            NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.style.fontSize='18px';"]);
        } if (buttonIndex==1) {
            NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.style.fontSize='16px';"]);
        } if (buttonIndex==2) {
            NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.style.fontSize='14px';"]);
        }
        

        
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
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
  
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];

    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/add_study_plan.mob",URLDOMAIN];
    
    
    NSLog(@"%@%@%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],[[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"],[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"],date);
    
    
    NSDictionary * dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"title":[[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"],@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"],@"planTime":date};
    
    
    
    
    
    
[manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
    NSString * str=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
    if ([str isEqualToString:@"1"]) {

        
        [MBProgressHUD showSuccess:@"添加成功"];
    }
    if ([str isEqualToString:@"-1"]) {
        
        [MBProgressHUD showError:@"添加失败"];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    
    
    
    
    
    
    self.videoSource=[NSMutableDictionary new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    if (token.length>5) {
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/kpDetail4New.mob",URLDOMAIN];
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    
      
    
    NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":self.kpId,@"adapterSize":_Width};
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * Dic=dic[@"kpData"];
       
     
        [userInfo setObject:Dic forKey:@"KPDATA"];
    
        NSString * isCollection=[NSString stringWithFormat:@"%@",Dic[@"isCollected"]];
        [userInfo setObject:isCollection forKey:@"isCollection"];
        
        if ([isCollection isEqualToString:@"0"]) {
            [_collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_outline_white_48dp_star"] forState:UIControlStateNormal];
    }else{
        [_collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_white_48dp_star"] forState:UIControlStateNormal];
        
}
        
        
        
        
       
        self.videoSource=Dic[@"videoSour"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
        
        
    }
    
    
    
    
//    self.tabBarController.tabBar.hidden=YES;
//    
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    image.hidden=YES;
    
     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    
    [self.webView reload];
 
    
    
}



-(void)collectionKnowledge:(UIBarButtonItem *)button{
    
    
    
   NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    
    
  
    NSString * token=[user objectForKey:@"token"];

    
    if (token.length>5) {
        
        
       
        NSString * isCollection=[user objectForKey:@"isCollection"];
    
        if ([isCollection isEqualToString:@"0"]) {
            
           
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/my_kp_favourite.mob?token=%@&kpID=%@",URLDOMAIN,[user objectForKey:@"token"],self.kpId];
         
            [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
               
                if ([responseObject[@"ret"]isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:@"收藏成功"];
                    [user setObject:@"1" forKey:@"isCollection"];
                    [_collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_white_48dp_star"] forState:UIControlStateNormal];
                }
                if ([responseObject[@"ret"]isEqualToString:@"-1"]) {
                   
                    [MBProgressHUD showSuccess:@"收藏失败"];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        }else{
            
            
            [_collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_outline_white_48dp_star"] forState:UIControlStateNormal];
            
            [MBProgressHUD showSuccess:@"取消收藏成功"];
            
            
            [user setObject:@"0" forKey:@"isCollection"];
            
            
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];

            NSString * url=[NSString stringWithFormat:@"%@/BagServer/deleteMyCollected.mob?token=%@&kpIDS=%@&flag=2",URLDOMAIN,[user objectForKey:@"token"],self.kpId];
            
   
            [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                if ([responseObject[@"ret"]isEqualToString:@"1"]) {
                    
                    

                    
                }
                if ([responseObject[@"ret"]isEqualToString:@"-1"]) {
                    
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            
        }
        
        
        
        
        
        
        
    }else{
    
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        av.tag=120;
        
        [av show];
    
    
    }
    
    
    
}
-(void)shareKnowledge:(UIBarButtonItem *)button{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>5) {
        
        UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"朋友圈",@"微信好友", nil];
        sheet.tag=1000;
        [sheet showInView:self.view];

    }else{
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        av.tag=120;
        
        [av show];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==120) {
        
        if (buttonIndex==1) {
            
            NewLoginViewController * new=[[NewLoginViewController alloc]init];
            
            
            [self.navigationController pushViewController:new animated:YES];
        }
        
        
    }
   


}
-(void)getKPInfo:(NSString *)kpShareInfo{

    NSLog(@"%@",kpShareInfo);

}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    [self.WKView removeFromSuperview];
    self.WKView=nil;
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    NSURL * url=[NSURL URLWithString:self.webUrl];
    
    
    
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];

    
    
    
    completionHandler();
    
    
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
  

}
-(void)webViewDidStartLoad:(UIWebView *)webView{

_hud = [WKProgressHUD showInView:self.view withText:@"页面加载中..." animated:YES];


}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_hud dismiss:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}
@end
