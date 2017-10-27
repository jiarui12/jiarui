//
//  commentListViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/17.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "commentListViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "commentTableViewCell.h"
#import "WKProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"
#import "biaoganViewController.h"
#import "nonetConViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "introduceKnowledgeViewController.h"
#import "AboutKnowledgeTableViewController.h"
#import "JRSegmentViewController.h"
#import "NewCommentListTableViewController.h"
#import "TheVideoClassViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface commentListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * commentArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,strong)NSMutableArray * timeArray;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)NSMutableArray * DataArray;
@property(nonatomic,strong)NSMutableArray * kpIDArr;
@property(nonatomic,strong)NSMutableArray * cateArr;
@end

@implementation commentListViewController
-(void)loadData{
    
      WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"加载中.." animated:YES];
    AFHTTPSessionManager * manager= [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getMyPostList.mob?token=%@&pageNumber=1",URLDOMAIN,token];
    
    
    NSLog(@"%@",url);
    
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud dismiss:YES];
        NSMutableArray * arr=[NSMutableArray arrayWithArray:responseObject];
        
        NSLog(@"%@",arr);
        
        
        if (arr.count!=0) {
            for (NSDictionary * subDic in arr) {
                [_commentArray addObject:subDic[@"commentContent"]];
                [_imageArray addObject:subDic[@"iconUrl"]];
                [_titleArray addObject:subDic[@"title"]];
                [_timeArray addObject:subDic[@"commentTime"]];
                [_kpIDArr addObject:subDic[@"kpID"]];
                [_cateArr addObject:[NSString stringWithFormat:@"%@",subDic[@"knowledge_classification"]]];
            }
            self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
            
            _tableView.delegate=self;
            _tableView.dataSource=self;
            
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                i++;
                [self loadDataWithPage:i];
            }];
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.view addSubview:_tableView];
            [self.tableView reloadData];
        }else{
                [_tableView removeFromSuperview];
                _tableView=nil;
            
                UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
                v.backgroundColor=[UIColor whiteColor];
                [self.view addSubview:v];
                UILabel * nilLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0,150, self.view.frame.size.width, 20)];
                nilLabel1.textColor=[UIColor grayColor];
                nilLabel1.textAlignment=NSTextAlignmentCenter;
                //    nilLabel1.text=@"学习无捷径.....";
            
                nilLabel1.text=@"里面暂无内容哦";
            
            
                UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
            
            
                imageView.image=[UIImage imageNamed:@"wixiaoxi"];
            
            
                [self.view addSubview:imageView];
            
                UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
            
                label.text=@"空空如也...";
                label.font=[UIFont systemFontOfSize:19];
                label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            
                label.textAlignment=NSTextAlignmentCenter;
            
                [self.view addSubview:label];
            
            
                UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
            
                second.text=@"";
            
                second.textAlignment=NSTextAlignmentCenter;
            
                second.font=[UIFont systemFontOfSize:14];
            
                second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
            
                [self.view addSubview:second];
            
            
            
            
                UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
                chongxin.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
                
                [chongxin setTitle:@"返回" forState:UIControlStateNormal];
                
                chongxin.layer.cornerRadius=4.5;
                
                
                [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
                
                [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self.view addSubview:chongxin];

            
        
        
        
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
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
        

        
        
    }];
    
    

}
-(void)shuaxinle:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];


}
-(void)nonetCon:(UIButton * )button{
    nonetConViewController * no=[[nonetConViewController alloc]init];
    [self.navigationController pushViewController:no animated:YES];
    
    
}
-(void)shuaxin:(UIButton *)button{
    [_backView removeFromSuperview];
    
    _backView=nil;
    
    
    [self loadData];
  

}
static int  i=1;

-(void)loadDataWithPage:(int)page{
    _DataArray=[NSMutableArray new];
    AFHTTPSessionManager * manager= [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getMyPostList.mob?token=%@&pageNumber=%d",URLDOMAIN,token,page];
    
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSMutableArray * arr=[NSMutableArray arrayWithArray:responseObject];
        
        
        
        
        
        if (arr.count>0) {
            
        
        
        for (NSDictionary * subDic in arr) {
            [_commentArray addObject:subDic[@"commentContent"]];
            [_imageArray addObject:subDic[@"iconUrl"]];
            [_titleArray addObject:subDic[@"title"]];
            [_timeArray addObject:subDic[@"commentTime"]];
            [_kpIDArr addObject:subDic[@"kpID"]];
            [_cateArr addObject:[NSString stringWithFormat:@"%@",subDic[@"knowledge_classification"]]];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        }else{
        
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];

    }];
    

    
    
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title=@"我的评论";
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    _kpIDArr=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    _commentArray=[NSMutableArray new];
    _imageArray=[NSMutableArray new];
    _timeArray=[NSMutableArray new];
    _titleArray=[NSMutableArray new];
    _cateArr=[NSMutableArray new];
    [self loadData];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    
    
}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    commentTableViewCell * cell=[commentTableViewCell cellWithTableView:tableView];
    cell.timeLabel.text=[_timeArray[indexPath.row] componentsSeparatedByString:@" "][0];
    NSURL * url=[NSURL URLWithString:_imageArray[indexPath.row]];
    [cell.titleImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"material_default_pic_2"]];
    cell.titleLabel.text=_titleArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.commentLabel.text=_commentArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor clearColor];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
    
    AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
    
    
    NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
    
    a.kpId=_kpIDArr[indexPath.row];
    b.kpID=_kpIDArr[indexPath.row];
    
    //        a.kpId=@"4751";
    c.kpID=_kpIDArr[indexPath.row];
    
    if (token.length<8) {
        [vc setViewControllers:@[a]];
        
    }else{
        [vc setViewControllers:@[a,b,c]];
        
    }
    
    [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
    vc.kpID=_kpIDArr[indexPath.row];
    vc.kTitle=_titleArray[indexPath.row];
    vc.kContent=_commentArray[indexPath.row];
    vc.kIconUrl=_imageArray[indexPath.row];
    vc.hidesBottomBarWhenPushed=YES;
    if ([_cateArr[indexPath.row] isEqualToString:@"2"]) {
        
        TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
        
        video.kpId=_kpIDArr[indexPath.row];;
    
        video.kTitle=_titleArray[indexPath.row];
        video.kContent=_commentArray[indexPath.row];
        video.kIconUrl=_imageArray[indexPath.row];
        video.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:video animated:YES];
        
    }else{
        
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        //        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    

    
    
    
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   self.navBarBgAlpha=@"1.0";

}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}
@end
