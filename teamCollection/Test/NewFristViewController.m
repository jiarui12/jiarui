//
//  NewFristViewController.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/26.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewFristViewController.h"
#import "SourceManager.h"
#import "ChatTool.h"
#import "biaoganViewController.h"
#import "PrefixHeader.pch"
#import "newSearchViewController.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD+HM.h"
#import "NewLoginViewController.h"
#import "ManagerViewController.h"
#import "PrefixHeader.pch"
#import "Reachability.h"
#import "AFNetworking.h"
#import "YLSlideView/YLSlideView.h"
#import "YLSlideConfig.h"
#import "YLSlideView/YLSlideCell.h"
#import "YGPCache.h"
#import "MJRefresh.h"
#import "OneImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TwoImageTableViewCell.h"
#import "ThreeImageTableViewCell.h"
#import "RightImageTableViewCell.h"
#import "LeftImageTableViewCell.h"
#import "refreshTableViewCell.h"
#import "JRKnowLedgeTableViewController.h"
#import "WKProgressHUD.h"
#import "HistoryLoginViewController.h"
#import "FMDB.h"
#import "MTA.h"
#import <AudioToolbox/AudioToolbox.h>
#import "messageNoticeViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewFristViewController ()<UIWebViewDelegate,UIAlertViewDelegate,YLSlideViewDelegate,UITableViewDelegate>
{
    
    YLSlideView * _slideView;
    NSMutableArray * _titleArr;
    NSArray *_testArray;
    
    YLSlideCell * _cell;
    
    FMDatabase * dataBase;
}

@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * Width;
@property(nonatomic,strong)NSMutableArray * subArr;
@property(nonatomic,strong)NSMutableArray * allData;
@property(nonatomic,strong)NSUserDefaults * user;

@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)UIImageView * dianImage;


@property(nonatomic,strong)WKProgressHUD * hud;

@property(nonatomic,strong)XMPPStream * stream;

@property (nonatomic, strong,readonly)XMPPvCardTempModule *vCard;//电子名片
@property (nonatomic, strong,readonly)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储
@property (nonatomic, strong,readonly)XMPPRoster *roster;//花名册模块
@property (nonatomic, strong,readonly)XMPPMessageArchivingCoreDataStorage *msgStorage;

@end

@implementation NewFristViewController
-(void)refreshClick{
    
    [self configerView];
    
}
-(void)dealloc{
    [_user removeObserver:self forKeyPath:@"token"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshClick) name:@"reloadView" object:nil];
    _allData=[NSMutableArray new];
    
    self.navigationItem.title=@"首页";
    
    
    _user=[NSUserDefaults standardUserDefaults];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(-WIDTH*7/375, 6, 20, 18);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_QRcode_defult@2x"] forState:UIControlStateNormal];
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20, 30)];
    [view addSubview:button1];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:view];
    [button1 addTarget:self action:@selector(Scan:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [view addTarget:self action:@selector(Scan:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    
    _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame=CGRectMake(WIDTH*7/375, 6, 19, 18);
    
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"icon_message_defult@2x"] forState:UIControlStateNormal];
    UIButton * b=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 19, 30)];
    [b addSubview:_rightButton];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:b];
    
  
    
    
    
    
    [_rightButton addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH*570/750,32)];
    
    headView.backgroundColor=[UIColor colorWithRed:89/255.0 green:206/255.0 blue:255/255.0 alpha:1.0];
    headView.layer.cornerRadius=WIDTH *5/375;
    
    
    UIImageView * imageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*82/375, 0, 32,  32)];
    
    imageVIew.image=[UIImage imageNamed:@"icon_search_defult"];
    [imageVIew setContentMode:UIViewContentModeCenter];
    [headView addSubview:imageVIew];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*110/375, 0,WIDTH*200/375,  32)];
    label.text=@"搜索平台内容";
    label.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    label.font=[UIFont systemFontOfSize:WIDTH*14/375];
    
    [headView addSubview:label];
    UIButton * searchBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    searchBtn.backgroundColor=[UIColor clearColor];
    [searchBtn addTarget:self action:@selector(Search:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame=CGRectMake(0, 0, WIDTH*570/750, 32);
    [headView addSubview:searchBtn];
    
    
    self.navigationItem.titleView=headView;
    
    
    _subArr=[NSMutableArray new];
    
    
    
    [_user addObserver:self forKeyPath:@"token" options:NSKeyValueObservingOptionNew context:nil];
    
   
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString * Url=[NSString stringWithFormat:@"%@/BagServer/phoneGetPolicy.mob?token=%@&bucketType=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"image"];
    
    [manager POST:Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([responseObject count]>0) {
            
            [user setObject:responseObject[@"ossPolicy"] forKey:@"aliyunOSS"];
            
        }else{
        
        
        
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
        
    }];

    
    [self configerView];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>5) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self connectToHost];
        });
        
    }
    
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    
    
    
    
}
-(void)Search:(UIButton *)button{
    
    [MTA trackCustomEvent:@"search" args:[NSArray arrayWithObject:@"arg0"]];
    [MTA trackCustomEvent:@"search_home" args:[NSArray arrayWithObject:@"arg0"]];

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>5) {
        newSearchViewController * search=[[newSearchViewController alloc]init];
        search.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:search animated:NO];
    }else{
        
        NewLoginViewController * his=[[NewLoginViewController alloc]init];
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
    }
    
}
-(void)Back:(UIBarButtonItem *)button{
    
     NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>5) {
        [_dianImage removeFromSuperview];
        _dianImage=nil;
        
        
        
        messageNoticeViewController * massage=[[messageNoticeViewController alloc]init];
        massage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:massage animated:YES];

    }else{
        
        NewLoginViewController * his=[[NewLoginViewController alloc]init];
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==140) {
        NewLoginViewController * his=[[NewLoginViewController alloc]init];
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
    }else{
        if (buttonIndex==1) {
        NSString * sql=@" select * from t_student ";
            FMResultSet *result=[dataBase executeQuery:sql];
            while(result.next){
                int ids=[result intForColumn:@"id"];
                NSString * name=[result stringForColumn:@"pushMsg"];
                
                
                
                NSString * title=[result stringForColumn:@"pushTitle"];
                //                int ids=[result intForColumnIndex:0];
                //                NSString * name=[result stringForColumnIndex:1];
                NSLog(@"%@,%d,%@",name,ids,title);
            }
            
            
            
        }
        
        
    }
    
}
-(void)backOld:(UIButton *)button{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    if (token.length>5) {
    }else{
        
        NewLoginViewController * login=[[NewLoginViewController alloc]init];
        
        [self.navigationController pushViewController:login animated:YES];
        
        
    }
    
    
    
}


-(void)Scan:(UIButton*)button{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>5) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if(authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相机\"中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
            
        }else{
            
            SGScanningQRCodeVC * search=[[SGScanningQRCodeVC alloc]init];
            
            search.hidesBottomBarWhenPushed=YES;
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
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.navBarBgAlpha=@"1.0";
    
    
    self.navigationController.navigationBarHidden=NO;
    
    
    
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    //    _user=[NSUserDefaults standardUserDefaults];
    //
    //    NSString * token=[_user objectForKey:@"token"];
    //    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    //    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //
    //    NSString * url=[NSString stringWithFormat:@"http://192.168.1.120:8080/ba/api/indexBack/getKnowledge.mob?node_id=-1&token=%@",token];
    //
    //    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"22222222%@",responseObject);
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        [self shuaxin:[UIButton buttonWithType:UIButtonTypeSystem]];
    //    }];
    

    
}
-(void)viewDidAppear:(BOOL)animated
{
    
//self.hidesBottomBarWhenPushed = YES;
    
}

-(void)move:(UIButton *)button{
    
    
    if (button.selected==NO) {
        button.selected=YES;
        [UIView animateWithDuration:0.25 animations:^{
            button.frame=CGRectMake(self.view.frame.size.width-25-75, 400, 25, 45);
            UIButton * but=[self.view viewWithTag:100];
            but.frame=CGRectMake(self.view.frame.size.width-75, 400, 75, 45);
            
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else {
        button.selected=NO;
        [UIView animateWithDuration:0.25 animations:^{
            button.frame=CGRectMake(self.view.frame.size.width-25, 400, 25, 45);
            UIButton * but=[self.view viewWithTag:100];
            but.frame=CGRectMake(self.view.frame.size.width, 400, 75, 45);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
}












#pragma mark UITableViewDataSource




-(void)addNodeId:(UIButton *)button{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
 
        biaoganViewController * manager=[[biaoganViewController alloc]init];
//        ManagerViewController * manager=[[ManagerViewController alloc]init];
        manager.webUrl=[NSString stringWithFormat:@"%@/ba/mp/main/select_node?token=%@",URLDOMAIN,token];
        
        [self.navigationController pushViewController:manager animated:YES];
    
    
    
}






-(void)configerView{
    
    
    
    
    JRKnowLedgeTableViewController * jr=[[JRKnowLedgeTableViewController alloc]init];
    
    jr.node_id=@"-1";
    jr.view.frame=CGRectMake(0, 64, WIDTH, HEIGHT-49-64);
    [self addChildViewController:jr];
    [self.view addSubview:jr.view];
    
    
    
    
    
//    _user=[NSUserDefaults standardUserDefaults];
//    
//    
//    
//    
//    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//    filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"shouye"];
//    
//    
//    NSArray *Arr = [NSArray arrayWithContentsOfFile:filePath];
//    
//    
//    
//    
//    
//    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
//    Reachability *conn=[Reachability reachabilityForInternetConnection];
//    if ([wifi currentReachabilityStatus]==NotReachable&&[conn currentReachabilityStatus]==NotReachable) {
//        
//        if (Arr.count>0) {
//            
//           
//            
//            
//        }else{
//            
//            
//            UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
//            view.backgroundColor=[UIColor whiteColor];
//            
//            view.tag=1201;
//            
//            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
//            
//            
//            imageView.image=[UIImage imageNamed:@"image_server"];
//            
//            
//            [view addSubview:imageView];
//            
//            UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
//            
//            label1.text=@"服务器开小差了~工程师正在召唤它...";
//            label1.font=[UIFont systemFontOfSize:18];
//            label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//            
//            label1.textAlignment=NSTextAlignmentCenter;
//            
//            [view addSubview:label1];
//            
//            UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
//            
//            second1.text=@"意见";
//            
//            second1.textAlignment=NSTextAlignmentLeft;
//            
//            second1.font=[UIFont systemFontOfSize:14];
//            
//            second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
//            
//            [view addSubview:second1];
//            
//            UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
//            
//            fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
//            [fankui setTitle:@"反馈" forState:UIControlStateNormal];
//            fankui.titleLabel.font=[UIFont systemFontOfSize:14];
//            [view addSubview:fankui];
//            
//            UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
//            
//            xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
//            
//            [view addSubview:xiahua];
//            
//            
//            UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
//            chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
//            
//            [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
//            
//            chongxin1.layer.cornerRadius=4.5;
//            
//            
//            [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            
//            [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
//            
//            [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [view addSubview:chongxin1];
//            
//            [self.view addSubview:view];
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//    }else{
//        if (Arr.count>0) {
//            
//            JRKnowLedgeTableViewController * jr=[[JRKnowLedgeTableViewController alloc]init];
//            
//            jr.node_id=@"-1";
// jr.view.frame=CGRectMake(0, 64, WIDTH, HEIGHT-49-64);
//            [self addChildViewController:jr];
//            [self.view addSubview:jr.view];
//            
//            
//            
//            
//            
//            
//            
//            
//            
//            
//        }else{
//            _hud = [WKProgressHUD showInView:self.view withText:@"" animated:YES];
//            
//        }
//        
//        
//        
//        
//        
//        NSString * token=[_user objectForKey:@"token"];
//        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
//        
//        if (token.length>5) {
//            NSString * url=[NSString stringWithFormat:@"%@/ba/api/index/get_nodes_info?token=%@",URLDOMAIN,token];
//            
//            [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//                
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSDictionary * Dic=(NSDictionary*)responseObject;
//                
//                NSString * ret=Dic[@"ret"];
//                
//                if ([ret isEqualToString:@"success"]) {
//                    
//                    JRKnowLedgeTableViewController * jr=[[JRKnowLedgeTableViewController alloc]init];
//                    
//                    jr.node_id=@"-1";
//                   jr.view.frame=CGRectMake(0, 64, WIDTH, HEIGHT-49-64);
//                    [self addChildViewController:jr];
//                    [self.view addSubview:jr.view];
//                    
//                }
//                
//                
//                [_hud dismiss:YES];
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//                [_hud dismiss:YES];
//                
//                if (Arr.count>0) {
//              
//                        
//                        JRKnowLedgeTableViewController * jr=[[JRKnowLedgeTableViewController alloc]init];
//                        
//                        jr.node_id=@"-1";
//                  jr.view.frame=CGRectMake(0, 64, WIDTH, HEIGHT-49-64);
//                    [self addChildViewController:jr];
//                        [self.view addSubview:jr.view];
//                
//                        
//                    
//                    
//                }else{
//                    UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
//                    view.backgroundColor=[UIColor whiteColor];
//                    
//                    view.tag=1201;
//                    
//                    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
//                    
//                    
//                    imageView.image=[UIImage imageNamed:@"image_server"];
//                    
//                    
//                    [view addSubview:imageView];
//                    
//                    UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
//                    
//                    label1.text=@"服务器开小差了~工程师正在召唤它...";
//                    label1.font=[UIFont systemFontOfSize:18];
//                    label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//                    
//                    label1.textAlignment=NSTextAlignmentCenter;
//                    
//                    [view addSubview:label1];
//                    
//                    UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
//                    
//                    second1.text=@"意见";
//                    
//                    second1.textAlignment=NSTextAlignmentLeft;
//                    
//                    second1.font=[UIFont systemFontOfSize:14];
//                    
//                    second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
//                    
//                    [view addSubview:second1];
//                    
//                    UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
//                    
//                    fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
//                    [fankui setTitle:@"反馈" forState:UIControlStateNormal];
//                    fankui.titleLabel.font=[UIFont systemFontOfSize:14];
//                    [view addSubview:fankui];
//                    
//                    UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
//                    
//                    xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
//                    
//                    [view addSubview:xiahua];
//                    
//                    
//                    UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
//                    chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
//                    
//                    [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
//                    
//                    chongxin1.layer.cornerRadius=4.5;
//                    
//                    
//                    [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                    
//                    [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
//                    
//                    [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
//                    
//                    [view addSubview:chongxin1];
//                    
//                    [self.view addSubview:view];
//                }
//                
//                
//                
//                
//                
//            }];
//        }
//        
//    }
//    
    
}

-(NSUserDefaults*)user{
    if (!_user) {
        _user=[NSUserDefaults standardUserDefaults];
    }
    return _user;
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
-(BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkConnectionFlags)connectionFlags{
    
    // NSLog(@"开始尝试自动连接:%u", connectionFlags);
    
    return YES;
    
}

/*开始连接到服务器*/
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
    NSLog(@"=====%@========%@",jidString,[NSString stringWithFormat:@"%@",[user objectForKey:@"openfireIP"] ]);
    
    
    
    _stream.enableBackgroundingOnSocket=YES;
    [_stream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    
    
    NSError * err=nil;
    
    if (![_stream connectWithTimeout:XMPPStreamTimeoutNone error:&err]) {
        NSLog(@"%@",err);
    }
}

/*连接成功*/
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    
    [self sendPwdToHost];
    
    
}
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"与主机断开连接%@",error);
    
    
//    [self connectToHost];
    
    //
    //    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号已在另一台设备登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //
    //    av.tag=140;
    //    [av show];
    
}

/*发送密码授权*/
-(void)sendPwdToHost{
    
    NSError * err=nil;
    [_stream authenticateWithPassword:@"bagserver" error:&err];
    if (err) {
        NSLog(@"%@",err);
    }
    
}
/*授权成功*/
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    
    
    [self sendOnlineToHost];
    
}
/*发送在线消息*/
-(void)sendOnlineToHost{
    
    NSLog(@"发送在线消息");
    XMPPPresence * presentce=[XMPPPresence presence];
    NSLog(@"%@",presentce);
    
    [_stream sendElement:presentce];
    
    SourceManager * manager=[SourceManager defaultManager];
    manager.msgStorage=_msgStorage;
    [ChatTool sharedChatTool].msgStorage=_msgStorage;
    
    
    
    //    person.avatar = self.avatarView.image;
    //    person.name = self.nameField.text;
    //    person.age = [self.ageField.text integerValue];
    //    [NSKeyedArchiver archiveRootObject:person toFile:file];
    
    
    
    [ChatTool sharedChatTool].xmppStream=_stream;
}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"授权失败%@",error);
}

/*收到消息做成本地通知*/
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    
    
    
    NSLog(@"消息内容：%@",message.body);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
    if (!_dianImage) {
        _dianImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, -2, 7, 7)];
        _dianImage.image=[UIImage imageNamed:@"home_nav_message_remind@2x"];
        [_rightButton addSubview:_dianImage];
    }
   
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
     NSString *insertSql=[NSString stringWithFormat:@"insert into chat_%@(categoryId, categoryTitle , commentLevel , commentUserIcon  , commentUserName  , companyName , operationId , pushMessageContent , pushMessageDetailUrl , pushMessageTitle  , pushTime  , subTypeId  , subTypeTitle , target  , targetType ,isRead ,isDisplay) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
    
    if ([message.type isEqualToString:@"chat"]) {
        if ([message.body length]>0) {
            
     

            
      }
    }else{
        
        
        
        NSString * str=[NSString stringWithFormat:@"%@",message.body];
        
        NSData *JSONData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
   
        
        
        
       
        
        
        
        if (dic.count>0) {
            
            [dataBase executeUpdate:insertSql,dic[@"categoryId"],dic[@"categoryTitle"],dic[@"commentLevel"],dic[@"commentUserIcon"],dic[@"commentUserName"],dic[@"companyName"],dic[@"operationId"],dic[@"pushMessageContent"],dic[@"pushMessageDetailUrl"],dic[@"pushMessageTitle"],dic[@"pushTime"],dic[@"subTypeId"],dic[@"subTypeTitle"],dic[@"target"],dic[@"targetType"],@"0",@"0"];

//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
//            NSString *dateString = [dateFormatter stringFromDate:currentDate];
//            NSLog(@"%@",dateString);
            
            NSString *updateSql = [NSString stringWithFormat:@"update chat_%@ set isDisplay = '%@'  WHERE operationId='%@'",[user objectForKey:@"userID"],@"0",dic[@"operationId"]];
            [dataBase executeUpdate:updateSql];
        
        }
        
        
        
        
        UILocalNotification * localNoti=[[UILocalNotification alloc]init];
        if(dic){
            localNoti.alertBody=dic[@"pushMsg"];
        }else{
            localNoti.alertBody=message.body;
        }
        
        
        
        localNoti.fireDate=[NSDate date];
        
        localNoti.soundName=@"default";
        
        
        
        localNoti.userInfo=dic;
        [UIApplication sharedApplication].applicationIconBadgeNumber=[UIApplication sharedApplication].applicationIconBadgeNumber+1;
        
        [[UIApplication sharedApplication]scheduleLocalNotification:localNoti];
        
        
        
    }
    
    
    
}


-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"%@",presence.fromStr);
}
-(void)shuaxin:(UIButton *)button{
    //     WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"" animated:YES];
    UIView * view=[self.view viewWithTag:1200];
    
    [view removeFromSuperview];
    
    view=nil;
    
    
    UIView * view1=[self.view viewWithTag:1201];
    
    
    [view1 removeFromSuperview];
    
    
    view1=nil;

    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
    NSString * name=[UserInfo  objectForKey:@"nameStr"];
    NSString * pass = [UserInfo objectForKey:@"passStr"];
    NSString * imie =[UserInfo objectForKey:@"imie"];
    
    
    
    NSDictionary * parameter=@{@"phone":name,@"passwd":pass,@"imei":imie,@"platform":@"ios"};
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic.count>0) {
            if ([dic[@"ret"] isEqualToString:@"passwd_not_match"]) {
                
            }else{
                
                
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
                }
            }
            
        }
        [self configerView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
   
    }];
    
    
    
    
    
    
}

@end

