//
//  followViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/2/25.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "followViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "UIImageView+WebCache.h"
#import "followTableViewCell.h"
#import "MJRefresh.h"
#import "WKProgressHUD.h"
#import "nonetConViewController.h"
#import "biaoganViewController.h"
#import "LeftImageTableViewCell.h"
#import "OneImageTableViewCell.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface followViewController ()<UIViewControllerPreviewingDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * fromArr;
@property(nonatomic,strong)NSMutableArray * titleArr;
@property(nonatomic,strong)NSMutableArray * ImageArr;
@property(nonatomic,strong)NSMutableArray * detailArr;
@property(nonatomic,strong)NSMutableArray * timeArr;
@property(nonatomic,strong)NSMutableArray * kpIDArr;
@property(nonatomic,strong)UIView * backView;

@end

@implementation followViewController
-(void)loadData{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"加载中.." animated:YES];
    _dataArray=[NSMutableArray new];
    _fromArr=[NSMutableArray new];
    _titleArr=[NSMutableArray new];
    _ImageArr=[NSMutableArray new];
    _detailArr=[NSMutableArray new];
    _timeArr=[NSMutableArray new];
    _kpIDArr=[NSMutableArray new];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
   NSString * url=[NSString stringWithFormat:@"%@/BagServer/focusListFHonor.mob?token=%@&pageNumber=1",URLDOMAIN,[user objectForKey:@"token"]];
 
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud dismiss:YES];
        NSArray * array=(NSArray*)responseObject;
        
        NSLog(@"%@",array);
        if (array.count!=0) {
            
       
        
        for (NSDictionary * subDic in array) {
            [_dataArray addObject:subDic];
           
            
        }
            
            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
            [user setObject:array forKey:@"collectionData"];
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStylePlain];
            _tableView.delegate=self;
            _tableView.dataSource=self;
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.view addSubview:_tableView];
            self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                i++;
                [self loadDataWithPage:i];
                [_tableView reloadData];
            }];
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
            
            
                //    UILabel * second=[UILabel alloc]initWithFrame:cg
            
            
            
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
    UIView * View=[self.view viewWithTag:1200];
    [View removeFromSuperview];
    
    View=nil;
    [_backView removeFromSuperview];
    
    _backView=nil;
    
    [self loadData];
    

}
static int i=1;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title=@"我的关注";
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.tabBarController.tabBar.hidden=YES;
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
   
     [_tableView reloadData];
    
}
-(void)loadDataWithPage:(int)page{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/focusListFHonor.mob?token=%@&pageNumber=%d",URLDOMAIN,[user objectForKey:@"token"],page];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * array=(NSArray*)responseObject;
        if (array.count!=0) {
            
            
            
            for (NSDictionary * subDic in array) {
               
                
                
                [_dataArray addObject:subDic];
             
                
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }else{
        
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
        }
        
        
        
        
    
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
    


}
-(void)Back:(UIBarButtonItem*)button{
    
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString * cate=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"catagoryName"]];
    
    
    
    if ([cate isEqualToString:@"微课"]) {
        OneImageTableViewCell * cell=[OneImageTableViewCell cellWithTableView:tableView];
        
        
        NSString *str = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
        cell.DetailLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"summary"]];
        [cell.headImage sd_setImageWithURL:_dataArray[indexPath.row][@"kpIcon"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        cell.categaryLabel.text=[NSString stringWithFormat:@"微课-[%@]",_dataArray[indexPath.row][@"node_name"]];
        
        
        //        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]];
        //        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        cell.categaryLabel.text=@"微课";
        cell.nodeLabel.text=_dataArray[indexPath.row][@"nodeName"];
        cell.flowerImage.hidden=YES;
        cell.commentImage.hidden=YES;
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
        
        return cell;
    }else{
        
        
        LeftImageTableViewCell * cell=[LeftImageTableViewCell cellWithTableView:tableView];
        
        NSString *str = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        
        
        
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
        
        
        cell.DetailLabel.text=_dataArray[indexPath.row][@"summary"];
        
        //        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]];
        //        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        
        cell.flowerImage.hidden=YES;
        cell.commentImage.hidden=YES;
        [cell.OneImage sd_setImageWithURL:_dataArray[indexPath.row][@"kpIcon"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        cell.categaryLabel.hidden=YES;
        cell.categaryLabel.text=_dataArray[indexPath.row][@"catagoryName"];
        
        
        cell.nodeLabel.text=_dataArray[indexPath.row][@"nodeName"];
        
        
        
        
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
        return cell;
        
        
        
        
        
        
        
    }
    
    
    
    return nil;
    

    
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    biaoganViewController * know=[[biaoganViewController alloc]init];
    know.kpId=_dataArray[indexPath.row][@"kpID"];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],_dataArray[indexPath.row][@"kpID"],@"1080"];
    know.webUrl=str;
   
    [self.navigationController pushViewController:know animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

//    self.navigationController.navigationBarHidden=NO;
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
