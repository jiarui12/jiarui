//
//  AboutUsViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/4/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "AboutUsViewController.h"
#import "FeedBackViewController.h"
@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonnull,strong)UITableView * tabView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
       
    
    
    self.navigationItem.title=@"关于我们";
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tabView.delegate=self;
    _tabView.dataSource=self;
    [self.view addSubview:_tabView];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel * we=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 70, 20)];
    we.font=[UIFont systemFontOfSize:14];
    we.backgroundColor=[UIColor whiteColor];
    we.text=@"联系方式";
    [view addSubview:we];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(self.view.frame.size.width-120, 220,120, 20);
    
    [button setTitle:@"400-701-2389" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Telphone:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
        
        UILabel * banzu=[[UILabel alloc]init];
    banzu.frame=CGRectMake(0, 90, self.view.frame.size.width, 40);
    banzu.text=@"班组汇";
    banzu.textColor=[UIColor colorWithRed:11/255.0 green:127/255.0 blue:255/255.0 alpha:1.0];
    banzu.textAlignment=NSTextAlignmentCenter;
    [view addSubview:banzu];
    UIImageView * headImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 20, 80, 80)];
    headImage.image=[UIImage imageNamed:@"ic_launcher"];
    [view addSubview:headImage];
    UILabel * detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 40)];
    detailLabel.numberOfLines=0;
    detailLabel.text=@"班组汇是一款根据企业实际状况进行有针对性的能力管理的现代化班组的必备工具";
    detailLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:detailLabel];
    
    self.tabView.tableHeaderView=view;
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
}
-(void)Back:(UIBarButtonItem*)button{

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * iden=@"iden";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    if (indexPath.section==0) {
        
        cell.textLabel.text=@[@"当前版本",@"检查最新版本"][indexPath.row];
        
        
    }
    if (indexPath.section==1) {
        cell.textLabel.text=@[@"使用引导",@"意见反馈"][indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
 
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;

}
-(void)Telphone:(UIButton*)button{
    
    NSString *number = @"4007012389";
    
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==1) {
        if (indexPath.row==1) {
            FeedBackViewController * feed=[[FeedBackViewController alloc]init];
            [self.navigationController pushViewController:feed animated:YES];
        }
    }

}
@end
