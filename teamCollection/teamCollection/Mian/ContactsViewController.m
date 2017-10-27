//
//  ContactsViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/27.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "ContactsViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "UIImageView+AFNetworking.h"
#import "ContancTableViewCell.h"
@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * headIconUrl;
@property(nonatomic,strong)NSMutableArray * orgInfo;
@property(nonatomic,strong)NSMutableArray * userName;
@property(nonatomic,strong)NSArray * array;

@end

@implementation ContactsViewController{
  NSArray *_sectionTitles;
}
-(void)loadData{
    _headIconUrl=[NSMutableArray new];
    _orgInfo=[NSMutableArray new];
    _userName=[NSMutableArray new];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
   
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSDictionary * parameters=@{@"token":[user objectForKey:@"token"]};
    NSString * url=[NSString stringWithFormat:@"%@:8080/BagServer/getContactList.mob",URLDOMAIN];
    
    
    NSLog(@"%@",parameters);
[manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
   
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    _array=[NSArray new];
   _array=(NSArray *)responseObject;
    NSLog(@"%lu",(unsigned long)_array.count);
    for (NSDictionary * subDic in _array) {
        [_orgInfo addObject:subDic[@"orgInfo"]];
        [_userName addObject:subDic[@"userName"]];
        [_headIconUrl addObject:subDic[@"headIconUrl"]];
    }
    
    
    [_tableView reloadData];
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
   
    NSLog(@"%@",error);
}];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.view.backgroundColor=[UIColor whiteColor];
    _sectionTitles=[[NSArray alloc]initWithObjects:@"A"@"B"@"C"@"D"@"E"@"F"@"G"@"H"@"I"@"J"@"K"@"L"@"M"@"N"@"O"@"P"@"Q"@"R"@"S"@"T"@"U"@"V"@"W"@"X"@"Y"@"Z", nil];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64 , self.view.frame.size.width, self.view.frame.size.height-64)style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionIndexColor=[UIColor blueColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContancTableViewCell * cell=[ContancTableViewCell cellWithTableView:tableView];
    [cell.headImageView setImageWithURL:_headIconUrl[indexPath.row]];
    cell.nameLabel.text=_userName[indexPath.row];
    cell.infoLabel.text=_orgInfo[indexPath.row];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionTitles objectAtIndex:section];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _sectionTitles;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSIndexPath * select=[NSIndexPath indexPathForRow:0 inSection:index];
    [self.tableView scrollToRowAtIndexPath:select atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return index;
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
