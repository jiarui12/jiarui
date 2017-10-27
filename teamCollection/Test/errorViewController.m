//
//  errorViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/26.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "errorViewController.h"
#import "HuiCollectionViewCell.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "PrefixHeader.pch"
#import "NewLoginViewController.h"
#import "newCompanyTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WKProgressHUD.h"
#import "Reachability.h"
#import "biaoganViewController.h"
#import "nonetConViewController.h"
#import "ULBCollectionViewFlowLayout.h"
#import "messageNoticeViewController.h"
#import "UINavigationController+WXSTransition.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface errorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,ULBCollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray * nameArr;
@property(nonatomic,strong)NSMutableArray * imageArr;
@property(nonatomic,strong)UIImageView * jiantou;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)NSMutableArray * compoUrl;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)WKProgressHUD * hud;

@property(nonatomic,strong)UIImageView * titleImageView;

@end
static NSString * const reuseIdentifier=@"HuiCell";
@implementation errorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView * a=[[UIView alloc]initWithFrame:self.view.bounds];
    a.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:a];
    
    
    _titleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 175)];
    
    _titleImageView.image=[UIImage imageNamed:@"image_background-@2x"];
    
    [self.view addSubview:_titleImageView];
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    ULBCollectionViewFlowLayout * la=[[ULBCollectionViewFlowLayout alloc]init];
    
    self.collectionView.collectionViewLayout=la;
    
    
    
    la.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 175);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)collectionViewLayout:la];
    self.collectionView.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
    [_collectionView registerClass:[HuiCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    _collectionView.backgroundColor=[UIColor clearColor];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    [self.view addSubview:_topView];
    
    
    UIButton * rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(WIDTH*7/375, 6, 19, 18);
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_message_defult"] forState:UIControlStateNormal];
    UIButton * b=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 19, 30)];
    [b addSubview:rightButton];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:b];
    
    
    
    
    
    
    [rightButton addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];

    
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH* 10/375, WIDTH, 64)];
    
    _label.textColor=[UIColor whiteColor];
    
   
    [_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH *18/375]];
    _label.textAlignment=NSTextAlignmentCenter;
    [_topView addSubview:_label];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
            NSString * Url=[NSString stringWithFormat:@"%@/BagServer/personalInfo.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager POST:Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
     _label.text=responseObject[@"companyName"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                
    }];
    
    self.view.backgroundColor=[UIColor whiteColor];
    

    _compoUrl=[NSMutableArray new];
    _nameArr=[NSMutableArray new];
    _imageArr=[NSMutableArray new];
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    image.image=[UIImage imageNamed:@"jiade"];
    
    [self.topView addSubview:image];
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    
//    NSString * token=[user objectForKey:@"token"];
    
    
//    if (token.length>5) {
//       [self configView];
//    }
//    
    
    
   
    _collectionView.alwaysBounceVertical=YES;
    
 
    
}
-(void)configView{
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"huiyemian"];
    
    
    NSArray *Arr = [NSArray arrayWithContentsOfFile:filePath];
    
    if (Arr.count>0) {
        
//        [_collectionView removeFromSuperview];
//        [_topView removeFromSuperview];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        
//        
//        _compoUrl=[NSMutableArray new];
//        
//        _nameArr=[NSMutableArray new];
//        _imageArr=[NSMutableArray new];
//        for (NSDictionary * subdic in Arr) {
//                [_compoUrl addObject:subdic[@"compoUrl"]];
//                [_nameArr addObject:subdic[@"compoName"]];
//                [_imageArr addObject:subdic[@"icon"]];
//                
//                
//                
//                
//                
//            }
//            [self.view addSubview:_collectionView];
//            [self.view addSubview:  _topView];
//            [_hud dismiss:YES];
//            [_collectionView reloadData];

        [_hud dismiss:YES];
        
    }else{
     
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _hud = [WKProgressHUD showInView:self.view withText:@"加载中.." animated:YES];
        });
        

    
    }
   
    [manager POST:[NSString stringWithFormat:@"%@/BagServer/getAuthAppComponent.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [_hud dismiss:YES];
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        
        if ([responseObject[@"data"] count]>0) {
            
            [_collectionView removeFromSuperview];
            [_topView removeFromSuperview];
            
            _compoUrl=[NSMutableArray new];
            
            _nameArr=[NSMutableArray new];
            _imageArr=[NSMutableArray new];
            for (NSDictionary * subdic in responseObject[@"data"]) {
                [_compoUrl addObject:subdic[@"compoUrl"]];
                [_nameArr addObject:subdic[@"compoName"]];
                [_imageArr addObject:subdic[@"icon"]];
                
            }
            
            
            
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"huiyemian"];
            
            [responseObject[@"data"] writeToFile:filePath atomically:NO];
            //            NSArray *Arr = [NSArray arrayWithContentsOfFile:filePath];
            
            
            
            [self.view addSubview:_collectionView];
            [self.view addSubview:_topView];
            
            
            [_collectionView reloadData];
            
            int a=ceil((float)_compoUrl.count/3);
            
            UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/3, 175, 1,WIDTH/3*a)];
            //            view1.backgroundColor=[UIColor colorWithRed:216/255.0 green:226/255.0 blue:234/255.0 alpha:1.0];
            view1.backgroundColor=[UIColor colorWithRed:233/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
            [_collectionView addSubview:view1];
            UIView * view2=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/3*2, 175, 1,WIDTH/3*a)];
            //            view2.backgroundColor=[UIColor colorWithRed:216/255.0 green:226/255.0 blue:234/255.0 alpha:1.0];
            view2.backgroundColor=[UIColor colorWithRed:233/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
            [_collectionView addSubview:view2];
            
            for (int i=1; i<=a; i++) {
                UIView * xian=[[UIView alloc]initWithFrame:CGRectMake(0,175+WIDTH/3*i , WIDTH, 1)];
                
                //                xian.backgroundColor=[UIColor colorWithRed:216/255.0 green:226/255.0 blue:234/255.0 alpha:1.0];
                xian.backgroundColor=[UIColor colorWithRed:233/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
                [_collectionView addSubview:xian];
            }
            
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [_hud dismiss:YES];
        
        
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        [_backView removeFromSuperview];
        
        _backView=nil;
        Reachability * wifi=[Reachability reachabilityForLocalWiFi];
        Reachability *conn=[Reachability reachabilityForInternetConnection];
        if ([wifi currentReachabilityStatus]==NotReachable&&[conn currentReachabilityStatus]==NotReachable) {
            _backView=[[UIView alloc]initWithFrame:self.view.bounds];
            
            _backView.backgroundColor=[UIColor whiteColor];
            
            
            if (Arr.count>0) {
                
                [_collectionView removeFromSuperview];
                [_topView removeFromSuperview];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                
                
                _compoUrl=[NSMutableArray new];
                
                _nameArr=[NSMutableArray new];
                _imageArr=[NSMutableArray new];
                for (NSDictionary * subdic in Arr) {
                    [_compoUrl addObject:subdic[@"compoUrl"]];
                    [_nameArr addObject:subdic[@"compoName"]];
                    [_imageArr addObject:subdic[@"icon"]];
                    
                    
                    
                    
                    
                }
                [self.view addSubview:_collectionView];
                [self.view addSubview:  _topView];
                [_hud dismiss:YES];
                [_collectionView reloadData];
                
            }else{
                
                
                UIImageView * wifiImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*8.5/320, HEIGHT*8/568,WIDTH* 15/320, WIDTH* 15/320)];
                wifiImage.image=[UIImage imageNamed:@"icon_wifi_defult_2x"];
                
                
                
                
                [_hud dismiss:YES];
                
                
                UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, HEIGHT*35/568)];
                
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
                
                
            }
            
            
            
        }else{
            
            [_hud dismiss:YES];
            
            
            
            if (Arr.count>0) {
                
                [_collectionView removeFromSuperview];
                [_topView removeFromSuperview];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                
                
                _compoUrl=[NSMutableArray new];
                
                _nameArr=[NSMutableArray new];
                _imageArr=[NSMutableArray new];
                for (NSDictionary * subdic in Arr) {
                    [_compoUrl addObject:subdic[@"compoUrl"]];
                    [_nameArr addObject:subdic[@"compoName"]];
                    [_imageArr addObject:subdic[@"icon"]];
                    
                    
                    
                    
                    
                }
                [self.view addSubview:_collectionView];
                [self.view addSubview:  _topView];
                [_hud dismiss:YES];
                [_collectionView reloadData];
                
            }else{
                
                
                
                
                [_hud dismiss:YES];
                
                
                
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
    }];


    
}
-(void)nonetCon:(UIButton *)button{
    nonetConViewController * con=[[nonetConViewController alloc]init];
    [self.navigationController pushViewController:con animated:YES];
    
    
 
}
-(void)shuaxin:(UIButton *)button{
    [_backView removeFromSuperview];
    _backView=nil;
    UIView * view=[self.view viewWithTag:1200];
    [view removeFromSuperview];
    view=nil;
    
    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
    NSString * name=[UserInfo  objectForKey:@"nameStr"];
    NSString * pass = [UserInfo objectForKey:@"passStr"];
    NSString * imie =[UserInfo objectForKey:@"imie"];
    NSString * token=[UserInfo objectForKey:@"token"];
    if (token.length>5) {
        
    
    
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
        [self configView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        
        
        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor whiteColor];
        
        view.tag=12;
        
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
        
        
        
        
    }];
    

    }
   
}
-(void)message:(UIButton*)button{

    messageNoticeViewController * massage=[[messageNoticeViewController alloc]init];
    
    [self.navigationController pushViewController:massage animated:YES];
    
    
  

    

  
}
-(void)xuanzhuan:(UIButton * )button{
  
    

    if (button.selected==NO) {
        button.selected=YES;
        UIImageView * xiaojian=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-4,52, 20, 8)];
        xiaojian.image=[UIImage imageNamed:@"xiaojian"];
        xiaojian.tag=120;
        [self.view addSubview:xiaojian];
        
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(67.5, 60, 240, 85)style:UITableViewStylePlain];
        _tableView.layer.cornerRadius=10;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=NO;
        _tableView.separatorColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:231/255.0 alpha:1.0];
        [self.view addSubview:_tableView];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGAffineTransform transform= CGAffineTransformMakeRotation(180*M_PI/180);
            
            _jiantou.transform = transform;
            
            
        } completion:^(BOOL finished) {
            
           
          
        }];
        
    }else{
        button.selected=NO;
        [_tableView removeFromSuperview];
        _tableView=nil;
        UIImageView * image=[self.view viewWithTag:120];
        
        image.hidden=YES;
        
        [image removeFromSuperview];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            CGAffineTransform transform= CGAffineTransformMakeRotation(0*M_PI/180);
            
            _jiantou.transform = transform;
            
        } completion:^(BOOL finished) {
           
        }];
    }


}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{


    return _nameArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HuiCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.iconImage.image=[UIImage imageNamed:_imageArr[indexPath.item]];
    
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:_imageArr[indexPath.item]]];
    
    cell.nameLabel.text=_nameArr[indexPath.item];
    
    return cell;

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
 return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.width/3);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newCompanyTableViewCell *cell = (newCompanyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *msg = cell.nameLabel.text;
    _label.text=msg;
    [self.tableView removeFromSuperview];
    UIButton * Btn=[self.view viewWithTag:1000];
    Btn.selected=NO;
    UIImageView * image=[self.view viewWithTag:120];
    
    image.hidden=YES;
    [image removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform transform= CGAffineTransformMakeRotation(0*M_PI/180);
        
        _jiantou.transform = transform;
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 2;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    newCompanyTableViewCell * cell=[newCompanyTableViewCell cellWithTableView:tableView];
    
    
    if (indexPath.row==0) {
        cell.nameLabel.text=@"八九点管理咨询有限公司";
        cell.nameLabel.textColor=[UIColor colorWithRed:44/255.0 green:140/255.0 blue:251/255.0 alpha:1.0];
        cell.headImage.image=[UIImage imageNamed:@"nightnine@2x"];
    }else{
        cell.nameLabel.text=@"中国石油化工集团公司";
        cell.nameLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        cell.headImage.image=[UIImage imageNamed:@"shihua@2x"];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:headerView.bounds];
    
    image.backgroundColor=[UIColor clearColor];
    [headerView addSubview:image];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, self.view.frame.size.width, 20)];
    
    label.textColor=[UIColor whiteColor];
    
    [headerView addSubview:label];
    
    return headerView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    if (_backView) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    NSString * token=[user objectForKey:@"token"];
    
    
    if (token.length>5) {
        
        
        [self configView];
        
        
        
        self.navBarBgAlpha=@"0.0";
    }else{
         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

        self.navBarBgAlpha=@"1.0";
        self.navigationItem.title=@"汇";
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor whiteColor];
        
        view.tag=12;
        
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
        
        imageView.image=[UIImage imageNamed:@"weidengluyemian"];
        
        
        [view addSubview:imageView];
        
        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*175/568, WIDTH, 20)];
        
        label1.text=@"汇目前空空如也哦~";
        label1.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label1.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label1];
        
        
        
        UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*205/568, WIDTH, 20)];
        
        label2.text=@"登录后将查看更多轻应用";
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
-(void)viewDidAppear:(BOOL)animated{

  


}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    biaoganViewController * all=[[biaoganViewController alloc]init];

    
    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
    if ([_nameArr[indexPath.item] isEqualToString:@"测评"]) {
        all.webUrl=[NSString stringWithFormat:@"%@/WeChat/getEvaluationList.wc?tpPsType=1&state=%@S%@Sbag_a&token=%@",URLDOMAIN,[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"token"]];
        
        all.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:all animated:YES];
        
        
//            [self.navigationController wxs_pushViewController:all makeTransition:^(WXSTransitionProperty *transition) {
//            transition.backGestureType = WXSGestureTypePanRight;
//            transition.animationType =49;
//        }];
    }else if ([_nameArr[indexPath.item] isEqualToString:@"调研"]) {
           all.webUrl=[NSString stringWithFormat:@"%@/WeChat/getEvaluationList.wc?tpPsType=2&state=%@S%@Sbag_a&token=%@",URLDOMAIN,[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"token"]];
        all.hidesBottomBarWhenPushed=YES;
       [self.navigationController pushViewController:all animated:YES];
        
        
  }else{
  
      biaoganViewController * biaogan=[[biaoganViewController alloc]init];
      
      
      
      
      NSString * url=_compoUrl[indexPath.item];
      
      if ([url containsString:@"?"]) {
          
          biaogan.webUrl=[NSString stringWithFormat:@"%@&token=%@&platform=ios&userID=%@&companyID=%@",_compoUrl[indexPath.item],[UserDefaults objectForKey:@"token"],[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"]];
      }else{
          biaogan.webUrl=[NSString stringWithFormat:@"%@?token=%@&platform=ios&userID=%@&companyID=%@",_compoUrl[indexPath.item],[UserDefaults objectForKey:@"token"],[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"]];
          
      }
      
      
       all.webUrl=[NSString stringWithFormat:@"%@?token=%@&platform=ios&userID=%@&companyID=%@",_compoUrl[indexPath.item],[UserDefaults objectForKey:@"token"],[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"]];
      
      all.hidesBottomBarWhenPushed=YES;
      biaogan.hidesBottomBarWhenPushed=YES;
      [self.navigationController pushViewController:biaogan animated:YES];

  }
}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
     if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0, 0, 0)];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIButton * button=[self.view viewWithTag:1000];
    
    button.selected=NO;
    
    UIImageView * image=[self.view viewWithTag:120];
    
    image.hidden=YES;
    
    [image removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform transform= CGAffineTransformMakeRotation(0*M_PI/180);
        
        _jiantou.transform = transform;
        
    } completion:^(BOOL finished) {
        
    
    }];

    [self.tableView removeFromSuperview];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
    CGFloat  offy=scrollView.contentOffset.y;
    CGFloat  alpha=offy/64.00;
    
  
    
//    if (offy>0) {
//       _topView.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:alpha];
//        
//        CGRect rect = _titleImageView.frame;
//        rect.size.height = 175;
//        rect.size.width = WIDTH ;
//        rect.origin.x = 0;
//        rect.origin.y = -offy;
//        _titleImageView.frame = rect;
//        
//    }else if(offy<0){
//        
//        CGRect rect = _titleImageView.frame;
//        rect.size.height = 175-offy;
//        rect.size.width = WIDTH* ((175-offy)/(175));
//        rect.origin.x =  -(rect.size.width-WIDTH)/2;
//        rect.origin.y = 0;
//        _titleImageView.frame = rect;
//    }

    _topView.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:alpha];
    
    CGRect rect = _titleImageView.frame;
    rect.size.height = 175;
    rect.size.width = WIDTH ;
    rect.origin.x = 0;
    rect.origin.y = -offy;
    _titleImageView.frame = rect;
    
}
-(UIColor*)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{

    return [UIColor whiteColor];
}
@end
