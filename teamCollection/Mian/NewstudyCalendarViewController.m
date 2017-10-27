//
//  NewstudyCalendarViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/6/12.
//  Copyright © 2017年 八九点. All rights reserved.
//
#import "FDCalendar.h"
#import "NewstudyCalendarViewController.h"
#import "newStudyCalendarTableViewCell.h"
#import "UINavigationController+Cloudox.h"
#import "UIViewController+Cloudox.h"
@interface NewstudyCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;


@end

@implementation NewstudyCalendarViewController

- (void)viewDidLoad {

    
    [super viewDidLoad];
    self.navigationItem.title=@"学习日历";
    self.automaticallyAdjustsScrollViewInsets=NO;
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame = calendar.frame;
    frame.origin.y = 20;
    calendar.frame = frame;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableView.tableHeaderView=calendar;
    [self.view addSubview:_tableView];
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
}
-(void)Back:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return 5;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    newStudyCalendarTableViewCell * cell=[newStudyCalendarTableViewCell cellWithTableView:tableView];
    cell.titleLabel.text=@"班组会班组会班组会";
    cell.categaryLabel.text=@"微课";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navBarBgAlpha=@"1.0";
    
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
