//
//  NewCommentListTableViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "NewCommentListTableViewController.h"
#import "NewCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "JRKnowLedgeTableViewController.h"
#import "PrefixHeader.pch"
#import "NewFlowerListViewController.h"
#import "MJRefresh.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height


@interface NewCommentListTableViewController ()
@property(nonatomic,strong)NSMutableArray * headImageArr;
@property(nonatomic,strong)NSMutableArray * AllheadImageArr;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)UIView * background;
@property(nonatomic,strong)NSMutableArray * commtListArr;
@property(nonatomic,assign)NSInteger commentNum;
@end

@implementation NewCommentListTableViewController
-(void)loadData{
    _headImageArr = [NSMutableArray new];
    _AllheadImageArr=[NSMutableArray new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"]?[user objectForKey:@"token"]:@"";
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getAllPraseUsers.mob?token=%@&currentPage=%@&pagesize=%@&kpID=%@",URLDOMAIN,token,@"0",@"10",self.kpID];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
   [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       NSDictionary * dic=(NSDictionary *)responseObject;
       if (dic) {
           
       
       
       NSString * status=[NSString stringWithFormat:@"%@",dic[@"status"]];
       int  num=[dic[@"userNum"] intValue];
       if (status.length>0) {
           if ([status isEqualToString:@"0"]) {
               if (num>0) {
                   UILabel * label=[_background viewWithTag:1234];
                   label.hidden=YES;
                   UILabel * label1=[_background viewWithTag:12345];
                   label1.text=[NSString stringWithFormat:@"点赞详情（%d人）",num];
                   
                   NSArray *arr=dic[@"list"];
                   
                   for (NSDictionary * subDic in arr) {
                       [_headImageArr addObject:subDic[@"headIcon"]];
                       [_AllheadImageArr addObject:subDic[@"headIcon"]];
                   }
                   if (_headImageArr.count>6) {
                    
                       
                     _headImageArr =[NSMutableArray arrayWithArray:[_headImageArr subarrayWithRange:NSMakeRange(0, 5)]] ;
                       [_headImageArr addObject:@"THeMore"];
                       
                       
                   }
                   
                   for (int i=10; i<20; i++) {
                       UIButton * b=[_background viewWithTag:i];
                       [b removeFromSuperview];
                       b=nil;
                   }
                   for (int i=20; i<30; i++) {
                       UIImageView * b=[_background viewWithTag:i];
                       [b removeFromSuperview];
                       b=nil;
                   }
                   
                   
                       for (int i=0; i<_headImageArr.count; i++) {
                           UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*12/375+i*WIDTH/6,WIDTH *48/375, 36*WIDTH/375, 36*WIDTH/375)];
                           
                           image.tag=20+i;
                           image.layer.masksToBounds = YES;
                           image.layer.cornerRadius=18*WIDTH/375;
                           CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                           // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                           CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
                           image.layer.borderWidth=0.5;
                           image.layer.borderColor=borderColorRef;
                            [image sd_setImageWithURL:[NSURL URLWithString:_headImageArr[i]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];

                           if ([_headImageArr[i] isEqualToString:@"THeMore"]) {
                               image.image=[UIImage imageNamed:@"THeMore"];
                           }
                          
                           [_background addSubview:image];
                           
                           
                          UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH*12/375+i*WIDTH/6,WIDTH *48/375, 36*WIDTH/375, 36*WIDTH/375)];
                           
                           button.tag=10+i;
                           
                           [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                           
                           [_background addSubview:button];
                           
                       }
                   
                   
                   
                   
               }
               
               
               
           }
           
           
           
       }
       
    }
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error);
   }];
    
    
}

-(void)loadData1{
    _commtListArr=[NSMutableArray new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"]?[user objectForKey:@"token"]:@"";
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getAllCommentUsers.mob?token=%@&currentPage=%@&pagesize=%@&kpID=%@",URLDOMAIN,token,@"0",@"10",self.kpID];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic=(NSDictionary *)responseObject;
        if (dic) {
            
            NSLog(@"%@",dic);
            
            NSString * status=[NSString stringWithFormat:@"%@",dic[@"status"]];
            _commentNum=[dic[@"userNum"] integerValue];
            if (status.length>0) {
                if ([status isEqualToString:@"0"]) {
                    if (_commentNum>0) {
                        
                        
                        NSArray *arr=dic[@"list"];
                        
                        for (NSDictionary * subDic in arr) {
                            [_commtListArr addObject:subDic];
                        }
                        
                        [self.tableView reloadData];
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)receiveNotificiation:(NSNotification*)n{


    [self loadData1];

}
-(void)receiveNotificiation1:(NSNotification*)n{
    
    
    [self loadData];
    
}
-(void)changeBgColor{

[self loadData1];
[self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setHeaderView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"shuaxinpinglun" object:nil];
    
    [center addObserver:self selector:@selector(receiveNotificiation1:) name:@"shuaxindianzan" object:nil];
    [center addObserver:self selector:@selector(changeBgColor) name:@"shuaxinleya" object:nil];

    self.tableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.kpID=self.kpID?[NSString stringWithFormat:@"%@",self.kpID]:[NSString stringWithFormat:@"%@",self.parameter];
    [self loadData];
    
    [self loadData1];
    
    _page=0;
    
    [self setFooterView];
}
-(void)setHeaderView{
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 190*WIDTH/375)];
    headerView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    UIView * pinglun=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 66*WIDTH/375)];
    pinglun.backgroundColor=[UIColor whiteColor];
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(12*WIDTH/375, 15*WIDTH/375, 351*WIDTH/375, 36*WIDTH/375)];
    
    [button setTitleColor:[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"writeComment"] forState:UIControlStateNormal];
    [button setTitle:@"写评论" forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5*WIDTH/375,0, 5*WIDTH/375, 15*WIDTH/375)];
    button.titleLabel.font=[UIFont systemFontOfSize:15*WIDTH/375];
    
    button.layer.cornerRadius=18*WIDTH/375;
    
    [button addTarget:self action:@selector(Pinglun:) forControlEvents:UIControlEventTouchUpInside];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 200/255.0, 199/255.0, 204/255.0, 1 });
    button.layer.borderWidth=0.5;
    button.layer.borderColor=borderColorRef;
    [pinglun addSubview:button];
    
    [headerView addSubview:pinglun];
    
    
    
    
    
    
    _background=[[UIView alloc]initWithFrame:CGRectMake(0,78*WIDTH/375, WIDTH, WIDTH*100/375)];
    
    _background.backgroundColor=[UIColor whiteColor];
    
    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(12*WIDTH/375, 12*WIDTH/375, 200, 16*WIDTH/375)];
    label.font=[UIFont systemFontOfSize:14 *WIDTH/375];
    [_background addSubview:label];
    
    
    UILabel * Zanwu=[[UILabel alloc]initWithFrame:CGRectMake(0, 56*WIDTH/375, WIDTH, 16*WIDTH/375)];
    
    Zanwu.font=[UIFont systemFontOfSize:13*WIDTH/375];
    Zanwu.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    Zanwu.textAlignment=NSTextAlignmentCenter;
    
    [_background addSubview:Zanwu];
    
    Zanwu.tag=1234;
    Zanwu.text=@"暂时还没有点赞";
    label.text=@"点赞详情（0人）";
    label.tag=12345;
    [headerView addSubview:_background];
    
    
    self.tableView.tableHeaderView=headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _commtListArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;

//    return 110*WIDTH/375;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, WIDTH*100/375)];
    
    background.backgroundColor=[UIColor whiteColor];
    
    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(12*WIDTH/375, 12*WIDTH/375, 200, 16*WIDTH/375)];
    label.font=[UIFont systemFontOfSize:14 *WIDTH/375];
    [background addSubview:label];
    
    
    UILabel * Zanwu=[[UILabel alloc]initWithFrame:CGRectMake(0, 54*WIDTH/375, WIDTH, 16*WIDTH/375)];
    
    Zanwu.font=[UIFont systemFontOfSize:13*WIDTH/375];
    Zanwu.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    Zanwu.textAlignment=NSTextAlignmentCenter;
    
    [background addSubview:Zanwu];
 
    
     Zanwu.text=@"暂时还没有评论";
     label.text=@"评论详情（0条）";
    
    
    
    
    if (_commentNum>0) {
        Zanwu.hidden=YES;
        label.text=[NSString stringWithFormat:@"评论详情（%ld条）",_commentNum];
    }

   
    
   
    
   
    
    return background;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_commentNum>0) {
        return (WIDTH *40/375);
    }else{
        return (WIDTH *100/375);
    }
    //自定义高度
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

        NewCommentTableViewCell * cell=[NewCommentTableViewCell cellWithTableView:tableView];
        cell.nameLabel.text=[NSString stringWithFormat:@"%@",_commtListArr[indexPath.row][@"userName"]];
        [cell.OneImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_commtListArr[indexPath.row][@"headIcon"]]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
    
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       cell.timeLabel.text=[NSString stringWithFormat:@"%@",_commtListArr[indexPath.row][@"comment_date"]];
    
    
    cell.starView.commentPoint=[[NSString stringWithFormat:@"%@",_commtListArr[indexPath.row][@"star"]] floatValue]*2;

    
    NSString *str = [[NSString stringWithFormat:@"%@",_commtListArr[indexPath.row][@"comment_content"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (str.length>200) {
        [str substringWithRange:NSMakeRange(0, 200)];
        [cell setIntroductionText:str];

    }else{
        
        [cell setIntroductionText:str];

    }

        return cell;
   
    
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = WIDTH *108/375;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

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
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 12*WIDTH/375, 0, 12*WIDTH/375)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 12*WIDTH/375, 0, 12*WIDTH/375)];
    }
}
-(void)btnClick:(UIButton *)button{

   
    
    
  
    
    
    if (_AllheadImageArr.count>6) {
        
        if (button.tag==15) {
            
            NewFlowerListViewController * new=[[NewFlowerListViewController alloc]init];
            new.kpID=self.kpID;
            UILabel * label1=[_background viewWithTag:12345];
            
            new.NavTitle=label1.text;
            [self.navigationController pushViewController:new animated:YES];
            
            
        }
        
    }else{
    
        
        
        
    }

}
-(void)Pinglun:(UIButton *)buton{

    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tanchupinglun" object:nil userInfo:nil];


}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)setFooterView{
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadDataWithPage:_page];
        [self.tableView reloadData];
        
    }];
    
    self.tableView.mj_footer.automaticallyHidden=YES;
    
}
-(void)loadDataWithPage:(NSInteger)page{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"]?[user objectForKey:@"token"]:@"";
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getAllCommentUsers.mob?token=%@&currentPage=%ld&pagesize=%@&kpID=%@",URLDOMAIN,token,(long)page,@"10",self.kpID];
    
    NSLog(@"%@",url);
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic=(NSDictionary *)responseObject;
        if (dic) {
            
            NSLog(@"%@",dic);
            
            NSString * status=[NSString stringWithFormat:@"%@",dic[@"status"]];
            _commentNum=[dic[@"userNum"] integerValue];
            if (status.length>0) {
                if ([status isEqualToString:@"0"]) {
                    if (_commentNum>0) {
                        
                        
                        NSArray *arr=dic[@"list"];
                        if (arr.count>0) {
                            
                        
                        for (NSDictionary * subDic in arr) {
                            [_commtListArr addObject:subDic];
                        }
                            [self.tableView reloadData];
                            [self.tableView.mj_footer endRefreshing];

                        }else{
                        
                        
                            [self.tableView.mj_footer endRefreshingWithNoMoreData];
                        }
                        
                        
                        
                    }
                    
                    
                    
                }else{
                
                    [self.tableView.mj_footer endRefreshing];
                }
                
                
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [self.tableView.mj_footer endRefreshing];
    }];

    
    
    
}


@end
