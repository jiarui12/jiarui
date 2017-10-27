//
//  AboutKnowledgeTableViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//
#import "TheVideoClassViewController.h"
#import "AboutKnowledgeTableViewController.h"
#import "introduceKnowledgeViewController.h"
#import "NewCommentListTableViewController.h"
#import "smallSampleViewController.h"
#import "JRKnowLedgeTableViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "NewOneImageTableViewCell.h"
#import "TwoImageTableViewCell.h"
#import "ThreeImageTableViewCell.h"
#import "NewLeftImageTableViewCell.h"
#import "RightImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "refreshTableViewCell.h"
#import "BrowserViewController.h"
#import "WKProgressHUD.h"
#import "biaoganViewController.h"
#import "SDCycleScrollView.h"
#import "nonetConViewController.h"
#import "DynamicViewController.h"
#import "MBProgressHUD+HM.h"
#import "MainDetailViewController.h"
#import "NewLoginViewController.h"
#import "MTA.h"
#import "JRStudyScreenViewController.h"
#import "JRSegmentViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface AboutKnowledgeTableViewController ()<SDCycleScrollViewDelegate,UIViewControllerPreviewingDelegate>
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
@property(nonatomic,strong)UIActivityIndicatorView * activityIndicatorView;
@property(nonatomic,assign)BOOL isJiazai;
@property(nonatomic,assign)BOOL isNojiazai;
@property(nonatomic,strong)UIView * backView;

@end

@implementation AboutKnowledgeTableViewController

{
    
    NSString * _Url;
    
    
}

-(void)changeBgColor{

    [self loadNewData1];


}
-(void)dealloc{


    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.frame=CGRectMake(WIDTH/2-22, WIDTH/3, 44, 44);
    
    [self.view addSubview:self.activityIndicatorView];
    
    
    
    [self.activityIndicatorView startAnimating];
    

    
    
    _kpidArr=[NSMutableArray new];
    _imageArr=[NSMutableArray new];
    _titleArr=[NSMutableArray new];
    _subArr=[NSMutableArray new];
    
    _countArr=[NSMutableArray new];
    
    
    self.tableView.sectionFooterHeight=0;
    self.tableView.sectionHeaderHeight=20;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    // 2.设置网络状态改变后的处理
//    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        // 当网络状态改变了, 就会调用这个block
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                
//                if (!_isNojiazai) {
//                    [self loadNewData1];
//                    
//                }
//                break;
//            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                if (!_isJiazai) {
//                    [self loadNewData1];
//                    
//                }
//                
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                NSLog(@"手机自带网络");
//                if (!_isNojiazai) {
//                    [self loadNewData1];
//                    
//                }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
//                NSLog(@"WIFI");
//                if (!_isNojiazai) {
////
//                }
//                break;
//        }
//    }];
//    // 3.开始监控
//    [mgr startMonitoring];
//
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor) name:@"shuaxinleya" object:nil];

    [self loadNewData1];

    
  
    
    
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
 
    
    
    
    UIImageView * image=[[UIImageView alloc]init];
    image.frame=CGRectMake(WIDTH* 13/375,WIDTH *13.5/375,WIDTH* 3/375,WIDTH *15/375);
    image.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    [view addSubview:image];
    
    
    
    return view;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (WIDTH *42/375);//自定义高度
}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}


-(void)categoryBtn:(UIButton*)button{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    //    biaoganViewController * b=[[biaoganViewController alloc]init];
    //
    //    b.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&categoryID=%ld&nodeID=1",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],(long)button.tag];
    //
    //    [self.navigationController pushViewController:b animated:YES];
    
    
    
    
    JRStudyScreenViewController * all=[[JRStudyScreenViewController alloc]init];
    
    UILabel * label=[_headerView viewWithTag:100+button.tag-2];
    all.secondName=label.text;
    
    NSString * String1=[NSString stringWithFormat:@"%da%da%d",0,-1,-1];
    [user setObject:String1 forKey:@"selectedArray"];
    
    //    all.keyWord=[NSMutableString stringWithFormat:@""];
    all.nodeName=[NSMutableString stringWithFormat:@"%@",@"全部知识"];
    all.categoryID=[NSString stringWithFormat:@"2"];
    all.category=[NSMutableString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:all animated:YES];
    
    
    
    
    
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











-(void)loadNewData1{
    
    
    UIView * a=[self.view viewWithTag:123];
    
    [a removeFromSuperview];
    
    a=nil;
    
    self.kpID=self.kpID?[NSString stringWithFormat:@"%@",self.kpID]:[NSString stringWithFormat:@"%@",self.parameter];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"token"] length]>5) {
        _token=[NSString stringWithFormat:@"%@",[user objectForKey:@"token"]];
        
        _Url=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getRelateKnowledge.mob?token=%@&knowledge_id=%@",URLDOMAIN,_token,self.kpID];
        
        
        
    }else{
        
        _token=[NSString stringWithFormat:@"%@",@""];
        _Url=[NSString stringWithFormat:@"%@/ba/api/indexBack/getKnowledgeIndex.mob?token=%@",URLDOMAIN,_token];
        
    }
    
    
    
    
    
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager POST:_Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if ([responseObject[@"responseText"] isEqualToString:@"成功"]) {
            
            [self.activityIndicatorView stopAnimating];
                _subArr=[NSMutableArray new];
            
            
            
            if ([responseObject[@"list"] count]>0) {
                
            
            for (NSDictionary * dic in responseObject[@"list"]) {
                [_subArr addObject:dic];
                
                
                
                
            }
                [self.tableView reloadData];

            }else{
                [self.activityIndicatorView stopAnimating];


                    UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
                    v.backgroundColor=[UIColor whiteColor];
                    v.tag=123;
                    [self.view addSubview:v];
                    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
                    imageView.image=[UIImage imageNamed:@"wixiaoxi"];
                
                
                    [v addSubview:imageView];
                
                    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
                
                    label.text=@"空空如也...";
                    label.font=[UIFont systemFontOfSize:19];
                    label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
                    
                    label.textAlignment=NSTextAlignmentCenter;
                    
                    [v addSubview:label];
                
                [self.view addSubview:v];
            }
        }
        
        
        
        
        
        
//        if ([responseObject count]>0&&[responseObject[@"lists"] count]>0) {
//            
//            _subArr=[NSMutableArray new];
//            
//            for (NSDictionary * dic in responseObject[@"lists"]) {
//                [_subArr addObject:dic];
//            }
//            
//            
//            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//            filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"xinshouye"];
//            [responseObject[@"lists"] writeToFile:filePath atomically:NO];
//            [self.tableView.mj_header endRefreshing];
//            [self.tableView reloadData];
//        }
//        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
        
        [self.activityIndicatorView stopAnimating];

        UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
        v.backgroundColor=[UIColor whiteColor];
        v.tag=123;
        [self.view addSubview:v];
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, HEIGHT*120/568, WIDTH * 90/320, HEIGHT* 90/568)];
        imageView.image=[UIImage imageNamed:@"image_error"];
        
        
        [v addSubview:imageView];
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*220/568, WIDTH, 20)];
        
        label.text=@"空空如也...";
        label.font=[UIFont systemFontOfSize:19];
        label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label.textAlignment=NSTextAlignmentCenter;
        
        [v addSubview:label];
        
        [self.view addSubview:v];

        
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
    
    NSString * cate=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_classification"]];
    
    NSString* image=_subArr[indexPath.section][@"value"][indexPath.row][@"icon"];
    
    
    
    
    if ([cate isEqualToString:@"2"]) {
        NewOneImageTableViewCell * cell=[NewOneImageTableViewCell cellWithTableView:tableView];
        
        //        _subArr[indexPath.section][@"value"][indexPath.row]
        NSString *str = [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 133.3/375, 14*WIDTH/375, WIDTH * 215/375, expectSize.height);
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"commentCount"]];
        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeCount"]];
        cell.categaryLabel.text=@"微课";
       
        
        
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            
            //给cell注册3DTouch的peek（预览）和pop功能
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        } else {
            
        }
        
        
        return cell;
    }else if ([cate isEqualToString:@"SB"]) {
        refreshTableViewCell * cell=[refreshTableViewCell cellWithTableView:tableView];
        
        return cell;
    }else{
        
        
        NewLeftImageTableViewCell * cell=[NewLeftImageTableViewCell cellWithTableView:tableView];
        
        NSString *str = [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 133.3/375, 14*WIDTH/375, WIDTH * 215/375, expectSize.height);
        
        
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"commentCount"]];
        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"likeCount"]];
        
        
        [cell.OneImage sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        if ([cate isEqualToString:@"3"]) {
            cell.categaryLabel.text=@"微例";
        }else if([cate isEqualToString:@"4"]){
            cell.categaryLabel.text=@"百问";
        }else if ([cate isEqualToString:@"5"]){
            
            cell.categaryLabel.text=@"百科";
        }
        
        
        
        
        
        
       
        return cell;
        
        
        
        
    
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 110*WIDTH/375;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    
    NSString * cate=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_classification"]];
    
    
    
    
    
    
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
    vc.segmentBgColor = [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
    
    AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
    
    
    NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
    
    a.kpId=_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_id"];
    
    
    b.kpID=_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_id"];
    
    
    c.kpID=_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_id"];
    [vc setViewControllers:@[a,b,c]];
    [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
    vc.kpID=_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_id"];
    vc.kTitle=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_title"]];
    vc.kContent=_subArr[indexPath.section][@"value"][indexPath.row][@"paper"];
    vc.kIconUrl=_subArr[indexPath.section][@"value"][indexPath.row][@"img_url"];
    
    if ([cate isEqualToString:@"2"]) {
        TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
        
        video.kpId=_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_id"];
        
        video.kTitle=[NSString stringWithFormat:@"%@",_subArr[indexPath.section][@"value"][indexPath.row][@"knowledge_title"]];
        video.kContent=_subArr[indexPath.section][@"value"][indexPath.row][@"paper"];
        video.kIconUrl=_subArr[indexPath.section][@"value"][indexPath.row][@"img_url"];
        video.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:video animated:YES];
    }else{
    
        [self.navigationController pushViewController:vc animated:YES];

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
                        
                        NewOneImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
                        cell.flowerLabel.text=like;
                        
                        cell.commentLabel.text=comment;
                        
                        
                    } if([cate isEqualToString:@"3"]) {
                        
                        NewLeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
                        cell.flowerLabel.text=like;
                        
                        cell.commentLabel.text=comment;
                        
                        
                    }if([cate isEqualToString:@"4"]) {
                        
                        NewLeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
                        cell.flowerLabel.text=like;
                        
                        cell.commentLabel.text=comment;
                        
                        
                    }if([cate isEqualToString:@"5"]) {
                        
                        NewLeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
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
    
    
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSString * token=[user objectForKey:@"token"];
    
    
    biaoganViewController * know=[[biaoganViewController alloc]init];
    
    
    
    
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?kpID=%@&token=%@",URLDOMAIN,[NSString stringWithFormat:@"%@",_kpidArr[index]],token];
    [user setObject:[NSString stringWithFormat:@"%@",_kpidArr[index]] forKey:@"kpID"];
    know.webUrl=str;
    know.kpId=_kpidArr[index];
    
    
    [self.navigationController pushViewController:know animated:YES];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    return _subArr.count;
}

-(void)loadNoWifi{
    _isNojiazai=YES;
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    
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
    
    UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,HEIGHT *190/568, WIDTH,HEIGHT *12.5/568)];
    frist.text=@"亲，您的手机网络不太顺畅哦~";
    frist.textAlignment=NSTextAlignmentCenter;
    frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    
    [_backView addSubview:frist];
    
    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
    
    second.text=@"请检查您的手机是否联网";
    
    second.textAlignment=NSTextAlignmentCenter;
    
    second.font=[UIFont systemFontOfSize:15];
    
    second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    [_backView addSubview:second];
    
    
    [_backView addSubview:topView];
    
    //    [_backView addSubview:button];
    UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
    chongxin.frame=CGRectMake(WIDTH *100/320,HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
    
    [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
    
    chongxin.layer.cornerRadius=4.5;
    
    
    [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
    
    [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_backView addSubview:chongxin];
    
    
    UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320,HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
    big.image=[UIImage imageNamed:@"image_net"];
    
    
    [_backView addSubview:big];
    
    
    [self.view addSubview:_backView];
    
}
-(void)shuaxinle:(UIButton *)button{
    
    [self loadNewData1];
    
    
}
-(void)nonetCon:(UIButton *)button{
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    [self.navigationController pushViewController:no animated:YES];
    
    
}


@end
