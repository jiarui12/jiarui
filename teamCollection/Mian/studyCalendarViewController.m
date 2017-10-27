//
//  studyCalendarViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/17.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "studyCalendarViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "biaoganViewController.h"
@interface studyCalendarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSDate * beforeDate;
@property(nonatomic,strong)NSDate * afterDate;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableDictionary * allDic;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation studyCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray new];
    _allDic=[NSMutableDictionary new];
    self.navigationItem.title=@"学习日历";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
    self.tabBarController.tabBar.hidden=YES;
    UIButton * topButton=[UIButton buttonWithType:UIButtonTypeSystem];
    topButton.frame=CGRectMake(0, 64, self.view.frame.size.width, 40);
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSTimeInterval intrrval=60*60*24;
   _beforeDate=[senddate initWithTimeIntervalSinceNow:-intrrval];
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSString *  locationString=[dateformatter stringFromDate:_beforeDate];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    

    
    NSString * title=[NSString stringWithFormat:@"触摸可查看%@前的计划",locationString];
    [topButton setTitle:title forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(beforeDate:) forControlEvents:UIControlEventTouchUpInside];
    topButton.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:topButton];
    
    
    
    
    
    
    UIButton * bottomButton=[UIButton buttonWithType:UIButtonTypeSystem];
    bottomButton.frame=CGRectMake(0, 104, self.view.frame.size.width, 40);
    _afterDate=[senddate initWithTimeIntervalSinceNow:+3*intrrval];
    NSString * afterString=[dateformatter stringFromDate:_afterDate];
    
    NSString * Title=[NSString stringWithFormat:@"触摸可查看%@后的计划",afterString];
    [bottomButton setTitle:Title forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(afterDate:) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bottomButton];

    
    AFHTTPSessionManager * maneger=[AFHTTPSessionManager manager];
    maneger.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getStudyPlanList.mob",URLDOMAIN];
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * beforeDate=[dateFormatter stringFromDate:_beforeDate];
    NSString * afterDate=[dateFormatter stringFromDate:_afterDate];
    NSDictionary * para=@{@"token":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"],@"beforeDate":beforeDate,@"afterDate":afterDate,@"flag":@"1"};
    
    
    
    [maneger GET:url parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _allDic=(NSMutableDictionary *)responseObject;
        _dataArray=_allDic[@"planDateArr"];
        
        
        NSLog(@"%@",_allDic);
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStyleGrouped];
    
    _tableView.tableHeaderView=topButton;
    _tableView.tableFooterView=bottomButton;
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
    
    
    
}
 static int i=1;
-(void)beforeDate:(UIButton *)button{
    
   
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
   
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    NSTimeInterval intrrval=i*60*60*24*30;
    _beforeDate=[_beforeDate initWithTimeIntervalSinceNow:-intrrval];
    NSString * beforeString=[dateformatter stringFromDate:_beforeDate];
    
    NSString * str=[NSString stringWithFormat:@"触摸可查看%@前的计划",beforeString];
   
    
    [button setTitle:str forState:UIControlStateNormal];
    
    AFHTTPSessionManager * maneger=[AFHTTPSessionManager manager];
    maneger.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getStudyPlanList.mob",URLDOMAIN];
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * beforeDate=[dateFormatter stringFromDate:_beforeDate];
    NSString * afterDate=[dateFormatter stringFromDate:_afterDate];
    NSDictionary * para=@{@"token":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"],@"beforeDate":beforeDate,@"afterDate":afterDate,@"flag":@"2"};
    
    
   
   [maneger GET:url parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       _allDic=(NSMutableDictionary *)responseObject;
       
       _dataArray=_allDic[@"planDateArr"];
       [self.tableView reloadData];
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error);
   }];
    i ++;
}
static int j=1;
-(void)afterDate:(UIButton * )button{

    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    NSTimeInterval intrrval=j*60*60*24*30;
    _afterDate=[_afterDate initWithTimeIntervalSinceNow:intrrval];
    NSString * beforeString=[dateformatter stringFromDate:_afterDate];
    
    NSString * str=[NSString stringWithFormat:@"触摸可查看%@前的计划",beforeString];
    
    
    [button setTitle:str forState:UIControlStateNormal];
    
    
    AFHTTPSessionManager * maneger=[AFHTTPSessionManager manager];
    maneger.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getStudyPlanList.mob",URLDOMAIN];
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * beforeDate=[dateFormatter stringFromDate:_beforeDate];
    NSString * afterDate=[dateFormatter stringFromDate:_afterDate];
    NSDictionary * para=@{@"token":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"],@"beforeDate":beforeDate,@"afterDate":afterDate,@"flag":@"3"};
    
    
    
    [maneger GET:url parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        _allDic=(NSMutableDictionary *)responseObject;
        _dataArray=_allDic[@"planDateArr"];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
    
    j++;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    j=1;
    i=1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allDic[_dataArray[section]]count];
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * iden=@"iden";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    NSArray * arr=_allDic[_dataArray[indexPath.section]];
    NSDictionary * dic=arr[indexPath.row];
    cell.textLabel.text=dic[@"title"];
    cell.detailTextLabel.text=dic[@"planTime"];
    
    return cell;
    

}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];
   
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
 
    return _dataArray[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arr=_allDic[_dataArray[indexPath.section]];
    NSDictionary * dic=arr[indexPath.row];
    
    NSString * kpid=[NSString stringWithFormat:@"%@",dic[@"kpID"]];
   
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],kpid,@"1080"];
    
    

    
    biaoganViewController * detail=[[biaoganViewController alloc]init];
    
    detail.webUrl=str;
    detail.kpId=kpid;
    
    
    
    [self.navigationController pushViewController:detail animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=NO;
    self.navBarBgAlpha=@"1.0";

}

@end
