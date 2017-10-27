//
//  JRKnowLedgeTableViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/12.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "smallSampleViewController.h"
#import "JRKnowLedgeTableViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "OneImageTableViewCell.h"
#import "TwoImageTableViewCell.h"
#import "ThreeImageTableViewCell.h"
#import "LeftImageTableViewCell.h"
#import "RightImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "refreshTableViewCell.h"
#import "BrowserViewController.h"
#import "WKProgressHUD.h"
#import "biaoganViewController.h"
#import "SDCycleScrollView.h"
#import "DynamicViewController.h"
#import "MBProgressHUD+HM.h"
#import "MainDetailViewController.h"
#import "NewLoginViewController.h"
#import "MTA.h"
#import "AboutKnowledgeTableViewController.h"
#import "JRStudyScreenViewController.h"
#import "JRSegmentViewController.h"
#import "NewCommentListTableViewController.h"
#import "introduceKnowledgeViewController.h"
#import "TheVideoClassViewController.h"
#import "xiangqingyeViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface JRKnowLedgeTableViewController ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray * subArr;
@property(nonatomic,strong)UIView * bakView;
@property(nonatomic,strong)NSUserDefaults * user;
@property(nonatomic,strong)UIImageView * button;
@property(nonatomic,strong)UIView * bacView;
@property(nonatomic,strong)NSMutableArray * imageArr;
@property(nonatomic,strong)NSMutableArray * titleArr;
@property(nonatomic,strong)NSMutableArray * kpidArr;
@property(nonatomic,strong)NSString * resURL;
@property(nonatomic,strong)NSString * nodeString;
@property(nonatomic,strong)UIView * headerView;
@property(nonatomic,strong)NSString * token;
@property(nonatomic,strong)NSMutableArray * countArr;
@property(nonatomic,strong)NSMutableArray * allData;


@end

@implementation JRKnowLedgeTableViewController

{

    NSString * _Url;

    SDCycleScrollView * _cycleScrollView2;

}



/**
 通知中心方法，隐藏headerView

 @param no 通知传值的对象
 */
-(void)receiveNotificiation:(NSNotification *)no {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
//        [self.tableView.mj_header beginRefreshing];
        
        
         [self loadNewData1];
        
        
    });
   
    
    
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)Shuaxinshuju{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
//        [self.tableView.mj_header beginRefreshing];
        
        
                 [self loadNewData1];
        
        
    });
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token = [user objectForKey:@"token"];
    
    _kpidArr=[NSMutableArray new];
    _imageArr=[NSMutableArray new];
    _titleArr=[NSMutableArray new];
    _subArr=[NSMutableArray new];
    
    _countArr=[NSMutableArray new];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"ViewController" object:@"zhangsan"];
    
    [center addObserver:self selector:@selector(Shuaxinshuju) name:@"refreshshouye" object:nil];
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"xinshouye"];
    
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
   
    self.tableView.sectionFooterHeight=0;
    self.tableView.sectionHeaderHeight=20;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self setRefreshView];
    [self setHeaderView];
    [self loadNewData1];
    
    
    if (arr.count>0) {
        
        [_subArr addObjectsFromArray:arr];
        [self.tableView reloadData];
    }
    
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 42/375)];
    view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    UIView * xian=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    
    xian.backgroundColor=[UIColor colorWithRed:232/255.0 green:238/255.0 blue:242/255.0 alpha:1.0];
    [view addSubview:xian];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, WIDTH*42/375)];
    
    background.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    
    [view addSubview:background];
    
   

    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*23/375, 0,200, WIDTH*42/375)];
    
    label.text=_subArr[section][@"title"];
    label.font=[UIFont systemFontOfSize:WIDTH *17/375];
    
    [view addSubview:label];
    if (_subArr[section][@"tag"]&&![_subArr[section][@"tag"]isEqualToString:@"Hobby"]) {
        UILabel * moreLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0, WIDTH-WIDTH*23/375, WIDTH*42/375)];
        
        moreLabel.text=@"更多";
        moreLabel.textAlignment=NSTextAlignmentRight;
        moreLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
        moreLabel.textColor=[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0];
        
        [view addSubview:moreLabel];
        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-WIDTH*30/375, WIDTH*6/375, WIDTH*30/375, WIDTH*30/375)];
        
        [image setImage:[UIImage imageNamed:@"icon_return_gray"]];
        image.contentMode=UIViewContentModeCenter;
        [view addSubview:image];
    }
    
    
    
    UIImageView * image=[[UIImageView alloc]init];
    image.frame=CGRectMake(WIDTH* 13/375,WIDTH *13.5/375,WIDTH* 3/375,WIDTH *15/375);
    image.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    [view addSubview:image];
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame=CGRectMake(0, WIDTH*7/375, WIDTH, WIDTH*35/375);
    
    button.backgroundColor=[UIColor clearColor];
    
    [button addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    button.tag=section+200;
    
    [view addSubview:button];
    
    return view;
    
    
    

}
-(void)gotoDetail:(UIButton *)button{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * token=[NSString stringWithFormat:@"%@",[user objectForKey:@"token"]];
    
  NSString *tag=[NSString stringWithFormat:@"%@",_subArr[button.tag-200][@"tag"]];
    if (![tag isEqualToString:@"Hobby"]) {
        if (token.length>5) {
            
        
        
        MainDetailViewController * main=[[MainDetailViewController alloc]init];
        main.navTitle=_subArr[button.tag-200][@"title"];
        main.tag=tag;
            main.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:main animated:YES];
    }else{
       
        NewLoginViewController * his=[[NewLoginViewController alloc]init];
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
        
     }
        
        
}
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (WIDTH *42/375);//自定义高度
}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
/**
 设置轮播图和按钮为tableView的headerView
 */
-(void)setHeaderView{
    
    _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT * 232/667)];
    _headerView.backgroundColor=[UIColor whiteColor];
    
    
    _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH,HEIGHT *150/667) delegate:self placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView2.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView2.titleLabelHeight=WIDTH* 30/375;
    _cycleScrollView2.titleLabelTextFont=[UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.height* 14/667];
    _cycleScrollView2.pageControlBottomOffset=0;
    _cycleScrollView2.pageControlRightOffset=0;
    _cycleScrollView2.pageControlDotSize=CGSizeMake([UIScreen mainScreen].bounds.size.height* 5/667, [UIScreen mainScreen].bounds.size.height* 5/667);
    _cycleScrollView2.currentPageDotColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    _cycleScrollView2.pageDotColor=[UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0];
    _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    //    [demoContainerView addSubview:cycleScrollView2];
    
    _cycleScrollView2.autoScrollTimeInterval=5;
    
    
    [_headerView addSubview:_cycleScrollView2];
    
    UIView * btnView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT* 150/667, WIDTH, HEIGHT * 78/667)];
    
    btnView.backgroundColor=[UIColor whiteColor];
    
    [_headerView addSubview:btnView];
    
    
    NSArray * arr=[NSArray arrayWithObjects:@"weike",@"putonganli",@"baiwen",@"baike", nil];
    NSArray * titleArr=[NSArray arrayWithObjects:@"微课",@"微例",@"百问",@"百科", nil];
    
    
    for (int i=0; i<4; i++) {
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(i*WIDTH/4, HEIGHT * 50/667, WIDTH/4, HEIGHT * 28/667)];
        
        label.text=titleArr[i];
        label.font=[UIFont systemFontOfSize:WIDTH* 12/375];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        label.tag=100+i;
        
        [btnView addSubview:label];
        
        
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*WIDTH/4, 0, WIDTH/4, HEIGHT * 78/667);
        button.imageEdgeInsets=UIEdgeInsetsMake(-WIDTH* 20/375, 0, 0, 0);
        [button setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(categoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+2;
        [btnView addSubview:button];
      
        
        
    }
    
    self.tableView.tableHeaderView=_headerView;

    
    
    _kpidArr=[NSMutableArray new];
    _imageArr=[NSMutableArray new];
    _titleArr=[NSMutableArray new];
    _allData=[NSMutableArray new];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    if ([[user objectForKey:@"token"] length]>5) {
        _token=[NSString stringWithFormat:@"%@",[user objectForKey:@"token"]];
    }else{
    
        _token=[NSString stringWithFormat:@""];
    }
    
    NSString * Url=[NSString stringWithFormat:@"%@/ba/api/index/get_trending_stick_list?token=%@",URLDOMAIN,_token];
    
    [manager GET:Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject count]>0) {
            
        
        
        NSData *jsonData = [responseObject[@"list"] dataUsingEncoding:NSUTF8StringEncoding];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"imageMain"];
            
        if (jsonData) {
                
            
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",arr);
            
        for (NSDictionary * subDic in arr) {
            [_imageArr addObject:[NSString stringWithFormat:@"%@",subDic[@"res_url"]]];
            [_titleArr addObject:subDic[@"title"]];
            [_kpidArr addObject:subDic[@"kp_id"]];
            [_allData addObject:subDic];
        }
            
            
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"banner"];
            [arr writeToFile:filePath atomically:NO];
            
            _cycleScrollView2.imageURLStringsGroup = _imageArr;
            _cycleScrollView2.titlesGroup =  _titleArr;
            if (_titleArr.count<3) {
                self.tableView.tableHeaderView=nil;
            }
        }
            
    }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        _kpidArr=[NSMutableArray new];
        _imageArr=[NSMutableArray new];
        _titleArr=[NSMutableArray new];
        _allData=[NSMutableArray new];
        
        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"banner"];
        
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        if (arr.count>2) {
            for (NSDictionary * subDic in arr) {
                [_imageArr addObject:[NSString stringWithFormat:@"%@",subDic[@"res_url"]]];
                [_titleArr addObject:subDic[@"title"]];
                [_kpidArr addObject:subDic[@"kp_id"]];
                [_allData addObject:subDic];
            }
            _cycleScrollView2.imageURLStringsGroup = _imageArr;
            _cycleScrollView2.titlesGroup =  _titleArr;
        }else{
        
            self.tableView.tableHeaderView=nil;
        
        }
        
        
    }];

}

/**
 轮播图下面四个按钮点击方法

 @param button 按钮
 */
-(void)categoryBtn:(UIButton*)button{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
//    biaoganViewController * b=[[biaoganViewController alloc]init];
//    
//    b.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&categoryID=%ld&nodeID=1",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],(long)button.tag];
//    
//    [self.navigationController pushViewController:b animated:YES];
    
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>8) {
        JRStudyScreenViewController * all=[[JRStudyScreenViewController alloc]init];
        
        UILabel * label=[_headerView viewWithTag:100+button.tag-2];
        all.secondName=label.text;
        
        NSString * String1=[NSString stringWithFormat:@"%da%da%d",0,-1,-1];
        [user setObject:String1 forKey:@"selectedArray"];
        
        //    all.keyWord=[NSMutableString stringWithFormat:@""];
        all.nodeName=[NSMutableString stringWithFormat:@"%@",@"全部知识"];
        all.categoryID=[NSString stringWithFormat:@"2"];
        all.category=[NSMutableString stringWithFormat:@"%ld",button.tag];
        all.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:all animated:YES];
        
        
        
        
    
        
        
        

    }else{
    
        NewLoginViewController * his=[[NewLoginViewController alloc]init];
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    
    }
    
    
    

}

/**
 加载失败后重新加载方法

 @param button 按钮
 */
-(void)shuaxin:(UIButton *)button{
  
   
    
    
    
    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
    NSString * name=[UserInfo  objectForKey:@"nameStr"];
    NSString * pass = [UserInfo objectForKey:@"passStr"];
    NSString * imie =[UserInfo objectForKey:@"imie"];
    
    if (name.length>0) {
        
        UIView * view=[self.view viewWithTag:1200];
        
        [view removeFromSuperview];
        
        view=nil;
    
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
        [self loadNewData1];
        
//        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        
        
//        UIView * view=[[UIView alloc]initWithFrame:self.tableView.bounds];
//        view.backgroundColor=[UIColor whiteColor];
//        
//        view.tag=12;
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
        
        
        
    }];
    
   
    
    }
  
}

//static int i=2;
/**
 为tableView添加上啦加载控件
 */
-(void)setFooterView{
    
//    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        i++;
//        [self loadDataWithPage:i];
//        [self.tableView reloadData];
//        
//    }];
//    
    UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    label.text=@"我是有底线的";
    label.textAlignment=NSTextAlignmentCenter;
    [footerView addSubview:label];
    footerView.backgroundColor=[UIColor whiteColor];
    self.tableView.tableFooterView=footerView;
    
    
}

/**
 上拉加载增加列表数据

 @param page 页数：每八条请求一次
 */
-(void)loadDataWithPage:(int)page{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * Url=[NSString stringWithFormat:@"%@/ba/api/indexBack/getKnowledge.mob",URLDOMAIN];
  
    if ([[user objectForKey:@"token"] length]) {

     NSDictionary * dic=@{@"max_kp_ts":[user objectForKey:@"userTime"],@"node_id":self.node_id,@"token":[user objectForKey:@"token"]};
    
    [manager GET:Url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject[@"knowledgeList"]) {
            
            NSArray * arr = [NSArray arrayWithArray:responseObject[@"knowledgeList"]];
            [user setObject:[arr lastObject][@"release_time"] forKey:@"userTime"];
            
            for (NSDictionary * subDic in arr) {
                
                [_subArr addObject:subDic];
            }
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
  
    }
    
}


/**
 为tableView添加下拉刷新控件
 */
-(void)setRefreshView{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData1];
        
    }];
    
    
}
/**
 进入页面以及下拉刷新更新数据
 */
-(void)unLogin{
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];

    UIView * view1=[[UIView alloc]initWithFrame:self.view.bounds];
    
    view1.backgroundColor=[UIColor whiteColor];
    

    
    [manager POST:_Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject count]>0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_bacView removeFromSuperview];
                [self.button removeFromSuperview];
                self.button=nil;
            });
            
            
            
            if ([responseObject[@"knowledgeList"] count]>0) {
                
                NSArray * arr =[NSArray arrayWithArray:responseObject[@"knowledgeList"]] ;
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                [user setObject:[arr lastObject][@"release_time"] forKey:@"userTime"];
                NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                filePath = [filePath stringByAppendingFormat:@"/%@.plist",self.node_id];
                [arr writeToFile:filePath atomically:NO];
                [_subArr removeAllObjects];
                for (NSDictionary * subDic in arr) {
                    
                    [_subArr addObject:subDic];
                    
                }
                
                
                [self.tableView reloadData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_header endRefreshing];
                    
                    
                });
                if ([_subArr containsObject:@{@"catName":@"",@"category":@"SB",@"comment_count":@"0",@"img_content":@"knowledge/img/69d8568c-07ad-4df5-b4b8-8d162b362205.jpg",@"is_free" : @"yes",@"kp_id" : @"CA",@"node_name" : @"",@"release_time" : @"Aug 26, 2014 1:29:58 PM",@"title" : @"",@"video_film" : @"",}])
                {[_subArr removeObject:@{@"catName" : @"",@"category" : @"SB",@"comment_count" : @"0",@"img_content" : @"knowledge/img/69d8568c-07ad-4df5-b4b8-8d162b362205.jpg",@"is_free" : @"yes",@"kp_id" : @"CA",@"node_name" : @"",@"release_time" : @"Aug 26, 2014 1:29:58 PM",@"title" : @"",@"video_film" : @"",}];
                }
                
            }else{
                [self.tableView.mj_header endRefreshing];
                
                _bakView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 29)];
                _bakView.backgroundColor=[UIColor colorWithRed:255/255.0 green:237/255.0 blue:220/255.0 alpha:1.0];
                
                UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 29)];
                label.textAlignment=NSTextAlignmentCenter;
                label.text=[NSString stringWithFormat:@"没有新数据"];
                label.font=[UIFont systemFontOfSize:14];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.view addSubview:_bakView];
                    [_bakView addSubview:label];
                });
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_bakView removeFromSuperview];
                    
                });
                
                
            }
            
        }
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
        NSString * name=[UserInfo  objectForKey:@"nameStr"];
        NSString * pass = [UserInfo objectForKey:@"passStr"];
        NSString * imie =[UserInfo objectForKey:@"imie"];
        
        if (name.length>0) {
            
            UIView * view=[self.view viewWithTag:1200];
            
            [view removeFromSuperview];
            
            view=nil;
            
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
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                
                
                
                
                
                
                
            }];
            
            
            
        }
        
        
        
        
        
        if (_subArr.count>0) {
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_bacView removeFromSuperview];
                
                [self.button removeFromSuperview];
                self.button=nil;
                
                [self.tableView.mj_header endRefreshing];
                
            });
            
            
            
            
            [view1 removeFromSuperview];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
                
            });
            
            
            UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            view.backgroundColor=[UIColor whiteColor];
            view.tag=1200;
            
            
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
            
            
            imageView.image=[UIImage imageNamed:@"image_server"];
            
            
            [view addSubview:imageView];
            
            UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT*190/568, WIDTH, 20)];
            
            label1.text=@"服务器开小差了~工程师正在召唤它...";
            label1.font=[UIFont systemFontOfSize:18];
            label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            
            label1.textAlignment=NSTextAlignmentCenter;
            
            [view addSubview:label1];
            
            
            
            
            
            UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 64+HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
            
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
        
        
        
        
        
        
        
    }];


}


-(void)isLogined{
    
    
   
}



-(void)loadNewData1{

    
    
   
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"token"] length]>5) {
        _token=[NSString stringWithFormat:@"%@",[user objectForKey:@"token"]];
        
        _Url=[NSString stringWithFormat:@"%@/ba/api/indexBack/getKnowledgeIndex.mob?token=%@",URLDOMAIN,_token];
        
        
        
    }else{
        
        _token=[NSString stringWithFormat:@"%@",@""];
         _Url=[NSString stringWithFormat:@"%@/ba/api/indexBack/getKnowledgeIndex.mob?token=%@",URLDOMAIN,_token];
       
    }
    
   
    
    
    
    
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    
    
    [manager POST:_Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
                _kpidArr=[NSMutableArray new];
                _imageArr=[NSMutableArray new];
                _titleArr=[NSMutableArray new];
               _allData=[NSMutableArray new];
                NSString * Url=[NSString stringWithFormat:@"%@/ba/api/index/get_trending_stick_list?token=%@",URLDOMAIN,_token];
        
                [manager GET:Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
                    
                    
                    if ([responseObject count]>0) {
        
                       
        
                        NSData *jsonData = [responseObject[@"list"] dataUsingEncoding:NSUTF8StringEncoding];
        
        
                        [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:@"imageMain"];
                        if (jsonData) {
                            
                        
                        
                        
                        
                        NSArray * arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
                        for (NSDictionary * subDic in arr) {
                            [_imageArr addObject:[NSString stringWithFormat:@"%@",subDic[@"res_url"]]];
                            [_titleArr addObject:subDic[@"title"]];
                            [_kpidArr addObject:subDic[@"kp_id"]];
                            [_allData addObject:subDic];
                        }
        
                        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                        filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"banner"];
                        [arr writeToFile:filePath atomically:NO];
        
        
        
                        _cycleScrollView2.imageURLStringsGroup = _imageArr;
                        _cycleScrollView2.titlesGroup =  _titleArr;
                        if (_titleArr.count<3) {
                            self.tableView.tableHeaderView=nil;
                        }
        
                        }
        
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
                    NSLog(@"%@",error);
                    
                    
                    
                    
                    
        
                    //        _kpidArr=[NSMutableArray new];
                    //        _imageArr=[NSMutableArray new];
                    //        _titleArr=[NSMutableArray new];
                    //
                    //
                    //        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                    //        filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"banner"];
                    //
                    //
                    //        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
                    //        if (arr.count>2) {
                    //            for (NSDictionary * subDic in arr) {
                    //                [_imageArr addObject:[NSString stringWithFormat:@"%@",subDic[@"res_url"]]];
                    //                [_titleArr addObject:subDic[@"title"]];
                    //                [_kpidArr addObject:subDic[@"kp_id"]];
                    //
                    //            }
                    //            _cycleScrollView2.imageURLStringsGroup = _imageArr;
                    //            _cycleScrollView2.titlesGroup =  _titleArr;
                    //        }else{
                    //
                    //            self.tableView.tableHeaderView=nil;
                    //
                    //        }
        
        
        
                }];
        
        
        
        
        
        
        
        if ([responseObject count]>0&&[responseObject[@"lists"] count]>0) {
            
            _subArr=[NSMutableArray new];
            
            for (NSDictionary * dic in responseObject[@"lists"]) {
                [_subArr addObject:dic];
            }
            
            
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"xinshouye"];
            [responseObject[@"lists"] writeToFile:filePath atomically:NO];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
        

        

    }];
    
  
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    
    return [_subArr[section][@"value"] count];
}

/**
 懒加载生成数据源

 @return 返回数据源数组
 */
//- (NSMutableArray *)subArr{
//    
//    if (!_subArr) {
//        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//        filePath = [filePath stringByAppendingFormat:@"/%@.plist",self.node_id];
//
//        
//        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
//        
//        _subArr = arr.count > 0 ? [NSMutableArray arrayWithArray:arr] :[NSMutableArray array];
//        
//    }
//    return _subArr;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [MTA trackCustomEvent:@"btn_home_detail" args:[NSArray arrayWithObject:@"arg0"]];

    NSString * cate=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"category"]];
    
    NSString* image=_subArr[indexPath.section][@"value"][indexPath.row][@"img_url"];
    
    
    
    
    NSString * string=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]];
    
    
    if ([string length]>0) {
        _nodeString=[NSString stringWithFormat:@"%@",string];
    }else{
    
        _nodeString=[NSString stringWithFormat:@"根"];
    
    }
    
    if ([cate isEqualToString:@"2"]) {
        OneImageTableViewCell * cell=[OneImageTableViewCell cellWithTableView:tableView];
        
//        _subArr[indexPath.section][@"value"][indexPath.row]
        NSString *str = [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
       
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
        cell.DetailLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"paper"]];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        cell.categaryLabel.text=[NSString stringWithFormat:@"微课-[%@]",_nodeString];
       
        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]];
        
        
        CGSize theSize = [[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.flowerImage.frame=CGRectMake(347*WIDTH/375-theSize.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        
        cell.commentLabel.frame=CGRectMake(WIDTH* 10/375, 100*WIDTH/375, cell.flowerImage.frame.origin.x-WIDTH* 15/375 , 10);
        
         cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
        
        CGSize Size = [[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.commentImage.frame=CGRectMake(cell.flowerImage.frame.origin.x-WIDTH* 24/375-Size.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        cell.categaryLabel.text=@"微课";
        cell.nodeLabel.text= _nodeString;
       
        
        
       
        
        return cell;
    }else if ([cate isEqualToString:@"SB"]) {
        refreshTableViewCell * cell=[refreshTableViewCell cellWithTableView:tableView];
        
        return cell;
    }else{
    
    
        LeftImageTableViewCell * cell=[LeftImageTableViewCell cellWithTableView:tableView];
        
        NSString *str = [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
      
      
        cell.DetailLabel.text=_subArr[indexPath.section][@"value"][indexPath.row][@"paper"];
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]];
        
        
        
        
        
        
        CGSize theSize = [[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.flowerImage.frame=CGRectMake(347*WIDTH/375-theSize.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        
        cell.commentLabel.frame=CGRectMake(WIDTH* 10/375, 100*WIDTH/375, cell.flowerImage.frame.origin.x-WIDTH* 15/375 , 10);
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
        
        CGSize Size = [[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.commentImage.frame=CGRectMake(cell.flowerImage.frame.origin.x-WIDTH* 24/375-Size.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        
        
        
        
        [cell.OneImage sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        if ([cate isEqualToString:@"3"]) {
              cell.categaryLabel.text=@"微例";
        }else if([cate isEqualToString:@"4"]){
        cell.categaryLabel.text=@"百问";
        }else if ([cate isEqualToString:@"5"]){
        
        cell.categaryLabel.text=@"百科";
        }
        
        
        
        cell.nodeLabel.text= _nodeString;
        
        
 
        return cell;

  
    
   
   
    
//    if ([cate isEqualToString:@"3"]) {
//        RightImageTableViewCell * cell=[RightImageTableViewCell cellWithTableView:tableView];
//        
//        cell.titleLabel.text=_subArr[indexPath.section][@"value"][indexPath.row][@"title"];
//        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
//        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]];
//        [cell.OneImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        [cell.TwoImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        [cell.ThreeImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        cell.categaryLabel.text=[NSString stringWithFormat:@"微例-[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]];
//        cell.categaryLabel.text=@"微例";
//        cell.nodeLabel.text=_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"];
//        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"微例-[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]]];
//        NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"微例"].location, [[noteStr string] rangeOfString:@"微例"].length);
//        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236/255.0 green:124/255.0 blue:127/255.0 alpha:1.0] range:redRange];
//        NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@"[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]]].length);
//        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124/255.0 green:193/255.0 blue:236/255.0 alpha:1.0] range:redRangeTwo];
//        NSRange redRangeThree = NSMakeRange([[noteStr string] rangeOfString:@"-"].location, [[noteStr string] rangeOfString:@"-"].length);
//        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] range:redRangeThree];
//        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
//        cell.DetailLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"paper"]];
//        cell.DetailLabel.backgroundColor=[UIColor redColor];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//
//        
//    }
//    if ([cate isEqualToString:@"4"]) {
//        
//        ThreeImageTableViewCell * cell=[ThreeImageTableViewCell cellWithTableView:tableView];
//        cell.titleLabel.text=_subArr[indexPath.section][@"value"][indexPath.row][@"title"];
//        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
//        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]];;
//        [cell.OneImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        [cell.TwoImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        [cell.ThreeImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        cell.categaryLabel.text=[NSString stringWithFormat:@"百问-[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]];
//        
//        cell.categaryLabel.text=@"百问";
//        cell.nodeLabel.text=_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"];
//        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"百问-[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]]];
//        NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"百问"].location, [[noteStr string] rangeOfString:@"百问"].length);
//        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236/255.0 green:124/255.0 blue:127/255.0 alpha:1.0] range:redRange];
//        NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@"[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"[%@]",_subArr[indexPath.section][@"value"][indexPath.row][@"node_name"]]].length);
//        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124/255.0 green:193/255.0 blue:236/255.0 alpha:1.0] range:redRangeTwo];
//        NSRange redRangeThree = NSMakeRange([[noteStr string] rangeOfString:@"-"].location, [[noteStr string] rangeOfString:@"-"].length);
//        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] range:redRangeThree];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    } if ([cate isEqualToString:@"5"]) {
//        
//        
//        
//        LeftImageTableViewCell * cell=[LeftImageTableViewCell cellWithTableView:tableView];
//        
//        cell.titleLabel.text=_subArr[indexPath.section][@"value"][indexPath.row][@"title"];
//        
//        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"comment_count"]];
//        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeNum"]];;
//        [cell.OneImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bag.89mc.com:8090/%@",_subArr[indexPath.section][@"value"][indexPath.row][@"img_content"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//        
//        
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//        
//        
//        
//     
//        
//        
//    }

    }
    
 
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cate=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"category"]];
    
    if ([cate isEqualToString:@"2"]) {
        return 125*WIDTH/375;
    }if ([cate isEqualToString:@"5"]) {
        return 127.5*WIDTH/375;
    }if ([cate isEqualToString:@"4"]) {
        return 127.5*WIDTH/375;
    }if ([cate isEqualToString:@"SB"]) {
        return 58;
    }
    
    return 127.5*WIDTH/375;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * token=[user objectForKey:@"token"];
        
        NSString * cate=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"category"]];
        
        biaoganViewController * biaogan=[[biaoganViewController alloc]init];
        
        biaogan.kpId=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"]];
        
        NSString * str;
        
        if (token.length>5) {
            str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?kpID=%@&token=%@",URLDOMAIN,[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"]],token];
        }else{
            
            str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?kpID=%@&token=%@",URLDOMAIN,[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"]],@""];
            
        }
        
        
        
        
        
        [user setObject:[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"]] forKey:@"kpID"];
        
        biaogan.webUrl=str;
        
        
        [user setObject:[NSString stringWithFormat:@"%@a%lda%lda%@",_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"],indexPath.section,(long)indexPath.row,cate] forKey:@"shuaxin"];
        
//        [self.navigationController pushViewController:biaogan animated:YES];
        JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
        vc.segmentBgColor = [UIColor clearColor];
        vc.indicatorViewColor = [UIColor whiteColor];
        vc.titleColor = [UIColor whiteColor];
        introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
        
        AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
        
        
        NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
        
        a.kpId=_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"];
        b.kpID=_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"];

//        a.kpId=@"4751";
        c.kpID=_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"];
    
    if (token.length<8) {
        [vc setViewControllers:@[a]];

    }else{
        [vc setViewControllers:@[a,b,c]];

    }
    
        [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
        vc.kpID=_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"];
        vc.kTitle=_subArr[indexPath.section][@"value"][indexPath.row][@"title"];
        vc.kContent=_subArr[indexPath.section][@"value"][indexPath.row][@"paper"];
        vc.kIconUrl=_subArr[indexPath.section][@"value"][indexPath.row][@"img_url"];
        vc.hidesBottomBarWhenPushed=YES;
    if ([cate isEqualToString:@"2"]) {
        
        TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
        
        video.kpId=_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"];
        
        video.kTitle=_subArr[indexPath.section][@"value"][indexPath.row][@"title"];
        video.kContent=_subArr[indexPath.section][@"value"][indexPath.row][@"paper"];
        video.kIconUrl=_subArr[indexPath.section][@"value"][indexPath.row][@"img_url"];
        video.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:video animated:YES];
        
    }else{
    
        
        xiangqingyeViewController * xiangqing=[[xiangqingyeViewController alloc]init];
        xiangqing.hidesBottomBarWhenPushed=YES;
        
        [user setObject:_subArr[indexPath.section][@"value"][indexPath.row][@"kp_id"] forKey:@"knowledgeID"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
//        [self.navigationController pushViewController:vc animated:YES];

    }
    
    

        
        

    

    
    
    
    
}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * s=[user objectForKey:@"shuaxin"];
    
    
    if (s.length>2) {
        
    
    
    NSArray * arr=[s componentsSeparatedByString:@"a"];
        NSString * cate=arr[3];
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSString * URL=[NSString stringWithFormat:@"%@/ba/api/index/get_knowlege_comment_like_count?token=%@&knowledgeId=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],arr[0]];
        
        
        
        
     [manager POST:URL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
   
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:nil];
    
    
    
    
 
    if (_subArr.count>[arr[1] integerValue]) {
        
    
    if (_subArr.count>0&&[[_subArr objectAtIndex:[arr[1] integerValue]] count]>0) {
        
//    NSMutableDictionary * subDic=[_subArr objectAtIndex:[arr[1] integerValue]];
    NSString * like=[NSString stringWithFormat:@"%@",dic[@"likeNum"]];
    
    NSString * comment=[NSString stringWithFormat:@"%@",dic[@"commentNum"]];
        
        
        
//    [subDic setObject:like forKey:@"likeNum"];
//    [subDic setObject:comment forKey:@"comment_count"];
    
    if ([cate isEqualToString:@"2"]) {

        OneImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
        cell.flowerLabel.text=like;
        
        cell.commentLabel.text=comment;
        
        
    } if([cate isEqualToString:@"3"]) {
        
        LeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
        cell.flowerLabel.text=like;
        
        cell.commentLabel.text=comment;
        
        
    }if([cate isEqualToString:@"4"]) {
        
        LeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
        cell.flowerLabel.text=like;
        
        cell.commentLabel.text=comment;
        
        
    }if([cate isEqualToString:@"5"]) {
        
        LeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
        cell.flowerLabel.text=like;
        
        cell.commentLabel.text=comment;
        
        
    }
    [user setObject:@"" forKey:@"shuaxin"];
    }

        
}
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
}];

    
}
    

    
}



/**
 点击轮播图图片调用的代理方法

 @param cycleScrollView 轮播图
 @param index  点击的图片的下标
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    
   
    NSString * cate=[NSString stringWithFormat:@"%@",_allData[index][@"knowledge_classification"]];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSString * token=[user objectForKey:@"token"];
    
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor clearColor];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
    
    AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
    
    
    NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
    
    a.kpId=_allData[index][@"kp_id"];
    b.kpID=_allData[index][@"kp_id"];
    
    //        a.kpId=@"4751";
    c.kpID=_allData[index][@"kp_id"];
    if (token.length<8) {
        [vc setViewControllers:@[a]];
        
    }else{
        [vc setViewControllers:@[a,b,c]];
        
    }
    
    [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
    vc.kpID=_allData[index][@"kp_id"];
    vc.kTitle=_allData[index][@"title"];
    vc.kContent=_allData[index][@"paper"];
    vc.kIconUrl=_allData[index][@"res_url"];
    vc.hidesBottomBarWhenPushed=YES;
    if ([cate isEqualToString:@"2"]) {
        
        TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
        
        video.kpId=_allData[index][@"kp_id"];
        video.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:video animated:YES];
        
    }else{
        
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    

    
   
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [_bakView removeFromSuperview];
    _bacView=nil;
}


- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    
    return _subArr.count;
}
@end
/*

 
 
 */
