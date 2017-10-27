//
//  MyViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/12.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MyViewController.h"
#import "UIImageView+AFNetworking.h"
#import "OtherTableViewCell.h"
#import "SetViewController.h"
#import "ContactsViewController.h"
#import "MyDetailViewController.h"
#import "MyDetail1TableViewCell.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableVview;
@property(nonatomic,strong)NSMutableArray * image1Array;
@property(nonatomic,strong)NSMutableArray * title1Array;
@property(nonatomic,strong)NSMutableArray * image2Array;
@property(nonatomic,strong)NSMutableArray * title2Array;
@property(nonatomic,strong)NSMutableArray * image3Array;
@property(nonatomic,strong)NSMutableArray * title3Array;
@property(nonatomic,strong)NSMutableArray * image4Array;
@property(nonatomic,strong)NSMutableArray * title4Array;
@property(nonatomic,strong)NSMutableArray * image5Array;
@property(nonatomic,strong)NSMutableArray * title5Array;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    _image1Array=[NSMutableArray arrayWithObjects:@"right_contact", nil];

    _title1Array=[NSMutableArray arrayWithObjects:@"通讯录", nil];
    
    _image2Array=[NSMutableArray arrayWithObjects:@"focus_icon",@"right_collection",@"right_share",@"right_review", nil];
    
    _title2Array=[NSMutableArray arrayWithObjects:@"关注",@"收藏",@"我的本地宝",@"我的评论", nil];
    _image3Array=[NSMutableArray arrayWithObjects:@"right_msg", nil];
    
    _title3Array=[NSMutableArray arrayWithObjects:@"公告消息", nil];
    _image4Array=[NSMutableArray arrayWithObjects:@"learn_calender",@"right_history",@"right_offline", nil];
    
    _title4Array=[NSMutableArray arrayWithObjects:@"学习日历",@"学习历史",@"离线学习", nil];
    
       _image5Array=[NSMutableArray arrayWithObjects:@"personal_center_settings_icon", nil];
    
      _title5Array=[NSMutableArray arrayWithObjects:@"设置", nil];
    self.navigationItem.title=@"个人中心";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableVview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStyleGrouped];
    self.tableVview.delegate=self;
    self.tableVview.dataSource=self;
    
    [self.tableVview registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"other"];
    [self.view addSubview:self.tableVview];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)Back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90;
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
    
        return 1;
    }else if (section==2){
        return 4;
    }else if(section==3){
        return 1;
    }else if (section==4){
        return 3;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
   MyDetail1TableViewCell * cell=[MyDetail1TableViewCell cellWithTableView:tableView];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.headImageView setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"headImageViewURL"]] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
        cell.nameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        cell.scoreLabel.text=[NSString stringWithFormat:@"%@.0",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalIntegral"]];
        cell.rankLabel.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalRanking"]];
    return cell;
}
    OtherTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"other" forIndexPath:indexPath];
    if (indexPath.section==1) {
        cell.TitleImage.image=[UIImage imageNamed:_image1Array[indexPath.row]];
        cell.TitleLabel.text=_title1Array[indexPath.row];
    }
    if (indexPath.section==2) {
        cell.TitleImage.image=[UIImage imageNamed:_image2Array[indexPath.row]];
        cell.TitleLabel.text=_title2Array[indexPath.row];
    }
    if (indexPath.section==3) {
        cell.TitleImage.image=[UIImage imageNamed:_image3Array[indexPath.row]];
        cell.TitleLabel.text=_title3Array[indexPath.row];
    }
    if (indexPath.section==4) {
        cell.TitleImage.image=[UIImage imageNamed:_image4Array[indexPath.row]];
        cell.TitleLabel.text=_title4Array[indexPath.row];
    }
    if (indexPath.section==5) {
        cell.TitleImage.image=[UIImage imageNamed:_image5Array[indexPath.row]];
        cell.TitleLabel.text=_title5Array[indexPath.row];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        
        MyDetailViewController * detail=[[MyDetailViewController alloc]init];
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
    
    if (indexPath.section==1) {
        ContactsViewController * contact=[[ContactsViewController alloc]init];
        [self.navigationController pushViewController:contact animated:YES];
        
}
    
    if (indexPath.section==5) {
        SetViewController * set=[[SetViewController alloc]init];
        [self.navigationController pushViewController:set animated:YES];
    }
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
