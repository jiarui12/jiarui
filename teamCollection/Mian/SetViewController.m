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
#import "changepasswordViewController.h"
#import "SettingViewController.h"
#import "ChatTool.h"
#import "SDImageCache.h"
#import "IntegralLevelListViewController.h"
#import "AboutUsViewController.h"
#import "SupportViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "HistoryLoginViewController.h"
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
    self.tabBarController.tabBar.hidden=YES;
    
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerNib:[UINib nibWithNibName:@"SettingHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"iden"];
    [_tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"other"];
    _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    
    _detailArray=[NSMutableArray arrayWithObjects:@"状态栏自动提醒消息推送内容",@"看视频,上传或下载知识点", nil];
    
    _title1Array=[NSMutableArray arrayWithObjects:@"消息提醒",@"仅在WiFi下使用", nil];
    _title2Array=[NSMutableArray arrayWithObjects:@"字体大小",@"修改密码", nil];
    _title3Array=[NSMutableArray arrayWithObjects:@"赛场规则", nil];
    _title4Array=[NSMutableArray arrayWithObjects:@"清空缓存", nil];
    _title5Array=[NSMutableArray arrayWithObjects:@"注销", nil];
    
    _Image1Array=[NSMutableArray arrayWithObjects:@"settings_alarm",@"settings_network_status", nil];
    _Image2Array=[NSMutableArray arrayWithObjects:@"settings_front_size",@"settings_change_password", nil];
    _Image3Array=[NSMutableArray arrayWithObjects:@"settings_score_rule", nil];
    _Image4Array=[NSMutableArray arrayWithObjects:@"settings_delete_cache", nil];
    _Image5Array=[NSMutableArray arrayWithObjects:@"settings_logout", nil];
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    
    headView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    UIView * table=[[UIView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 100)];
    
    UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 1)];
    line.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    UIImageView * fristImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 35, 35)];
    fristImage.image=[UIImage imageNamed:@"settings_alarm"];
    [table addSubview:fristImage];
    UIImageView * secondImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 57.5, 35, 35)];
    secondImage.image=[UIImage imageNamed:@"settings_network_status"];
    [table addSubview:secondImage];
    
    
    UILabel * fristTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 7, 100, 20)];
    fristTitleLabel.font=[UIFont systemFontOfSize:17];
    fristTitleLabel.text=@"消息提醒";
    [table addSubview:fristTitleLabel];
    UILabel * fristDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 32, 200, 10)];
    fristDetailLabel.text=@"状态栏自动提醒消息内容";
    fristDetailLabel.font=[UIFont systemFontOfSize:12];
    fristDetailLabel.textColor=[UIColor grayColor];
    [table addSubview:fristDetailLabel];
    
    
    
    UILabel * secondTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 57, 150, 20)];
    secondTitleLabel.font=[UIFont systemFontOfSize:17];
    secondTitleLabel.text=@"仅在WiFi下使用";
    [table addSubview:secondTitleLabel];
    UILabel * secondDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 82, 200, 10)];
    secondDetailLabel.text=@"看视频,上传或下载知识点";
    secondDetailLabel.font=[UIFont systemFontOfSize:12];
    secondDetailLabel.textColor=[UIColor grayColor];
    [table addSubview:secondDetailLabel];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    UISwitch * fristSlider=[[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, 10, 40, 20)];
//   fristSlider.s
    NSString * s1=[user objectForKey:@"switch1"];
    if ([s1 isEqualToString:@"1"]) {
        fristSlider.on=YES;
    }else{
        fristSlider.on=NO;
       
    
    }
    
    [fristSlider addTarget:self action:@selector(fristSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [table addSubview:fristSlider];
    
    UISwitch * secondSlider=[[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, 60, 50, 20)];
    fristSlider.tag=10;
    NSString * s2=[user objectForKey:@"switch2"];
    
    if ([s2 isEqualToString:@"1"]) {
        secondSlider.on=YES;
    }else{
        secondSlider.on=NO;
    }
    
    [secondSlider addTarget:self action:@selector(secondSlider:) forControlEvents:UIControlEventValueChanged];
    secondSlider.tag=20;
    [table addSubview:secondSlider];
    [table addSubview:line];
    table.backgroundColor=[UIColor whiteColor];
    [headView addSubview:table];
    self.tableView.tableHeaderView=headView;
}
-(void)secondSlider:(UISwitch*)s{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];

    if (s.isOn==YES) {
        NSLog(@"1");
        [user setObject:@"1" forKey:@"switch2"];
    }else{
        
        NSLog(@"0");
        [user setObject:@"0" forKey:@"switch2"];
    }
    

}
-(void)fristSwitch:(UISwitch*)s{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    if (s.isOn==YES) {
        NSLog(@"1");
        [user setObject:@"1" forKey:@"switch1"];
    }else{
    
        NSLog(@"0");
        [user setObject:@"0" forKey:@"switch1"];
    }
    

}
-(void)Back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return 1;
    }
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定注销吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];

    }
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            
            
        } if (indexPath.row==0) {
            
            
            
            
        }
        
        changepasswordViewController * change=[[changepasswordViewController alloc]init];
        [self.navigationController pushViewController:change animated:YES];
        

        
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"清空缓存后图片需要重新下载，确认要清空缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            av.tag=100;
            [av show];
            
            
        }
        if (indexPath.row==1) {
            
             SupportViewController * about=[[SupportViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
            
        }
        
        
    }
    if (indexPath.section==1) {
        
        
        IntegralLevelListViewController * integra=[[IntegralLevelListViewController alloc]init];
        [self.navigationController pushViewController:integra animated:YES];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    
    
  
    if (alertView.tag==100) {
        
        if (buttonIndex==1) {
            
            [[SDImageCache sharedImageCache] cleanDisk];
            
        }
        
        
    }else{
    
        if (buttonIndex==1) {
            
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/cleanTokenInfo.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
            
            NSLog(@"%@",url);
            [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                [user setObject:@"" forKey:@"token"];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
           
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                [user setObject:@"" forKey:@"token"];
                
            }];
            XMPPPresence * offline=[XMPPPresence presenceWithType:@"unavailable"];
            [[ChatTool sharedChatTool].xmppStream sendElement:offline];
            [[ChatTool sharedChatTool].xmppStream disconnect];
//            HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
//            UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
//            nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
//            [self presentViewController:nav animated:YES completion:^{
//                [UIApplication sharedApplication].keyWindow.rootViewController=nav;
//                
//                
//            }];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewController" object:@"zhangsan" userInfo:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }

    }
    
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    OtherTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"other" forIndexPath:indexPath];
    if (indexPath.section==0) {
        cell.TitleLabel.text=_title2Array[indexPath.row+1];
        cell.TitleImage.image=[UIImage imageNamed:_Image2Array[indexPath.row+1]];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==1) {
        cell.TitleLabel.text=_title3Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image3Array[indexPath.row]];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==2) {
        cell.TitleLabel.text=_title4Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image4Array[indexPath.row]];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==3) {
        cell.TitleLabel.text=_title5Array[indexPath.row];
        cell.TitleImage.image=[UIImage imageNamed:_Image5Array[indexPath.row]];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;



}
-(void)viewWillAppear:(BOOL)animated
{
    
    
//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=YES;
    
    self.navBarBgAlpha=@"1.0";
    
    UISwitch * ss1=[self.view viewWithTag:10];
    UISwitch * ss2=[self.view viewWithTag:20];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * s1=[user objectForKey:@"switch1"];
    if ([s1 isEqualToString:@"1"]) {
        ss1.on=YES;
    }else{
        ss1.on=NO;
        
        
    }
    
    
    
    
    NSString * s2=[user objectForKey:@"switch2"];
    
    if ([s2 isEqualToString:@"1"]) {
        ss2.on=YES;
    }else{
        ss2.on=NO;
    }

    
    
}



@end
