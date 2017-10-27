//
//  newFriendListViewController.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/2.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "newFriendListViewController.h"
#import "friendListTableViewCell.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "UIImageView+WebCache.h"
#import "biaoganViewController.h"
@interface newFriendListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tabView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation newFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title=@"新的关注";
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tabView.delegate=self;
    _tabView.dataSource=self;
    [self.tabView setSeparatorColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0]];
     self.tabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tabView];
    
}
-(void)Back:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    friendListTableViewCell * cell=[friendListTableViewCell cellWithTableView:tableView];
    [cell.gaunzhu addTarget:self action:@selector(addGuanzhu:) forControlEvents:UIControlEventTouchUpInside];
    cell.gaunzhu.tag=indexPath.row;
    NSString * flag=[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"flag"]];
    
    if ([flag isEqualToString:@"1"]) {
        [cell.gaunzhu setImage:[UIImage imageNamed:@"icon_yiguanzhu_defult@2x"] forState:UIControlStateNormal];
        [cell.gaunzhu setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
        [cell.gaunzhu setTitle:@"已关注" forState:UIControlStateNormal];
    }
    [cell.headImageView  sd_setImageWithURL:[NSURL URLWithString:_dataArr[indexPath.row][@"head_portrait"]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.nameLabel.text=_dataArr[indexPath.row][@"username"];
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}

-(void)addGuanzhu:(UIButton*)button{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    if ([button.titleLabel.text isEqualToString:@"加关注"]) {
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/focus_user.mob?token=%@&focusUserID=%@",URLDOMAIN,[user objectForKey:@"token"],_dataArr[button.tag][@"user_id"]];
        
        NSLog(@"%@",url);
            
            
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"%@",responseObject);
                
                
                [button setImage:[UIImage imageNamed:@"icon_yiguanzhu_defult@2x"] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
                [button setTitle:@"已关注" forState:UIControlStateNormal];
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];

        
        
        
        
        
     
    }else{
    
        biaoganViewController * biaogan=[[biaoganViewController alloc]init];
        biaogan.webUrl=[NSString stringWithFormat:@"http://192.168.1.186:8080/BagServer/contact/user_detail.html?userId=%@&token=%@&companyID=%@",_dataArr[button.tag][@"user_id"],[user objectForKey:@"token"],[user objectForKey:@"companyID"]];
        [self.navigationController pushViewController:biaogan animated:YES];
    
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.view.frame.size.width*57/375;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];

    
    biaoganViewController * biaogan=[[biaoganViewController alloc]init];
    
    biaogan.webUrl=[NSString stringWithFormat:@"http://192.168.1.186:8080/BagServer/contact/user_detail.html?userId=%@&token=%@&companyID=%@",_dataArr[indexPath.row][@"user_id"],[user objectForKey:@"token"],[user objectForKey:@"companyID"]];
    [self.navigationController pushViewController:biaogan animated:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    
    
    _dataArr=[NSMutableArray new];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
   NSString * token = [user objectForKey:@"token"];
    
    
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/newFocusUser.mob?debug=yes&token=%@",URLDOMAIN,token];
    
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        
        
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",Dic);
        for (NSDictionary * subDic in Dic[@"successList"]) {
            [_dataArr addObject:subDic];
            
        }
        [self.tabView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    


}
@end
