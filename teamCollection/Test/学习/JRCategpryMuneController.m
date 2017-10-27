//
//  JRCategpryMuneController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/4/26.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "JRCategpryMuneController.h"
#import "JRMuneTableViewCell.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
@interface JRCategpryMuneController ()
@property (nonatomic, strong) NSMutableArray *catelogyList;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation JRCategpryMuneController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    
    
    
    
       // 去除分割线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    // 不允许下拉
    self.tableView.bounces = NO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadData{

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSDictionary * Dic=[user objectForKey:@"allNodeList"];
    
    
    _catelogyList=[NSMutableArray new];
    
    for (NSDictionary * dic in Dic[@"firstNodeListStr"]) {
        [_catelogyList addObject:dic];
    }
    [user setObject:_catelogyList forKey:@"firstNodeList"];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
  
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getMapFirstLevleNodes.mob?token=%@",URLDOMAIN,[user objectForKey:@"token"]];
    if ([[user objectForKey:@"token"] length]>8) {
        
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if ([responseObject[@"firstNodeList"] count]>0) {
          
            

            
        }
        
        
        
        

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"%@",error);
    }];
    
   
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _catelogyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JRMuneTableViewCell *cell = [[JRMuneTableViewCell alloc]init];
   
    
    // 设置cell背景
    
   
    
    UIView * imageb=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    imageb.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
    
    
    cell.backgroundView = imageb;
    
    
    
    UIView * images=[[UIView alloc] initWithFrame:CGRectMake(0, 0,100, 50)];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*7/375, 50)];
    view.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    
    [images addSubview:view];
    
    images.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    // 设置cell被选中时的背景
    cell.selectedBackgroundView = images;


    

    cell.label.text = _catelogyList[indexPath.row][@"map_name"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JRMuneTableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.label.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    
    
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    JRMuneTableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.label.textColor=[UIColor colorWithRed:44/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    NSDictionary * dic=@{@"mpid":[NSString stringWithFormat:@"%@",_catelogyList[indexPath.row][@"map_id"]],@"index":[NSString stringWithFormat:@"%ld",(long)indexPath.row]};

    NSNotification * notice = [NSNotification notificationWithName:@"refreshStudy" object:nil userInfo:dic];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
@end
