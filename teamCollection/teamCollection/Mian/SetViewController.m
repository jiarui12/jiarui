//
//  SetViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/13.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SetViewController.h"
#import "SettingHeadTableViewCell.h"
#import "OtherTableViewCell.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * Image1Array;
@property(nonatomic,strong)NSMutableArray * title1Array;
@property(nonatomic,strong)NSMutableArray * detailArray;

@property(nonatomic,strong)NSMutableArray * Image2Array;
@property(nonatomic,strong)NSMutableArray * title2Array;

@property(nonatomic,strong)NSMutableArray * Image3Array;
@property(nonatomic,strong)NSMutableArray * title3Array;

@property(nonatomic,strong)NSMutableArray * Image4Array;
@property(nonatomic,strong)NSMutableArray * title4Array;

@property(nonatomic,strong)NSMutableArray * Image5Array;
@property(nonatomic,strong)NSMutableArray * title5Array;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"设置";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerNib:[UINib nibWithNibName:@"SettingHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"iden"];
     [_tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"other"];
    [self.view addSubview:_tableView];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    _detailArray=[NSMutableArray arrayWithObjects:@"状态栏自动提醒消息推送内容",@"看视频,上传或下载知识点", nil];
    
    _title1Array=[NSMutableArray arrayWithObjects:@"消息提醒",@"仅在WiFi下使用", nil];
    _title2Array=[NSMutableArray arrayWithObjects:@"字体大小",@"修改密码", nil];
    _title3Array=[NSMutableArray arrayWithObjects:@"赛场规则", nil];
    _title4Array=[NSMutableArray arrayWithObjects:@"清空缓存",@"关于我们", nil];
    _title5Array=[NSMutableArray arrayWithObjects:@"注销", nil];
    
    _Image1Array=[NSMutableArray arrayWithObjects:@"settings_alarm",@"settings_network_status", nil];
    _Image2Array=[NSMutableArray arrayWithObjects:@"settings_front_size",@"settings_change_password", nil];
    _Image3Array=[NSMutableArray arrayWithObjects:@"settings_score_rule", nil];
    _Image4Array=[NSMutableArray arrayWithObjects:@"settings_delete_cache",@"settings_about_us", nil];
    _Image5Array=[NSMutableArray arrayWithObjects:@"settings_logout", nil];
    
    
}
-(void)Back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return 2;
    }
    if (section==2) {
        return 1;
    }
    if (section==3) {
        return 2;
    }
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==4) {
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定退出吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex==1) {
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFImageResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/cleanTokenInfo.mob",URLDOMAIN];
        NSUserDefaults * token1=[NSUserDefaults standardUserDefaults];
        NSString * token=[token1 objectForKey:@"token"];
        
        NSDictionary * dic=@{@"token":token};
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
//        [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@",dic);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//        }];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        SettingHeadTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"iden" forIndexPath:indexPath];
        cell.titleLabel.text=_title1Array[indexPath.row];
        cell.detailLabel.text=_detailArray[indexPath.row];
        cell.headImage.image=[UIImage imageNamed:_Image1Array[indexPath.row]];
        
        return cell;
        
    }
    OtherTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"other" forIndexPath:indexPath];
    if (indexPath.section==1) {
        cell.TitleLabel.text=_title2Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image2Array[indexPath.row]];
    }
    if (indexPath.section==2) {
        cell.TitleLabel.text=_title3Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image3Array[indexPath.row]];
    }
    if (indexPath.section==3) {
        cell.TitleLabel.text=_title4Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image4Array[indexPath.row]];
    }
    if (indexPath.section==4) {
        cell.TitleLabel.text=_title5Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image5Array[indexPath.row]];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
