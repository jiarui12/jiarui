//
//  KnowledgeDetailViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "KnowledgeDetailViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "KnowDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LDZMoviePlayerController.h"
@interface KnowledgeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,KnowledgeDetailDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSString * Width;
@property(nonatomic,strong)NSMutableDictionary * videoSource;


@property(nonatomic,strong)UIWebView * webView;

@end


@implementation KnowledgeDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getVideoUrl];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"详情";
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIButton * collectionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    collectionButton.frame=CGRectMake(0, 0, 30, 30);
    [collectionButton setBackgroundImage:[UIImage imageNamed:@"ic_bookmark_outline_white_48dp_star"] forState:UIControlStateNormal];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:collectionButton];
    [collectionButton addTarget:self action:@selector(Back:) forControlEvents:UIControlEventValueChanged];
    UIButton * shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(0, 0, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"abc_ic_menu_share_holo_dark"] forState:UIControlStateNormal];
    UIBarButtonItem * right1=[[UIBarButtonItem alloc]initWithCustomView:shareButton];
    [collectionButton addTarget:self action:@selector(Back:) forControlEvents:UIControlEventValueChanged];

    [self.navigationItem setRightBarButtonItems:@[right,right1]];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    NSURL * url=[NSURL URLWithString:self.webUrl];
    self.webView.delegate=self;
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    if ([self.fenlei isEqualToString:@"微课"]) {

         [self.view addSubview:_tableView];
    }else{
        
    [self.view addSubview:self.webView];
        
    }
   
}
-(void)getVideoUrl{
   
    self.videoSource=[NSMutableDictionary new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user objectForKey:@"kpID"]);
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/kpDetail4New.mob",URLDOMAIN];
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    CGFloat width =[UIScreen mainScreen].applicationFrame.size.width;
    if (width<400) {
        _Width=@"720";
    }if (width>400) {
        _Width=@"1080";
    }
    
    
    NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":[user objectForKey:@"kpID"],@"adapterSize":_Width};
    
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        
        NSDictionary * Dic=dic[@"kpData"];
        
        self.videoSource=Dic[@"videoSour"];
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    

    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowDetailTableViewCell * cell=[KnowDetailTableViewCell cellWithTableView:tableView];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    return cell;
}
-(void)Back:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    
    return 520;
   
}
-(void)PresentVideoPlayerController:(UIButton *)button
{
    LDZMoviePlayerController * movie=[[LDZMoviePlayerController alloc]init];
   
    NSString *urlString = self.videoSource[@"HDTV"];
    
    
    
    NSURL *URL = [NSURL URLWithString: urlString];
    movie.movieURL = URL;
    [self presentViewController:movie animated:YES completion:^{
        
    }];
    
    
}
@end
