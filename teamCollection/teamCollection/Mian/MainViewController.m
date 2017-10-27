//
//  MainViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MainViewController.h"
#import "MessageTableViewCell.h"
#import "MyViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "SetViewController.h"
#import "AllWebViewController.h"
#import "Header1TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "CloudBag1TableViewCell.h"
#import "ShakeViewController.h"
#import "SearchViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,SkipToMyDelegate,CloudBagDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray* ImageUrl;
@property(nonatomic,strong)NSMutableArray * userName;
@property(nonatomic,strong)NSMutableArray * scroLabel;
@property(nonatomic,strong)NSMutableArray * leveLabel;
@property(nonatomic,strong)NSMutableArray * nodeIDArray;
@property(nonatomic,strong)NSString * leve;
@property(nonatomic,strong)NSString * score;
@property(nonatomic,strong)UIView * animitionView;
@property(nonatomic,strong)NSMutableArray * icon;
@property(nonatomic,strong)NSString * icon1;
@property(nonatomic,strong)NSString * icon2;
@property(nonatomic,strong)NSString * icon3;
@property(nonatomic,strong)NSString * icon4;
@property(nonatomic,assign)float  circle;
@property(nonatomic,strong)NSMutableArray * label;
@property(nonatomic,strong)NSString * label1;
@property(nonatomic,strong)NSString * label2;
@property(nonatomic,strong)NSString * label3;
@property(nonatomic,strong)NSString * label4;

@end

@implementation MainViewController
-(void)pushToMessageController:(NSNotification*)noti{
    NSLog(@"%@",noti.userInfo);
    
    if (noti.userInfo) {
        
    
    NSString * category=[NSString stringWithFormat:@"%@",noti.userInfo[@"category"]];
        if ([category isEqualToString:@"1"]) {
            
        }
        if ([category isEqualToString:@"2"]) {
            
        }

        if ([category isEqualToString:@"3"]) {
            
        }
        if ([category isEqualToString:@"4"]) {
            
        }
        if ([category isEqualToString:@"5"]) {
            
        }
        if ([category isEqualToString:@"6"]) {
            
        }
        if ([category isEqualToString:@"7"]) {
            
        }
        if ([category isEqualToString:@"8"]) {
            
        }
        if ([category isEqualToString:@"9"]) {
            
        }
        if ([category isEqualToString:@"10"]) {
            
        }
        if ([category isEqualToString:@"11"]) {
            
        }
        if ([category isEqualToString:@"12"]) {
            
        }
         
    }
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushToMessageController:) name:@"pushMessage" object:nil];
    
     self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    [self addLoadingAnimotion];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,-20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBarHidden=YES;
   
     [self.tableView reloadData];
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        Header1TableViewCell * cell=[Header1TableViewCell cellWithTableView:tableView];
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [cell.headImageView setImageWithURL:[NSURL URLWithString:self.ImageUrl[indexPath.row]] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
        
        [cell.levelImage setImageWithURL:[NSURL URLWithString:self.leve]];
        
        

        cell.nameLabel.text=self.userName[indexPath.row];
        NSString  * score=[NSString stringWithFormat:@"%@",self.scroLabel[indexPath.row]];
        
        float progress=_circle;
        cell.circularView.progress=progress;
        NSLog(@"%f",cell.circularView.progress);
        
        cell.scoreLabel.text=score;
        cell.levelLabel.text=self.leveLabel[indexPath.row];
        return cell;
    }else if(indexPath.section==1){
    
        CloudBag1TableViewCell * cell=[CloudBag1TableViewCell cellWithTableView:tableView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
         [cell.headImage1 setImageWithURL:[NSURL URLWithString:self.icon1] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
         [cell.headImage2 setImageWithURL:[NSURL URLWithString:self.icon2] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
         [cell.headImage3 setImageWithURL:[NSURL URLWithString:self.icon3] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
         [cell.headImage4 setImageWithURL:[NSURL URLWithString:self.icon4] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
        cell.label1.text=_label1;
        cell.label2.text=_label2;
        cell.label3.text=_label3;
        cell.label4.text=_label4;
        
        return cell;
    }else if(indexPath.section==2){
        MessageTableViewCell * cell=[MessageTableViewCell cellWithTableView:tableView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){

    return 400;
    }if (indexPath.section==1) {
        return 200;
    }if (indexPath.section==2) {
        return 200;
    }
    
        return 44;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(void)SkipToMyControllerOnClick:(UIButton *)button
{
    AllWebViewController * all=[[AllWebViewController alloc]init];
    NSUserDefaults * UserDefaults=[NSUserDefaults standardUserDefaults];
    all.nodeIDArray=_nodeIDArray;
    NSLog(@"%ld",(long)button.tag);
    if (button.tag==3) {
        MyViewController * my=[[MyViewController alloc]init];
        [self.navigationController pushViewController:my animated:YES];
    }if (button.tag==10) {

        NSString * str=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?platform=android&companyID=%@&userID=%@&nodeID=%@",URLDOMAIN,[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"userID"],_nodeIDArray[0]];
        all.webUrl=str;
        
        [self.navigationController pushViewController:all animated:YES];
    }
    if (button.tag==11) {
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/exampleRank.wc?platform=android&userID=%@&companyID=%@",URLDOMAIN,[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"]];
        all.webUrl=str;
   [self.navigationController pushViewController:all animated:YES];

    }if (button.tag==12) {
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/toCircleListByA.wc?token=%@",URLDOMAIN,[UserDefaults objectForKey:@"token"]];
        all.webUrl=str;
        [self.navigationController pushViewController:all animated:YES];
    }
    if (button.tag==20) {
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/toCardListByA.wc?token=%@",URLDOMAIN,[UserDefaults objectForKey:@"token"]];
        all.webUrl=str;
        [self.navigationController pushViewController:all animated:YES];
    }
    if(button.tag==23){
        ShakeViewController * shake=[[ShakeViewController alloc]init];
    
        [self.navigationController pushViewController:shake animated:YES];
        
        
    }
    if (button.tag==1) {
        SearchViewController * search=[[SearchViewController alloc]init];
        [self.navigationController pushViewController:search animated:YES];
    }
}
-(void)SkipToNextControllerOnClick:(UIButton *)button
{
    
    

    AllWebViewController * all=[[AllWebViewController alloc]init];
    NSUserDefaults * UserDefaults=[NSUserDefaults standardUserDefaults];
    all.nodeIDArray=_nodeIDArray;
    NSLog(@"%ld",(long)button.tag);
    if(button.tag==0){
        
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?platform=android&companyID=%@&userID=%@&nodeID=%@",URLDOMAIN,[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"userID"],_nodeIDArray[button.tag]];
        all.webUrl=str;
        
        [self.navigationController pushViewController:all animated:YES];
        
        
    
    }if (button.tag==1) {
        
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?platform=android&companyID=%@&userID=%@&nodeID=%@",URLDOMAIN,[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"userID"],_nodeIDArray[button.tag]];
        all.webUrl=str;
        
        [self.navigationController pushViewController:all animated:YES];
    }if (button.tag==2) {
        
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?platform=android&companyID=%@&userID=%@&nodeID=%@",URLDOMAIN,[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"userID"],_nodeIDArray[button.tag]];
        all.webUrl=str;
        
        [self.navigationController pushViewController:all animated:YES];
    }if (button.tag==3) {
        
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?platform=android&companyID=%@&userID=%@&nodeID=%@",URLDOMAIN,[UserDefaults objectForKey:@"companyID"],[UserDefaults objectForKey:@"userID"],_nodeIDArray[button.tag]];
        all.webUrl=str;
        
        [self.navigationController pushViewController:all animated:YES];
    }
    
  
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/userHonorInfo.mob",URLDOMAIN];
    NSDictionary * parameters=@{@"token":self.token};
 
    _nodeIDArray=[NSMutableArray new];
    _label=[NSMutableArray new];
    _icon=[NSMutableArray new];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        
        if (dic) {
            
       
        
        
        self.ImageUrl =[NSMutableArray arrayWithObject:dic[@"headIconUrl"]];
        self.userName=[NSMutableArray arrayWithObject:dic[@"userName"]];
        
        
        self.scroLabel =[NSMutableArray arrayWithObject:dic[@"totalIntegral"]];
        self.leveLabel=[NSMutableArray arrayWithObject:dic[@"levelName"]];
        
        self.leve=dic[@"levelIcon"];
        float cur=[dic[@"curLevelNum"] floatValue];
        float totle=[dic[@"levelTotalNum"] floatValue];
            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
            [user setObject:dic[@"totalIntegral"] forKey:@"totalIntegral"];
            [user setObject:dic[@"totalRanking"] forKey:@"totalRanking"];
            [user setObject:dic[@"userName"] forKey:@"userName"];
        
        _circle=cur/totle;
      
        [self.tableView reloadData];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    NSString * URL=[NSString stringWithFormat:@"%@:PORT/BagServer/getStudyObjectList.mob",URLDOMAIN];
    
    [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (dic) {
            
        
        
       
        
      
        for (NSDictionary * Dic in dic) {
            [_nodeIDArray addObject:Dic[@"id"]];
            [_icon addObject:Dic[@"iconURL"]];
            [_label addObject:Dic[@"designation"]];
        }
        _icon1 =_icon[0];
        _icon2 =_icon[1];
        _icon3 =_icon[2];
        _icon4 =_icon[3];
        _label1=_label[0];
        _label2=_label[1];
        _label3=_label[2];
        _label4=_label[3];
      
        [self.tableView reloadData];
        [self.animitionView removeFromSuperview];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.animitionView removeFromSuperview];
    }];

    
    
}
-(void)addLoadingAnimotion{
    
    _animitionView =[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2-20, 40, 40)];
    
    UIImageView* mainImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    NSMutableArray * Image=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"loading0001.png"],[UIImage imageNamed:@"loading0002.png"],[UIImage imageNamed:@"loading0003.png"],[UIImage imageNamed:@"loading0004.png"],[UIImage imageNamed:@"loading0005.png"],[UIImage imageNamed:@"loading0006.png"],[UIImage imageNamed:@"loading0007.png"],[UIImage imageNamed:@"loading0008.png"],[UIImage imageNamed:@"loading0009.png"],[UIImage imageNamed:@"loading00010.png"],[UIImage imageNamed:@"loading00011.png"],[UIImage imageNamed:@"loading00012.png"], nil];
    [mainImageView setAnimationImages:Image];
    [mainImageView setAnimationDuration:3];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    [_animitionView addSubview:mainImageView];
    [self.view addSubview:_animitionView];
    
}


@end
