//
//  IntegralLevelListViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/4/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "IntegralLevelListViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "integralLevelTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface IntegralLevelListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * iconArr;
@property(nonatomic,strong)NSMutableArray * rangeLevelArr;
@property(nonatomic,strong)NSMutableArray * levelValueArr;
@property(nonatomic,strong)NSMutableArray * levelNameArr;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation IntegralLevelListViewController
-(void)loadData{
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getIntegralLevelList.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
   
 
    
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSArray * arr=(NSArray *)responseObject;
        for (NSDictionary * subDic in arr) {
            
            [_iconArr addObject:subDic[@"iconLevel"]];
            [_levelValueArr addObject:subDic[@"levelValue"]];
            [_levelNameArr addObject:subDic[@"levelName"]];
            [_rangeLevelArr addObject:subDic[@"rangeLevel"]];

            
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    


}
- (void)viewDidLoad {
    [super viewDidLoad];
    _iconArr=[NSMutableArray new];
    _rangeLevelArr=[NSMutableArray new];
    _levelNameArr=[NSMutableArray new];
    _levelValueArr=[NSMutableArray new];
    [self loadData];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"积分规则";
    UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    topView.backgroundColor= [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    NSArray * arr=[NSArray arrayWithObjects:@"等级",@"徽章标识",@"等级符号",@"积分标准", nil];
    for (int i=0; i<4; i++) {
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i, 0, self.view.frame.size.width/4,50 )];
        label.text=arr[i];
        label.textAlignment=NSTextAlignmentCenter;
        [topView addSubview:label];
    }
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    [self.view addSubview:topView];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height-114) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}
-(void)Back:(UIBarButtonItem*)button{
    
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _iconArr.count;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    integralLevelTableViewCell * cell=[integralLevelTableViewCell cellWithTableView:tableView];
    [cell.levelIcon sd_setImageWithURL:[NSURL URLWithString:_iconArr[indexPath.row]]];
    cell.levelNum.text=_levelValueArr[indexPath.row];
    cell.levelName.text=_levelNameArr[indexPath.row];
    cell.integralNum.text=_rangeLevelArr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
@end
