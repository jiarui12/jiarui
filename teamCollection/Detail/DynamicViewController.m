//
//  DynamicViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/4/11.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "DynamicViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "DynamicTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"
#import "DynamicDetailViewController.h"
@interface DynamicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * chat;
@property(nonatomic,strong)UIImageView * bacImage;
@property(nonatomic,strong)NSString * companyName;
@property(nonatomic,strong)NSString * orgName;
@property(nonatomic,strong)UIButton * likeButton;
@end

@implementation DynamicViewController
-(void)loadData{
    
    
    _chat=[UIButton buttonWithType:UIButtonTypeSystem];
    _chat.frame=CGRectMake(20,450, self.view.frame.size.width-40, 40);
    [_chat setTitle:@"开始聊天" forState:UIControlStateNormal];
    [_chat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _chat.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [_chat addTarget:self action:@selector(chatButton:) forControlEvents:UIControlEventTouchUpInside];
   
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getUserInfoByExample.mob?token=%@&infoUserID=%@",URLDOMAIN,[user objectForKey:@"token"],self.userID];
    
    

    
    
     [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

         NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
         [user setObject:responseObject[@"userName"] forKey:@"Cname"];
         
         [user setObject:responseObject forKey:@"responseObject"];
         
         [_headImageView sd_setImageWithURL:responseObject[@"headIconUrl"] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
         _nameLabel.text=responseObject[@"userName"];
         [_bacImage sd_setImageWithURL:responseObject[@"userThemeURL"] placeholderImage:[UIImage imageNamed:@"myimage_background@2x"]];
          [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
     }];
    NSString * URL=[NSString stringWithFormat:@"%@/BagServer/getModelUserInfo.mob?token=%@&infoUserID=%@",URLDOMAIN,[user objectForKey:@"token"],@"1400"];
   [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       NSLog(@"%@",responseObject);
       NSString * isLike=[NSString stringWithFormat:@"%@",responseObject[@"isLike"]];
       if ([isLike isEqualToString:@"1"]) {
           
           [_likeButton setTitle:@"关注TA" forState:UIControlStateNormal];
           
       }else{
       [_likeButton setTitle:@"取消关注" forState:UIControlStateNormal];

           
          
           
           
            [self.tableView addSubview:_chat];
       }
       
       _companyName=[NSString stringWithFormat:@"%@",responseObject[@"companyName"]];
       _orgName=[NSString stringWithFormat:@"%@",responseObject[@"organName"]];
       [self.tableView reloadData];
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error);
   }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title=@"个人中心";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    _titleArray=[NSArray arrayWithObjects:@"企业名称",@"企业部门",@"所属岗位", nil];
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
  
    _bacImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _bacImage.image=[UIImage imageNamed:@"myimage_background@2x"];
   
    [view addSubview:_bacImage];
    
    
    
    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,100,90, 90)];
    _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;;
    _headImageView.clipsToBounds=YES;
    _headImageView.image=[UIImage imageNamed:@"man_default_icon"];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 120, 80, 20)];
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.font=[UIFont systemFontOfSize:18];
    
   _likeButton=[UIButton buttonWithType:UIButtonTypeSystem];
    _likeButton.frame=CGRectMake(self.view.frame.size.width-90, 120, 80, 30);
    _likeButton.layer.cornerRadius=10.0;
    _likeButton.backgroundColor=[UIColor orangeColor];
    [_likeButton setTitle:@"关注TA" forState:UIControlStateNormal];
    [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_likeButton addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:_likeButton];
    
    
    [view addSubview:_nameLabel];
    
    
    [view addSubview:_headImageView];
    
    self.tableView.tableHeaderView=view;
    
    
}
-(void)Back:(UIBarButtonItem*)button{

    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicTableViewCell * cell=[DynamicTableViewCell cellWithTableView:tableView];
    
    if (indexPath.section==0) {
        cell.TitleLabel.text=@"最新动态";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.DetailLabel.text=[NSString stringWithFormat:@"%@的动态",[[NSUserDefaults standardUserDefaults]objectForKey:@"Cname"]];
        
    }
    if (indexPath.section==1) {
        cell.TitleLabel.text=_titleArray[indexPath.row];
        if (indexPath.row==0) {
            cell.DetailLabel.text=_companyName;
        }else if (indexPath.row==1){
            cell.DetailLabel.text=_orgName;
        
        }
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)attention:(UIButton *)button{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/focus_user.mob?token=%@&focusUserID=%@",URLDOMAIN,[user objectForKey:@"token"],self.userID];
   
    if ([button.titleLabel.text isEqualToString:@"关注TA"]) {
      
        
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [button setTitle:@"取消关注" forState:UIControlStateNormal];
        _chat=[UIButton buttonWithType:UIButtonTypeSystem];
        _chat.frame=CGRectMake(20,450, self.view.frame.size.width-40, 40);
        [_chat setTitle:@"开始聊天" forState:UIControlStateNormal];
        [_chat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chat.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
        [_chat addTarget:self action:@selector(chatButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:_chat];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
        
       
        
    }else{
        
    
        
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/removeContact.mob?removeUserID=%d&token=%@",URLDOMAIN,[self.userID intValue],[user objectForKey:@"token"]];
        
        
        [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [button setTitle:@"关注TA" forState:UIControlStateNormal];
             [_chat removeFromSuperview];
        }];
        
        
        
        
       
    
    }
        
    
    

}
-(void)chatButton:(UIButton *)button{
  
    ChatViewController * chat=[[ChatViewController alloc]init];
    chat.name=[[NSUserDefaults standardUserDefaults] objectForKey:@"Cname"];
    chat.friendJid=self.userID;
    [self.navigationController pushViewController:chat animated:YES];
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        DynamicDetailViewController * detail=[[DynamicDetailViewController alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
        
    }

}
-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=YES;
    

}
-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=NO;

}
@end
