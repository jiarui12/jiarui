//
//  CollectionViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "CollectionViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "WKProgressHUD.h"
#import "followTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "nonetConViewController.h"
#import "biaoganViewController.h"
#import "LeftImageTableViewCell.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "OneImageTableViewCell.h"
#import "JRSegmentViewController.h"
#import "introduceKnowledgeViewController.h"
#import "NewCommentListTableViewController.h"
#import "AboutKnowledgeTableViewController.h"
#import "TheVideoClassViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface CollectionViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIView * backView;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"我的收藏";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArray=[NSMutableArray new];
    
    [self loadData];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    NSString * cate=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"catagoryName"]];
    
    
    
    
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor clearColor];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
    
    AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
    
    
    NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
    
    a.kpId=_dataArray[indexPath.row][@"kpID"];
    b.kpID=_dataArray[indexPath.row][@"kpID"];
    
    //        a.kpId=@"4751";
    c.kpID=_dataArray[indexPath.row][@"kpID"];
    
    if (token.length<8) {
        [vc setViewControllers:@[a]];
        
    }else{
        [vc setViewControllers:@[a,b,c]];
        
    }
    
    [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
    vc.kpID=_dataArray[indexPath.row][@"kpID"];
    vc.kTitle=_dataArray[indexPath.row][@"title"];
    vc.kContent=_dataArray[indexPath.row][@"summary"];
    vc.kIconUrl=_dataArray[indexPath.row][@"iconURL"];
    vc.hidesBottomBarWhenPushed=YES;
    if ([cate isEqualToString:@"微课"]) {
        
        TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
        
        video.kpId=_dataArray[indexPath.row][@"kpID"];
        
        video.kTitle=_dataArray[indexPath.row][@"title"];
        video.kContent=_dataArray[indexPath.row][@"summary"];
        video.kIconUrl=_dataArray[indexPath.row][@"iconURL"];
        video.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:video animated:YES];
        
    }else{
        
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
    
    
    


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    NSString * cate=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"catagoryName"]];
    //    NSString * imag=[NSString stringWithFormat:@"%@",_subArr[indexPath.row][@"img_content"]];
    
    //    NSArray * arr=[imag componentsSeparatedByString:@","];
    
    
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
        [cell.headImage sd_setImageWithURL:_dataArray[indexPath.row][@"iconURL"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
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
        [cell.OneImage sd_setImageWithURL:_dataArray[indexPath.row][@"iconURL"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        
        cell.categaryLabel.text=_dataArray[indexPath.row][@"catagoryName"];
        
        
        cell.nodeLabel.text=_dataArray[indexPath.row][@"nodeName"];
        
        
        
        
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
        return cell;
        
        
        
        
        
        
        
    }
    
    
    
    return nil;
    
    

    
//    
//    followTableViewCell * cell=[followTableViewCell cellWithTableView:tableView];
//    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row][@"iconURL"]]];
//    cell.timeLabel.text=[[_dataArray[indexPath.row][@"publishTime"] componentsSeparatedByString:@" "]objectAtIndex:0];
//    cell.titleLabel.text=_dataArray[indexPath.row][@"title"];
//    cell.detailLabel.text=_dataArray[indexPath.row][@"summary"];
//    
//    if (_dataArray[indexPath.row][@"fromFocus"]) {
//        cell.fromLabel.text=[NSString stringWithFormat:@"来自于关注人:%@",_dataArray[indexPath.row][@"fromFocus"]];
//    }
//    if (_dataArray[indexPath.row][@"fromSearch"]&&![_dataArray[indexPath.row][@"fromSearch"] isEqualToString:@""]) {
//         cell.fromLabel.text=[NSString stringWithFormat:@"来自于搜索:%@",_dataArray[indexPath.row][@"fromSearch"]];
//    }
//    
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    return cell;
    

}
-(void)Back:(UIBarButtonItem*)button{
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

   
 return 125 *WIDTH/375;
}
-(void)viewWillAppear:(BOOL)animated{
   
    
    self.navBarBgAlpha=@"1.0";

}
-(void)loadData{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"加载中.." animated:YES];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSDictionary * parameters=@{@"token":[user objectForKey:@"token"]};
    
    
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getMyCollectionList.mob",URLDOMAIN];
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud dismiss:YES];
        
        
        if ([responseObject count]!=0) {
            _dataArray=responseObject;
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStylePlain];
            
            _tableView.delegate=self;
            _tableView.dataSource=self;
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.view addSubview:_tableView];
            
            [_tableView reloadData];
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
            
            [chongxin addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
            
            
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
        
        [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_backView addSubview:chongxin];
        
        
        UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320, 64+HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
        big.image=[UIImage imageNamed:@"image_net"];
        
        
        [_backView addSubview:big];
        
        
        [self.view addSubview:_backView];
        
    }];
}
-(void)shuaxinle:(UIButton *)button{
    [_backView removeFromSuperview];
    
    _backView =nil;
    [self loadData];
}
-(void)nonetCon:(UIButton *)button{
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    [self.navigationController pushViewController:no animated:YES];
    

}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}
-(void)shuaxin:(UIButton*)button{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
