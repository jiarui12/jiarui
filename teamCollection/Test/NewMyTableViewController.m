//
//  NewMyTableViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/27.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewMyTableViewController.h"
#import "SetViewController.h"
#import "OtherTableViewCell.h"
@interface NewMyTableViewController ()
@property(nonatomic,strong)NSArray * nameArr;
@property(nonatomic,strong)NSArray * imageArr;
@end

@implementation NewMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _nameArr=@[@[@"通讯录"],@[@"我的收藏",@"我的评价",@"我的问卷"],@[@"学习日历",@"离线学习",@"浏览记录"],@[@"联系我们"]];
    _imageArr=@[@[@"通讯录"],@[@"我的收藏",@"我的评价",@"我的问卷"],@[@"学习日历",@"离线学习",@"浏览记录"],@[@"联系我们"]];
    
    
        [self.tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil]forHeaderFooterViewReuseIdentifier:@"other"];
}
-(void)setHeadView{
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    view.backgroundColor=[UIColor colorWithRed:40/255.0 green:140/255.0 blue:251/255.0 alpha:1.0];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    button.frame=CGRectMake(20, 20, 20, 20);
    
    [button setBackgroundImage:[UIImage imageNamed:@"nav_icon_set_defult@2x"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    self.tableView.tableHeaderView=view;
    


}
-(void)set:(UIButton *)button{
 
    SetViewController * set=[[SetViewController alloc]init];
    
    [self.navigationController pushViewController:set animated:YES];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _nameArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_nameArr[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OtherTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"other" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.TitleImage.image=_imageArr[indexPath.section][indexPath.row];
    return cell;
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

@end
