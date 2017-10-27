//
//  qiyeMessageViewController.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "qiyeMessageViewController.h"
#import "newFriendListViewController.h"
#import "newnotifyTableViewCell.h"
#import "AFNetworking.h"
#import "touxiangTableViewCell.h"
#import "PrefixHeader.pch"
#import "biaoganViewController.h"
@interface qiyeMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tabelView;
@property(nonatomic,strong)NSArray * arr;
@end

@implementation qiyeMessageViewController
{
    NSArray * Arr;
    NSString * timeStr;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=self.name;
    
    self.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    self.tabelView.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1];

    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*15/375)];
    
    view.backgroundColor=[UIColor clearColor];
    
    _tabelView.tableFooterView=view;
    _tabelView.tableHeaderView=view;
    //    self.tabelView.estimatedRowHeight = 100;  //  随便设个不那么离谱的值
    //    self.tabelView.rowHeight = UITableViewAutomaticDimension;
    _tabelView.dataSource=self;
    _tabelView.delegate=self;

    self.tabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tabelView];
    
    [self.tabelView setContentOffset:CGPointMake(0,100000* self.tabelView.bounds.size.height) animated:NO];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return   _allMessage.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDateFormatter * dateFormatter1=[[NSDateFormatter alloc] init];
    
    [dateFormatter1 setDateFormat:@"HH:mm"];
    
    NSDateFormatter * dateFormatter2=[[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"MM月dd日"];
    
    NSDateFormatter * dateFormatter3=[[NSDateFormatter alloc] init];
    
    [dateFormatter3 setDateFormat:@"yyyy年MM月dd日"];
    
    
    NSDate*date=[dateFormatter dateFromString:_allMessage[indexPath.row][@"pushTime"]];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    
    
    // 1.获得当前时间的年月日
    
    NSDateComponents * nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    
    
    // 2.获得self的年月日
    
    NSDateComponents * selfCmps = [calendar components:unit fromDate:date];
    
    if (nowCmps.year == selfCmps.year) {
        
        if ((selfCmps.year == nowCmps.year) &&
            
            (selfCmps.month == nowCmps.month) &&
            
            (selfCmps.day == nowCmps.day)) {
            
            NSString * str=[dateFormatter1 stringFromDate:date];
            timeStr=str;
        }else{
            
            
            NSString * str=[dateFormatter2 stringFromDate:date];
            timeStr=str;
        }
        
        
    }else{
        
        NSString * str=[dateFormatter3 stringFromDate:date];
        
        timeStr=str;
        
        
    }
    
    
    
    if ([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"15"]) {
        touxiangTableViewCell * cell=[touxiangTableViewCell cellWithTableView:tableView];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setCellWithCategory:@"15" andContentDic:_allMessage[indexPath.row] andTime:timeStr];
//        [cell  setcontentString:_allMessage[indexPath.row][@"pushMessageContent"]];
        
        return cell;
    }else if ([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"18"]) {
        touxiangTableViewCell * cell=[touxiangTableViewCell cellWithTableView:tableView];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setCellWithCategory:@"18" andContentDic:_allMessage[indexPath.row] andTime:timeStr];
        //        [cell  setcontentString:_allMessage[indexPath.row][@"pushMessageContent"]];
        
        return cell;
    }else {
    
        newnotifyTableViewCell  * cell=[newnotifyTableViewCell cellWithTableView:tableView];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       
        [cell setCellWithCategory:_allMessage[indexPath.row][@"categoryId"] andWithContentString:_allMessage[indexPath.row][@"pushMessageContent"] andTimeString:timeStr andTite:_allMessage[indexPath.row][@"pushMessageTitle"]];
        
        return cell;
    
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Back:(UIBarButtonItem *)button{
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.opID,@"opID", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"isRead" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:self.view.frame.size.width*13/375];
    NSString *str =_allMessage[indexPath.row][@"pushMessageContent"];
    textLabel.text = str;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:textLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5.0];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [textLabel.text length])];
    [textLabel setAttributedText:attributedString1];
    textLabel.numberOfLines = 3;//根据最大行数需求来设置
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width*290/375, 9999);
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    
    if ([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"15"]) {
       
        if (str.length<1) {
            return    self.view.frame.size.width* 122.5/375;
        }
        
        return    self.view.frame.size.width* 122.5/375+expectSize.height+self.view.frame.size.width*60/375;
    }else if ([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"18"]) {
        
        if (str.length<1) {
            return    self.view.frame.size.width* 122.5/375;
        }
        
        return    self.view.frame.size.width* 122.5/375+expectSize.height+self.view.frame.size.width*40/375;
    }else if([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"16"]){
    return  self.view.frame.size.width* 60/375+expectSize.height;
    }else if([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"17"]){
        return  self.view.frame.size.width* 83/375+self.view.frame.size.width*40/375;
    }else{
    return  self.view.frame.size.width* 83/375+expectSize.height+self.view.frame.size.width*40/375;
    
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"16"]){
    
         newFriendListViewController * friend=[[newFriendListViewController alloc]init];
    
    
         [self.navigationController pushViewController:friend animated:YES];


    
    }else if([_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"19"]||[_allMessage[indexPath.row][@"categoryId"] isEqualToString:@"20"]){
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        NSDictionary * dic=@{@"userID":[user objectForKey:@"userID"]};
        
        
        NSString * Url=[NSString stringWithFormat:@"%@",_allMessage[indexPath.row][@"pushMessageDetailUrl"]];
        
        NSLog(@"%@",Url);
        
        
        [manager POST:Url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            NSArray * arr=[_allMessage[indexPath.row][@"pushMessageDetailUrl"] componentsSeparatedByString:@"="];
            ;
            
            NSString * tempStr=arr[1];
            
            NSArray * arr1=[tempStr componentsSeparatedByString:@"&"];
            
            
            NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
            NSString * ret=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
            NSString * tset=[NSString stringWithFormat:@"%@",responseObject[@"data"][@"tested"]];
            if ([ret isEqualToString:@"0"]) {
                if ([tset isEqualToString:@"0"]) {

                    biaoganViewController * biaogan=[[biaoganViewController alloc]init];
                    biaogan.webUrl=[NSString stringWithFormat:@"%@/WeChat/getEvaluationDetail.wc?evalID=%@&userID=%@&tpPsType=%@&kpType=test&companyID=%@&scene=bag_a",URLDOMAIN,arr1[0],[UserDefaults objectForKey:@"userID"],arr[2],[UserDefaults objectForKey:@"companyID"]];
                    
                    [self.navigationController pushViewController:biaogan animated:YES];
                    
                }else{
        
                    biaoganViewController * biaogan=[[biaoganViewController alloc]init];
                    biaogan.webUrl=[NSString stringWithFormat:@"%@/WeChat/getEvaluationTestDetail.wc?tpID=%@&userID=%@&tpPsType=%@&kpType=test&companyID=%@&scene=bag_a",URLDOMAIN,arr1[0],[UserDefaults objectForKey:@"userID"],arr[2],[UserDefaults objectForKey:@"companyID"]];
                    
                    [self.navigationController pushViewController:biaogan animated:YES];
                }

            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
       
    }else{
    
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        NSDictionary * dic=@{@"noticeID":_allMessage[indexPath.row][@"announcementId"],@"token":[user objectForKey:@"token"]};
        
        
        NSString * Url=[NSString stringWithFormat:@"%@/BagServer/readNoticeDetail.mob",URLDOMAIN];
        
        
        
        
        [manager POST:Url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
     
        
        NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
        
        biaoganViewController * biaogan=[[biaoganViewController alloc]init];
        biaogan.webUrl=_allMessage[indexPath.row][@"pushMessageDetailUrl"];
        biaogan.webUrl=[NSString stringWithFormat:@"%@&token=%@&platform=ios&userID=%@&companyID=%@",_allMessage[indexPath.row][@"pushMessageDetailUrl"],[UserDefaults objectForKey:@"token"],[UserDefaults objectForKey:@"userID"],[UserDefaults objectForKey:@"companyID"]];
        
        [self.navigationController pushViewController:biaogan animated:YES];
    
    }
    
   
}

@end
