//
//  newCepingViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/26.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "newCepingViewController.h"
#import "AFNetworking.h"
#import "newCepingTableViewCell.h"
#import "PrefixHeader.pch"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface newCepingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation newCepingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.frame=CGRectMake(WIDTH/2-22, WIDTH/3, 44, 44);
    
    [self.view addSubview:self.activityIndicatorView];
    
    
    
    [self.activityIndicatorView startAnimating];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getKnowledgeTestPaper.mob?token=%@&knowledge_id=%@&currPage=1&pageSize=10",URLDOMAIN,token,@""];
    
    NSLog(@"%@",url);
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.activityIndicatorView stopAnimating];

        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"list"] count]>0) {
            _dataArray =[NSMutableArray new];
            for (NSDictionary * dic in responseObject[@"list"]) {
                [_dataArray addObject:dic];
            }
            
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT) style:UITableViewStylePlain];
            _tableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
            _tableView.delegate=self;
            _tableView.dataSource=self;
            _tableView.separatorStyle = NO;
            [self.view addSubview:_tableView];
            
            [self.tableView reloadData];
            
        }else{
        
            
            
            UIView * v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            v.backgroundColor=[UIColor whiteColor];
            v.tag=123;
            [self.view addSubview:v];
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, HEIGHT*60/568, WIDTH * 90/320, HEIGHT* 170/568)];
            imageView.image=[UIImage imageNamed:@"image_error"];
            imageView.backgroundColor=[UIColor redColor];
            
            [v addSubview:imageView];
            
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*250/568, WIDTH, 20)];
            
            label.text=@"空空如也...";
            label.font=[UIFont systemFontOfSize:19];
            label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            
            label.textAlignment=NSTextAlignmentCenter;
            
            [v addSubview:label];
            
            [self.view addSubview:v];

        
        
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.activityIndicatorView stopAnimating];
        
        
        UIView * v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        v.backgroundColor=[UIColor whiteColor];
        v.tag=123;
        [self.view addSubview:v];
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, HEIGHT*60/568, WIDTH * 90/320, HEIGHT* 170/568)];
        imageView.image=[UIImage imageNamed:@"image_error"];
        imageView.backgroundColor=[UIColor redColor];
        
        [v addSubview:imageView];
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*250/568, WIDTH, 20)];
        
        label.text=@"空空如也...";
        label.font=[UIFont systemFontOfSize:19];
        label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label.textAlignment=NSTextAlignmentCenter;
        
        [v addSubview:label];
        
        [self.view addSubview:v];


    }];






}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    newCepingTableViewCell * cell=[newCepingTableViewCell cellWithTableView:tableView];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@", _dataArray[indexPath.row][@"tp_title"]];
    cell.timeLabel.text=[NSString stringWithFormat:@"测试标准  共%@道题，%@分钟",_dataArray[indexPath.row][@"question_count"],_dataArray[indexPath.row][@"test_time"]];
    cell.zongfenLabel.text=[NSString stringWithFormat:@"测试总分   %@分",_dataArray[indexPath.row][@"totalScore"]];
    cell.jiezhiLabel.text=[NSString stringWithFormat:@"提交截止  %@",_dataArray[indexPath.row][@"over_time"]];
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return WIDTH * 310/375;

}
- (UIActivityIndicatorView *)activityIndicatorView {
    
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorView.frame=CGRectMake(WIDTH/2-22, WIDTH/2-22, 44, 44);
    }
    return _activityIndicatorView;
}
@end
