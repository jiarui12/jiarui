//
//  CommentViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/2/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "CommentViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "CommentListTableViewCell.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    NSString * user=[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    NSString * company=[[NSUserDefaults standardUserDefaults]objectForKey:@"companyID"];
    NSString * url=[NSString stringWithFormat:@"%@/WeChat/myComment.wc?state=%@S%@",URLDOMAIN,user,company];;
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:_webView];
    _dataArray=[NSMutableArray new];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStylePlain];
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    
//    [self.view addSubview:_tableView];
    
    self.navigationItem.title=@"评论";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    
    UIButton * Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame=CGRectMake(0, 0, 30, 30);
    [Btn setBackgroundImage:[UIImage imageNamed:@"kp_comment_menu_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:Btn];
    [Btn addTarget:self action:@selector(toComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];
    
    

    
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    
//    NSString * token=[user objectForKey:@"token"];
//    if (token.length>5) {
//        
//        
//        NSLog(@"%@",[user objectForKey:@"kpID"]);
//        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
//        NSString * url=[NSString stringWithFormat:@"%@/BagServer/kpDetail4New.mob",URLDOMAIN];
//        NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
//        
//        
//        
//        NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":self.kpId,@"adapterSize":@"1080"};
//        [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
////            NSDictionary * Dic=dic[@"kpData"];
//            
//            
//            NSLog(@"111111111%@",dic);
//            _dataArray=dic[@"pList"];
//            
//            
//            
//            
//            
//     
//            
//            
//            [self.tableView reloadData];
//          
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//        }];
//    }
//    
//    
    
    
}
-(void)Back:(UIBarButtonItem*)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toComment:(UIBarButtonItem*)button{
//   AllWebViewController  * my=[[AllWebViewController alloc]init];
//   
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    NSString * webUrl=[NSString stringWithFormat:@"%@/WeChat/toComment.wc?platform=android&userID=%@&companyID=%@&kpID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],[user objectForKey:@"kpID"]];
//    my.webUrl=webUrl;
//    my.Title=@"我的评论";
//
//    [self.navigationController pushViewController:my animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:10/255.0 green:125/255.0 blue:245/255.0 alpha:1.0];
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
    
//    image.hidden=YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommentListTableViewCell * cell=[CommentListTableViewCell cellWithTableView:tableView];
    
    return cell;
    
}
@end
