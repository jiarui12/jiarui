//
//  NewBagViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/21.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "NewLoginViewController.h"
#import "NewBagViewController.h"
#import "BagCollectionViewController.h"
#import "JRKnowLedgeTableViewController.h"
#import "SGScanningQRCodeVC.h"
#import <AVKit/AVKit.h>
#import "AFNetworking.h"
#import "newSearchViewController.h"
#import "PrefixHeader.pch"
#import "biaoganViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "messageNoticeViewController.h"
#import "MTA.h"
#import "JRDetailCategoryController.h"
#import "JRCategpryMuneController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewBagViewController ()
@property(nonatomic,strong)UIView * redView;
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)JRCategpryMuneController * muneController;
@property(nonatomic,strong)JRDetailCategoryController * detailController;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * controllerArr;

@property(nonatomic,strong)NSArray * vcArr;
@end
static NSString *CellID = @"ControllerCell";

@implementation NewBagViewController
{
UIImageView *navBarHairlineImageView;

}
-(void)receiveNotificiation:(NSNotification*)nofi{


//    [self configView];

    [self.muneController.view removeFromSuperview];
    
    [self.detailController.view removeFromSuperview];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor=[UIColor whiteColor];
    
    view.tag=12;
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, HEIGHT*78/568+64, WIDTH * 90/320, HEIGHT* 80/568)];
    
    
    imageView.image=[UIImage imageNamed:@"weidengluyemian"];
    
    
    [view addSubview:imageView];
    
    UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*175/568+64, WIDTH, 20)];
    
    label1.text=@"学习目前暂无分类哦~";
    label1.font=[UIFont systemFontOfSize:WIDTH*16/375];
    label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:label1];
    
    
    
    UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*205/568+64, WIDTH, 20)];
    
    label2.text=@"登录后将查看更多知识栏目";
    label2.font=[UIFont systemFontOfSize:WIDTH*16/375];
    label2.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:label2];
    
    
    
    
    
    
    UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
    chongxin1.frame=CGRectMake(WIDTH *100/320,HEIGHT* 240/568+64,WIDTH *120/320, HEIGHT*35/568);
    
    [chongxin1 setTitle:@"登录" forState:UIControlStateNormal];
    
    chongxin1.layer.cornerRadius=4.5;
    
    
    [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chongxin1 setBackgroundColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0]];
    
    [chongxin1 addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:chongxin1];
    
    [self.view addSubview:view];
    

    

}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(-WIDTH*7/375, 6, 20, 18);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_QRcode_defult@2x"] forState:UIControlStateNormal];
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20, 30)];
    //    view.backgroundColor=[UIColor redColor];
    [view addSubview:button1];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:view];
    [button1 addTarget:self action:@selector(Scan:) forControlEvents:UIControlEventTouchUpInside];
    [view addTarget:self action:@selector(Scan:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(WIDTH*7/375, 6, 19, 18);
    
    [button setBackgroundImage:[UIImage imageNamed:@"icon_message_defult@2x"] forState:UIControlStateNormal];
    UIButton * b=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 19, 30)];
    [b addSubview:button];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:b];
    
    
    
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH*570/750,32)];
    
    headView.backgroundColor=[UIColor colorWithRed:89/255.0 green:206/255.0 blue:255/255.0 alpha:1.0];
    headView.layer.cornerRadius=WIDTH *5/375;
    
    
   
    UIImageView * imageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*82/375, 0, 32,  32)];
    
    imageVIew.image=[UIImage imageNamed:@"icon_search_defult"];
    //    imageVIew.contentMode=UIViewContentModeScaleAspectFit;
    [imageVIew setContentMode:UIViewContentModeCenter];
    
    [headView addSubview:imageVIew];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*110/375, 0,WIDTH*200/375, 32)];
    label.text=@"搜索平台内容";
    label.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    label.font=[UIFont systemFontOfSize:WIDTH *14/375];
    
    [headView addSubview:label];
    UIButton * searchBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    searchBtn.backgroundColor=[UIColor clearColor];
    [searchBtn addTarget:self action:@selector(Search:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame=CGRectMake(0, 0, WIDTH*570/750, 32);
    [headView addSubview:searchBtn];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"ViewController" object:@"zhangsan"];

    
    
    [center addObserver:self selector:@selector(Shuaxinshuju) name:@"refreshshouye" object:nil];
    
    self.navigationItem.titleView=headView;
    
//    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 70);
//    
//    BagCollectionViewController *  bag1=[[BagCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
//    
//    [self addChildViewController:bag1];
//    
//    bag1.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
//    
//
//    bag1.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49-64);
//    UIView * backView=[[UIView alloc]initWithFrame:self.view.bounds];
//    backView.backgroundColor=[UIColor whiteColor];
//    [backView addSubview:bag1.view];
//    [self.view addSubview:backView];
    
//    [self addCategoryMenuView];
//    
//    [self addDetailCategoryView];
    
    [self configView];
    
    
    
}
-(void)Shuaxinshuju{

    [self configView];

}
-(void)configView{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>8) {
        
        
        
        
        if ([[user objectForKey:@"allNodeList"] count]>0) {
            
            
            
            [self addCategoryMenuView];
            
            [self addDetailCategoryView];
        }
        
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/getOTTMapNodesId.mob?token=%@",URLDOMAIN,[user objectForKey:@"token"]];
        
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            
            
            if ([responseObject count]>0) {
                
                [user setObject:responseObject forKey:@"allNodeList"];
                
                [self addCategoryMenuView];
                
                [self addDetailCategoryView];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
        
        
        
        
        
    }else{
        
        
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor whiteColor];
        
        view.tag=12;
        
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, HEIGHT*78/568+64, WIDTH * 90/320, HEIGHT* 80/568)];
        
        
        imageView.image=[UIImage imageNamed:@"weidengluyemian"];
        
        
        [view addSubview:imageView];
        
        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*175/568+64, WIDTH, 20)];
        
        label1.text=@"学习目前暂无分类哦~";
        label1.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label1.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label1];
        
        
        
        UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*205/568+64, WIDTH, 20)];
        
        label2.text=@"登录后将查看更多知识栏目";
        label2.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label2.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label2.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label2];
        
        
        
        
        
        
        UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
        chongxin1.frame=CGRectMake(WIDTH *100/320,HEIGHT* 240/568+64,WIDTH *120/320, HEIGHT*35/568);
        
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
-(void)viewWillAppear:(BOOL)animated
{
    

    
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    
}



-(void)addDetailCategoryView{
    
    
    [self.detailController.view removeFromSuperview];
    
    self.detailController.view = nil;
    
    
    CGFloat x = WIDTH*97/375;
    CGFloat y = 64;
    CGFloat width = WIDTH*278/375;
    CGFloat height = HEIGHT-64-49;
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 70);
    
    
    
    _detailController=[[JRDetailCategoryController alloc]initWithCollectionViewLayout:flowLayout];
    
    [self addChildViewController:_detailController];
    
    
    
    
    
    self.detailController.view.frame = CGRectMake(x, y, width, height);
    
    [self.view addSubview:_detailController.view];


}

- (void)addCategoryMenuView {
    
    [self.muneController.view removeFromSuperview];
    
    self.muneController.view=nil;
    
    
    
    // 计算分类主菜单视图尺寸
    CGFloat x = 0;
    CGFloat y = 64;//self.navigationController.navigationBar.frameHeight + SCStatusBarHeight;
    CGFloat width = WIDTH* 97/375;
    CGFloat height = HEIGHT-64-49;
    self.muneController=[[JRCategpryMuneController alloc]init];
    self.muneController.view.frame = CGRectMake(x, y, width, height);
    self.muneController.tableView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
    
    [self addChildViewController:self.muneController];
    [self.view addSubview:_muneController.view];
    
    
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
//            ScanningViewController * search=[[ScanningViewController alloc]init];
            
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
-(void)Back:(UIBarButtonItem *)button{

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>5) {
       
        
        
        
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
-(void)Search:(UIButton *)button{
    
    [MTA trackCustomEvent:@"search" args:[NSArray arrayWithObject:@"arg0"]];

    [MTA trackCustomEvent:@"search_bag" args:[NSArray arrayWithObject:@"arg0"]];

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


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
}
-(void)viewDidDisappear:(BOOL)animated{
self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
}




@end
