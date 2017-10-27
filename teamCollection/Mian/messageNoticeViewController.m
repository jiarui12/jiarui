//
//  messageNoticeViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "messageNoticeViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "notifyMessageTableViewCell.h"
#import "qiyeMessageViewController.h"
#import "messageSetViewController.h"
#import "newFriendListViewController.h"
#import "ChatViewController.h"
#import "ChatTool.h"
#import "FMDatabase.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface messageNoticeViewController ()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)UITableView * messageView;
@property(nonatomic,strong)NSMutableArray * companyNameArr;
@property(nonatomic,strong)NSMutableArray * messageArr;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * countArr;
@property(nonatomic,strong)NSMutableArray * dateArr;
@property(nonatomic,strong)NSMutableArray * idArr;
@property(nonatomic,strong)NSMutableArray * totalCountArr;
@property(nonatomic,strong)NSMutableArray * allMessageArr;
@property(nonatomic,strong)NSMutableArray * categoryTitle;
@end

@implementation messageNoticeViewController
{
NSFetchedResultsController *_resultsContr;
    FMDatabase * dataBase;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha=@"1.0";

    
}
- (void)tongzhi:(NSNotification *)text{
   
    NSString * update = [NSString stringWithFormat:@"UPDATE chat_%@ SET isRead = '1' WHERE operationId = '%@' ",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],text.userInfo[@"opID"]];
    BOOL isSuccess = [dataBase executeUpdate:update];
    if (isSuccess) {
        NSLog(@"成功");
    }
    [self loadMsg];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title=@"消息";
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"isRead" object:nil];
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    _messageView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    
    _messageView.delegate=self;
    _messageView.dataSource=self;
    self.messageView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_messageView];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame=CGRectMake(10, 0, 40, 20);
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40, 20)];
    
    
    [button1 setTitle:@"设置" forState:UIControlStateNormal];
    [button1 setTintColor:[UIColor whiteColor]];
    [button1 addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:view];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    _dataArray=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
    
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path=[path stringByAppendingPathComponent:@"chat.sqlite"];
    
    dataBase=[FMDatabase databaseWithPath:path];
    
    
    
    // 2 打开数据库，如果不存在则创建并且打开
    BOOL open=[dataBase open];
    if(open){
        NSLog(@"数据库打开成功");
    }
    //3 创建表
    
    NSString * create1=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS chat_%@(id integer PRIMARY KEY AUTOINCREMENT, categoryId text, categoryTitle text, commentLevel text, commentUserIcon text , commentUserName text , companyName text , operationId  text , pushMessageContent           text , pushMessageDetailUrl text , pushMessageTitle text , pushTime text , subTypeId text , subTypeTitle text , target text , targetType text , isRead text , isDisplay text);",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
    
    NSString * create2=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS chatHistory_%@(operationId  text PRIMARY KEY,   companyName text, pushMessageContent text , pushTime text , unReadCount text);",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
    BOOL c1= [dataBase executeUpdate:create1];
    BOOL c2= [dataBase executeUpdate:create2];
    
    
    if(c1&&c2){
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
        
    }

    
    
    
  
    [self loadMsg];
    
    
//    UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
//    v.backgroundColor=[UIColor whiteColor];
//    v.tag=123;
//    [self.view addSubview:v];
//    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
//    imageView.image=[UIImage imageNamed:@"wixiaoxi"];
//    
//    
//    [v addSubview:imageView];
//    
//    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
//    
//    label.text=@"空空如也...";
//    label.font=[UIFont systemFontOfSize:19];
//    label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//    
//    label.textAlignment=NSTextAlignmentCenter;
//    
//    [v addSubview:label];

    
    
    
}


-(void)loadMsg{
    NSManagedObjectContext * context=[ChatTool sharedChatTool].msgStorage.mainThreadManagedObjectContext;
    if (context) {
        NSFetchRequest * request=[NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
        NSString * str=[NSString stringWithFormat:@"%@@bagserver",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]];
        NSPredicate * pre=[NSPredicate predicateWithFormat:@"streamBareJidStr = %@",str];
        request.predicate=pre;
        NSSortDescriptor * timeSort=[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
        request.sortDescriptors=@[timeSort];
        _resultsContr=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        NSError * err=nil;
        _resultsContr.delegate=self;
        [_resultsContr performFetch:&err];
        
        
        if (_resultsContr.fetchedObjects.count>0) {
            [self changeMsg];
        }else{
            
           UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
           v.backgroundColor=[UIColor whiteColor];
           v.tag=123;
            [self.view addSubview:v];
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
            imageView.image=[UIImage imageNamed:@"wixiaoxi"];
            
            
            [v addSubview:imageView];
            
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
            
            label.text=@"空空如也...";
            label.font=[UIFont systemFontOfSize:19];
            label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
                        
            label.textAlignment=NSTextAlignmentCenter;
                        
            [v addSubview:label];
        }
        
        
        
        if (err) {
            NSLog(@"%@",err);
        }
        
        
        
    }else{
    
        UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
        v.backgroundColor=[UIColor whiteColor];
        v.tag=123;
        [self.view addSubview:v];
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
        imageView.image=[UIImage imageNamed:@"wixiaoxi"];
        
        
        [v addSubview:imageView];
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
        
        label.text=@"空空如也...";
        label.font=[UIFont systemFontOfSize:19];
        label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label.textAlignment=NSTextAlignmentCenter;
        
        [v addSubview:label];
    
    }
    
}
-(void)changeMsg{
    _categoryTitle=[NSMutableArray new];
    _messageArr=[NSMutableArray new];
    
    _companyNameArr=[NSMutableArray new];
    
    _idArr=[NSMutableArray new];
    _countArr=[NSMutableArray new];
    
    _dateArr=[NSMutableArray new];
    
    _allMessageArr=[NSMutableArray new];
    _totalCountArr=[NSMutableArray new];
    NSString *insertSql=[NSString stringWithFormat:@"insert into chat_%@(categoryId, categoryTitle , commentLevel , commentUserIcon  , commentUserName  , companyName , operationId , pushMessageContent , pushMessageDetailUrl , pushMessageTitle  , pushTime  , subTypeId  , subTypeTitle , target  , targetType ,isRead) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
    
    
    NSInteger count=0;
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSString * userID=[user objectForKey:@"userID"];
    
    NSString * beforeCount=[user objectForKey:[NSString stringWithFormat:@"userID%@",userID]];
    if (beforeCount.length>0) {
        count=[beforeCount integerValue];
    }
    
    
   
    
   
    for (NSInteger i=0; i<_resultsContr.fetchedObjects.count; i++) {
        XMPPMessageArchiving_Message_CoreDataObject * Msg=_resultsContr.fetchedObjects[i];
        
       
        if ([Msg.bareJidStr containsString:@"admin"]) {
            
            
            NSData * data=[Msg.body dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
         
            [_allMessageArr addObject:dic];
            
            
            
            NSLog(@"%@",dic);
        }
        
    }
    
    
    for (NSInteger i=count; i<_resultsContr.fetchedObjects.count; i++) {
       
        XMPPMessageArchiving_Message_CoreDataObject * Msg=_resultsContr.fetchedObjects[i];
        
       
        if ([Msg.bareJidStr containsString:@"admin"]) {
            
        
        NSData * data=[Msg.body dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
  
        
       
        if ([dic[@"operationId"] length]>0) {
        
            
            if (![dic[@"operationId"] isEqualToString:@"c_null"]) {
                
            
        
       [dataBase executeUpdate:insertSql,dic[@"categoryId"],dic[@"categoryTitle"],dic[@"commentLevel"],dic[@"commentUserIcon"],dic[@"commentUserName"],dic[@"companyName"],dic[@"operationId"],dic[@"pushMessageContent"],dic[@"pushMessageDetailUrl"],dic[@"pushMessageTitle"],dic[@"pushTime"],dic[@"subTypeId"],dic[@"subTypeTitle"],dic[@"target"],dic[@"targetType"],@"0"];
            }
          }
    }else{
        NSDate *currentDate = Msg.timestamp;//获取当前时间，日期
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        NSString * uID=[NSString stringWithFormat:@"%@",[[Msg.bareJidStr componentsSeparatedByString:@"@"] firstObject]];
        
        if ([uID isEqualToString:[user objectForKey:@"userID"]]) {
            [dataBase executeUpdate:insertSql,@"",@"2",@"",@"",@"",uID,uID,Msg.body,@"",Msg.body,dateString,@"",@"",@"",@"",@"1"];
        }else{
        [dataBase executeUpdate:insertSql,@"",@"2",@"",@"",@"",uID,uID,Msg.body,@"",Msg.body,dateString,@"",@"",@"",@"",@"0"];
        
        }
        
        
        
      
        
    }
        
        
        [user setObject:[NSString stringWithFormat:@"%lu",(long)_resultsContr.fetchedObjects.count] forKey:[NSString stringWithFormat:@"userID%@",userID]];
        
        
}
    
    NSString * sql1=[NSString stringWithFormat:@"select * from chat_%@ GROUP BY operationId",[user objectForKey:@"userID"]];
    
    FMResultSet *result=[dataBase executeQuery:sql1];
    while(result.next){
        
        NSString * name=[result stringForColumn:@"operationId"];
        
       
        
       
        if (name) {
            [_idArr addObject:name];
        }
        
        
        if ([[result stringForColumn:@"companyName"] length]>0) {
            [_companyNameArr addObject:[result stringForColumn:@"companyName"]];
        }
        NSString * sql2=[NSString stringWithFormat:@"select * from chat_%@ WHERE  operationId = '%@' ",[user objectForKey:@"userID"],name];
        FMResultSet *result2=[dataBase executeQuery:sql2];
        NSMutableArray * arr=[NSMutableArray new];
        NSMutableArray *arr2=[NSMutableArray new];
        NSMutableArray *arr3=[NSMutableArray new];
        while (result2.next) {
            if ([[result2 stringForColumn:@"pushMessageTitle"] length]>0) {
                [arr addObject:[result2 stringForColumn:@"pushMessageTitle"]];
            }
            if ([[result2 stringForColumn:@"pushTime"] length]>0) {
                [arr2 addObject:[result2 stringForColumn:@"pushTime"]];
            }
            if ([[result2 stringForColumn:@"categoryTitle"] length]>0) {
                [arr3 addObject:[result2 stringForColumn:@"categoryTitle"]];
            }
            
        }
        if (arr2.count>0) {
            [_dateArr addObject:[arr2 lastObject]];
        }
        
        if (arr3.count>0) {
            [_categoryTitle addObject:[arr3 lastObject]];
        }
        if (arr.count>0) {
             [_messageArr addObject:[arr lastObject]];
        }
        
       
        
        
        NSString * sql3=[NSString stringWithFormat:@"select count(*) as count from chat_%@ WHERE  operationId = '%@' and  isRead = 0 ",[user objectForKey:@"userID"],name];
        FMResultSet *result3=[dataBase executeQuery:sql3];
        
        while (result3.next) {
            long  unRead = [result3 longForColumn:@"count"];
            [_countArr addObject:[NSString stringWithFormat:@"%ld",unRead]];
        }
        
        NSString * sql4=[NSString stringWithFormat:@"select count(*) as count from chat_%@ WHERE  operationId = '%@' ",[user objectForKey:@"userID"],name];
        FMResultSet *result4=[dataBase executeQuery:sql4];
        
        while (result4.next) {
            long  unRead = [result4 longForColumn:@"count"];
            [_totalCountArr addObject:[NSString stringWithFormat:@"%ld",unRead]];
            
        }
        
    }
    
    
    
    
    
     NSLog(@"a%@",_idArr);
     NSLog(@"b%@",_companyNameArr);
     NSLog(@"c%@",_messageArr);
     NSLog(@"d%@",_dateArr);
     NSLog(@"e%@",_countArr);
    
    for ( int i=0; i<_countArr.count; i++) {
        
        
        
        NSString * sql3=[NSString stringWithFormat:@"select count(*) as count from chatHistory_%@ WHERE  operationId = '%@'",[user objectForKey:@"userID"],_idArr[i]];
        FMResultSet *result3=[dataBase executeQuery:sql3];
        
        while (result3.next) {
            long  unRead = [result3 longForColumn:@"count"];
            if (unRead==0) {
                NSString *insert=[NSString stringWithFormat:@"insert into chatHistory_%@(operationId , companyName , pushMessageContent , pushTime , unReadCount ) values(?,?,?,?,?)",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
                
                [dataBase executeUpdate:insert,_idArr[i],_companyNameArr[i],_messageArr[i],_dateArr[i],_countArr[i]];

            }else{
                
                NSString *updateSql = [NSString stringWithFormat:@"update chatHistory_%@ set companyName = '%@' , pushMessageContent = '%@' , pushTime = '%@', unReadCount = '%@' WHERE operationId='%@'",[user objectForKey:@"userID"],_companyNameArr[i],_messageArr[i],_dateArr[i],_countArr[i],_idArr[i]];
                 [dataBase executeUpdate:updateSql];
               
            }
        }
    
    }
    
    
    _messageArr=[NSMutableArray new];
    
    _companyNameArr=[NSMutableArray new];
    
    _idArr=[NSMutableArray new];
    _countArr=[NSMutableArray new];
    
    _dateArr=[NSMutableArray new];
    
     NSString * SQL=[NSString stringWithFormat:@"select * from chatHistory_%@ ORDER BY pushTime DESC",[user objectForKey:@"userID"]];
    FMResultSet * result6=[dataBase executeQuery:SQL];
    while (result6.next) {
        
        
        [_dateArr  addObject:   [result6 stringForColumn:@"pushTime"]];
        [_companyNameArr addObject:[result6 stringForColumn:@"companyName"]];
        [_countArr addObject:[result6 stringForColumn:@"unReadCount"]];
        [_messageArr addObject:[result6 stringForColumn:@"pushMessageContent"]];
        [_idArr addObject:[result6 stringForColumn:@"operationId"]];
        
    }
   
    if (_companyNameArr.count==0) {
        
    }
    
    [self.messageView reloadData];
    
   }

-(void)deleteUpdate{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSString * sql1=[NSString stringWithFormat:@"select * from chat_%@ GROUP BY operationId",[user objectForKey:@"userID"]];
    
    FMResultSet *result=[dataBase executeQuery:sql1];
    while(result.next){
        
        NSString * name=[result stringForColumn:@"operationId"];
        
        
        
        
        
        [_idArr addObject:name];
        
        if ([[result stringForColumn:@"companyName"] length]>0) {
            [_companyNameArr addObject:[result stringForColumn:@"companyName"]];
        }
        NSString * sql2=[NSString stringWithFormat:@"select * from chat_%@ WHERE  operationId = '%@' ",[user objectForKey:@"userID"],name];
        FMResultSet *result2=[dataBase executeQuery:sql2];
        NSMutableArray * arr=[NSMutableArray new];
        NSMutableArray *arr2=[NSMutableArray new];
        while (result2.next) {
            if ([[result2 stringForColumn:@"pushMessageContent"] length]>0) {
                [arr addObject:[result2 stringForColumn:@"pushMessageContent"]];
            }
            if ([[result2 stringForColumn:@"pushTime"] length]>0) {
                [arr2 addObject:[result2 stringForColumn:@"pushTime"]];
            }
            
            
        }
        [_dateArr addObject:[arr2 lastObject]];
        
        
        
        [_messageArr addObject:[arr lastObject]];
        
        
        NSString * sql3=[NSString stringWithFormat:@"select count(*) as count from chat_%@ WHERE  operationId = '%@' and  isRead = 0 ",[user objectForKey:@"userID"],name];
        FMResultSet *result3=[dataBase executeQuery:sql3];
        
        while (result3.next) {
            long  unRead = [result3 longForColumn:@"count"];
            [_countArr addObject:[NSString stringWithFormat:@"%ld",unRead]];
        }
        
    }
    
    
    
    
    for ( int i=0; i<_countArr.count; i++) {
        
        
        
        NSString * sql3=[NSString stringWithFormat:@"select count(*) as count from chatHistory_%@ WHERE  operationId = '%@'",[user objectForKey:@"userID"],_idArr[i]];
        FMResultSet *result3=[dataBase executeQuery:sql3];
        
        while (result3.next) {
            long  unRead = [result3 longForColumn:@"count"];
            if (unRead==0) {
                NSString *insert=[NSString stringWithFormat:@"insert into chatHistory_%@(operationId , companyName , pushMessageContent , pushTime , unReadCount ) values(?,?,?,?,?)",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
                
                [dataBase executeUpdate:insert,_idArr[i],_companyNameArr[i],_messageArr[i],_dateArr[i],_countArr[i]];
                
            }else{
                NSString *updateSql = [NSString stringWithFormat:@"update chatHistory_%@ set companyName = '%@' , pushMessageContent = '%@' , pushTime = '%@', unReadCount = '%@' WHERE operationId='%@'",[user objectForKey:@"userID"],_companyNameArr[i],_messageArr[i],_dateArr[i],_countArr[i],_idArr[i]];
                [dataBase executeUpdate:updateSql];
                
            }
        }
        
    }
    
    
    _messageArr=[NSMutableArray new];
    
    _companyNameArr=[NSMutableArray new];
    
    _idArr=[NSMutableArray new];
    _countArr=[NSMutableArray new];
    
    _dateArr=[NSMutableArray new];
    
    NSString * SQL=[NSString stringWithFormat:@"select * from chatHistory_%@ ORDER BY pushTime DESC",[user objectForKey:@"userID"]];
    FMResultSet * result6=[dataBase executeQuery:SQL];
    while (result6.next) {
        
        
        [_dateArr  addObject:   [result6 stringForColumn:@"pushTime"]];
        [_companyNameArr addObject:[result6 stringForColumn:@"companyName"]];
        [_countArr addObject:[result6 stringForColumn:@"unReadCount"]];
        [_messageArr addObject:[result6 stringForColumn:@"pushMessageContent"]];
        [_idArr addObject:[result6 stringForColumn:@"operationId"]];
        
    }
    
    [self.messageView reloadData];
    

    
   
    
   



}

-(void)setting:(UIBarButtonItem *)button{
    messageSetViewController * ser=[[messageSetViewController alloc]init];
    
    [self.navigationController pushViewController:ser animated:YES];
//    qiyeMessageViewController * qiye=[[qiyeMessageViewController alloc]init];
//    
//     [self.navigationController pushViewController:qiye animated:YES];
    
  
}

-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _companyNameArr.count;
    
    
//    NSLog(@"%lu",(unsigned long)_idArr.count);
    
//    return _idArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    notifyMessageTableViewCell * cell=[notifyMessageTableViewCell cellWithTableView:tableView];
    
    NSString * userID=_idArr[indexPath.row];
    
    
//    if (indexPath.row==0) {
//        cell.headImageView.image=[UIImage imageNamed:@"image_xitongzhushou@2x"];
//        cell.nameLabel.text=@"系统助手";
//        cell.detailLabel.text=@"班组汇新版本已上线";
//    }else{
//        cell.headImageView.image=[UIImage imageNamed:@"image_qiyexiaomi@2x"];
//        cell.nameLabel.text=@"北京八九点管理咨询有限公司";
//        cell.detailLabel.text=@"测评试题";
//    }
//        cell.timeLabel.text=@"15:50";

    cell.nameLabel.text=_companyNameArr[indexPath.row];
    
    cell.detailLabel.text=_messageArr[indexPath.row];
    
    
    cell.numberLabel.text=_countArr[indexPath.row];
    
    if ([_countArr[indexPath.row] isEqualToString:@"0"]) {
        cell.numberLabel.hidden=YES;
        
        
        
    }else{
       cell.numberLabel.hidden=NO;
    }
    
    cell.headImageView.image=[UIImage imageNamed:@"image_qiyexiaomi@2x"];
    
    
    
    
    
    
    
    
    NSDateFormatter
    *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter
     setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDateFormatter
    *dateFormatter1=[[NSDateFormatter alloc] init];
    
    [dateFormatter1
     setDateFormat:@"HH:mm"];
    
    NSDateFormatter
    *dateFormatter2=[[NSDateFormatter alloc] init];
    
    [dateFormatter2
     setDateFormat:@"MM月dd日"];
    
    NSDateFormatter
    *dateFormatter3=[[NSDateFormatter alloc] init];
    
    [dateFormatter3
     setDateFormat:@"yyyy年MM月dd日"];
    
    
    NSDate*date=[dateFormatter dateFromString:_dateArr[indexPath.row]];
    
  
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    
    
    // 1.获得当前时间的年月日
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    
    
    // 2.获得self的年月日
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    
    if (nowCmps.year == selfCmps.year) {

        if ((selfCmps.year == nowCmps.year) &&
            
            (selfCmps.month == nowCmps.month) &&
            
            (selfCmps.day == nowCmps.day)) {
            
            NSString * str=[dateFormatter1 stringFromDate:date];
            cell.timeLabel.text=str;
        }else{
            
            
            NSString * str=[dateFormatter2 stringFromDate:date];
            cell.timeLabel.text=str;
        }
        
        
    }else{

        NSString * str=[dateFormatter3 stringFromDate:date];
        
        cell.timeLabel.text=str;

        
    }
    

    if ([userID containsString:@"c"]) {
        cell.detailLabel.text=[NSString stringWithFormat:@"[%@]%@",_categoryTitle[indexPath.row],_messageArr[indexPath.row]];
        
    }else{
    
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * Url=[NSString stringWithFormat:@"%@/BagServer/getUserNameAndHeadIconByID.mob?token=%@&chatUserID=%@",URLDOMAIN,[user objectForKey:@"token"],userID];
        
        NSLog(@"%@",Url);
        
      [manager POST:Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          
          cell.nameLabel.text=responseObject[@"userName"];
          
          [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"headIcon"]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
          cell.iconURL=responseObject[@"headIcon"];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          
      }];
    
    }
    
    
    
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.view.frame.size.width*135/2/375;
}
-(void)viewDidLayoutSubviews {
    if ([self.messageView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.messageView setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    if ([self.messageView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.messageView setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    qiyeMessageViewController * qiye=[[qiyeMessageViewController  alloc]init];
    notifyMessageTableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    NSMutableArray * messageArr=[NSMutableArray new];
    
    NSString * ids=_idArr[indexPath.row];
    
    if ([ids containsString:@"c"]) {
        
        for (NSDictionary *subDic in _allMessageArr) {
            if ([subDic[@"operationId"] isEqualToString:ids]) {
                [messageArr addObject:subDic];
            }
        }
        qiye.opID=ids;
        qiye.name=cell.nameLabel.text;
        qiye.allMessage=messageArr;
        [self.navigationController pushViewController:qiye animated:YES];
        
    }else{
        
        
        
        
        ChatViewController * chat=[[ChatViewController alloc]init];
        chat.friendJid=ids;
        chat.name=cell.nameLabel.text;
        chat.headImage=cell.iconURL;
        [self.navigationController pushViewController:chat animated:YES];
        NSString * update = [NSString stringWithFormat:@"UPDATE chat_%@ SET isRead = '1' WHERE operationId = '%@' ",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],ids];
        BOOL isSuccess = [dataBase executeUpdate:update];
        if (isSuccess) {
            NSLog(@"成功");
        }
        
      
      
    
    }
    
    
    
    
    
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return @"删除";
    
}

//是否允许编辑行，默认是YES



-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    //如果是删除
    
    if(editingStyle==UITableViewCellEditingStyleDelete)
        
    {
        

        [_companyNameArr removeObjectAtIndex:indexPath.row];
        
        NSString * str=_idArr[indexPath.row];
        
        NSString * update = [NSString stringWithFormat:@"DELETE FROM chat_%@ ",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
        [dataBase executeUpdate:update];
        
        
        NSString * update1 = [NSString stringWithFormat:@"DELETE FROM chatHistory_%@ ",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
         [dataBase executeUpdate:update1];
        
        NSManagedObjectContext * context=[ChatTool sharedChatTool].msgStorage.mainThreadManagedObjectContext;
       
        
        if ([str containsString:@"c"]) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            
            
            NSString * str1=[NSString stringWithFormat:@"%@@bagserver",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]];
            NSPredicate * pre1=[NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",str1,[NSString stringWithFormat:@"%@@bagserver",@"admin"] ];
            
            fetchRequest.predicate=pre1;
            NSError *error;
            NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
            
            
            for (NSManagedObject *managedObject in items) {
                [context deleteObject:managedObject];
            }
        }else{
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            
            
            NSString * str1=[NSString stringWithFormat:@"%@@bagserver",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]];
            NSPredicate * pre1=[NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",str1,[NSString stringWithFormat:@"%@@bagserver",str] ];
            
            fetchRequest.predicate=pre1;
            NSError *error;
            NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
            
            
            for (NSManagedObject *managedObject in items) {
                [context deleteObject:managedObject];
            }
        }
        
        
        
        
     NSString * a =  [user objectForKey:[NSString stringWithFormat:@"userID%@",[user objectForKey:@"userID"]]];
     NSInteger temp=[a integerValue];
     NSInteger b =  [_totalCountArr[indexPath.row] integerValue];
        
        
        
    [user setObject:[NSString stringWithFormat:@"%ld",(long)(temp-b)] forKey:[NSString stringWithFormat:@"userID%@",[user objectForKey:@"userID"]]];
    
//        [self.messageView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
//        [self deleteUpdate];
//
        
          [self loadMsg];
         [tableView reloadData];
//        if (temp-b==0) {
//            UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
//            v.backgroundColor=[UIColor whiteColor];
//            v.tag=123;
//            [self.view addSubview:v];
//            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
//            imageView.image=[UIImage imageNamed:@"wixiaoxi"];
//            
//            
//            [v addSubview:imageView];
//            
//            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
//            
//            label.text=@"空空如也...";
//            label.font=[UIFont systemFontOfSize:19];
//            label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//            
//            label.textAlignment=NSTextAlignmentCenter;
//            
//            [v addSubview:label];
//        }
        
        
        
    }
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
   
    UIView * view=[self.view viewWithTag:123];
    [view removeFromSuperview];
    view=nil;
    
    [self loadMsg];


}

@end
