//
//  SearchDetailViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/4/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "followTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
#import "biaoganViewController.h"
#import "LeftImageTableViewCell.h"
#import "OneImageTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface SearchDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,strong)NSMutableArray * detailArray;
@property(nonatomic,strong)NSMutableArray * iconArray;
@property(nonatomic,strong)NSMutableArray * timeArray;

@property(nonatomic,strong)NSMutableArray * kpIDArray;
@end

@implementation SearchDetailViewController
-(void)loadData{
    _dataArray=self.data[@"list"];
    NSLog(@"%@",_dataArray);
    for (NSDictionary * dic in _dataArray) {
        [_timeArray addObject:dic[@"releaseTime"]];
        [_titleArray addObject:dic[@"title"]];
        [_detailArray addObject:dic[@"summary"]];
        if ([dic[@"iconUrl"] length]!=0) {
        [_iconArray addObject:dic[@"iconUrl"]];
        }
        

        [_kpIDArray addObject:dic[@"kpID"]];
    }
    
    [_tableView reloadData];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray new];
    _timeArray=[NSMutableArray new];
    _titleArray=[NSMutableArray new];
    _iconArray=[NSMutableArray new];
    _detailArray=[NSMutableArray new];
    _kpIDArray=[NSMutableArray new];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@",self.String];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self loadData];
    
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
     self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
-(void)Back:(UIBarButtonItem *)bitton{

    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
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
        [cell.headImage sd_setImageWithURL:_dataArray[indexPath.row][@"iconUrl"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        cell.categaryLabel.text=[NSString stringWithFormat:@"微课-[%@]",_dataArray[indexPath.row][@"node_name"]];
        
        
        //        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]];
        //        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        cell.categaryLabel.text=@"微课";
        cell.nodeLabel.text=_dataArray[indexPath.row][@"nodeName"];
        cell.flowerImage.hidden=YES;
        cell.commentImage.hidden=YES;
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
     
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
        [cell.OneImage sd_setImageWithURL:_dataArray[indexPath.row][@"iconUrl"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        
        cell.categaryLabel.text=_dataArray[indexPath.row][@"catagoryName"];
        
        
        cell.nodeLabel.text=_dataArray[indexPath.row][@"nodeName"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
  
        return cell;
        
    }
    
    
    
    return nil;
    

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    biaoganViewController * know=[[biaoganViewController alloc]init];
    know.kpId=_kpIDArray[indexPath.row];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],_kpIDArray[indexPath.row],@"1080"];
    know.webUrl=str;
    
    [self.navigationController pushViewController:know animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
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
