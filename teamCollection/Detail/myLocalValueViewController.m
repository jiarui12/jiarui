//
//  myLocalValueViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/21.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "myLocalValueViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "myLocalValueTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import <CFNetwork/CFNetwork.h>
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"
#import "uploadTableViewCell.h"
#import "OneImageTableViewCell.h"
#import "WKProgressHUD.h"
#import "GCDAsyncSocket.h"
@interface myLocalValueViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * timeDetail;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * headImageArr;
@property(nonatomic,strong)NSMutableArray * titleArr;
@property(nonatomic,strong)NSMutableArray * categaryArr;
@property(nonatomic,strong)NSMutableArray * stateArr;
@property(nonatomic,strong)NSMutableArray * nodeArr;
@property(nonatomic,strong)UITableView * dropDownTab;
@property(nonatomic,strong)NSMutableArray * messageArr;
@property(nonatomic,strong)NSString * identify;
@property(nonatomic,strong)WKProgressHUD * hud;
@property(nonatomic,strong)NSString * iden;
@property(nonatomic,strong)UITableView * tableView1;
@property(nonatomic,strong)UITableView * tableView2;
@property(nonatomic,strong)UITableView * tableView3;
@property(nonatomic,strong)UITableView * tableView4;
@property(nonatomic,strong)AsyncSocket * socketClient;

@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * headImageArr1;
@property(nonatomic,strong)NSMutableArray * titleArr1;
@property(nonatomic,strong)NSMutableArray * categaryArr1;
@property(nonatomic,strong)NSMutableArray * stateArr1;
@property(nonatomic,strong)NSMutableArray * nodeArr1;

@property(nonatomic,strong)NSMutableArray * dataArray2;
@property(nonatomic,strong)NSMutableArray * headImageArr2;
@property(nonatomic,strong)NSMutableArray * titleArr2;
@property(nonatomic,strong)NSMutableArray * categaryArr2;
@property(nonatomic,strong)NSMutableArray * stateArr2;
@property(nonatomic,strong)NSMutableArray * nodeArr2;

@end

@implementation myLocalValueViewController
{
    GCDAsyncSocket     *_asyncSocket;
    NSInteger _pesentLength;
    NSMutableArray * _scokets;
    NSData * _fileData;
}
-(void)loadData{

    
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * token=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getKgListByUpload.mob?token=%@&dataCatagoryType=2",URLDOMAIN,token];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        
        
        _dataArray=(NSMutableArray*)responseObject[@"result"];
        
        
        
        for (NSDictionary * subDic in _dataArray) {
            [_headImageArr addObject:subDic[@"iconURL"]];
            [_titleArr addObject:subDic[@"title"]];
            [_categaryArr addObject:subDic[@"catagoryName"]];
            [_stateArr addObject:subDic[@"status"]];
            [_nodeArr addObject:subDic[@"nodeName"]];
            [_timeDetail addObject:subDic[@"createTime"]];
        }
        
        NSLog(@"%@",_timeDetail);
        
        [_hud dismiss:YES];
        [self.tableView reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_hud dismiss:YES];
        NSLog(@"%@",error);
    }];
    
  [manager GET:[NSString stringWithFormat:@"%@/BagServer/getRealIP.bs?token=%@",URLDOMAIN,token] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSLog(@"上传接口%@",responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"%@",error);
  }];
}
-(void)setprogress{

    [self performSelector:@selector(setUploadProgress:) withObject:[NSNumber numberWithFloat:0.0] afterDelay:0];
    
    [self performSelector:@selector(setUploadProgress:) withObject:[NSNumber numberWithFloat:0.2] afterDelay:1];
    
    [self performSelector:@selector(setUploadProgress:) withObject:[NSNumber numberWithFloat:0.3] afterDelay:3];
    
    [self performSelector:@selector(setUploadProgress:) withObject:[NSNumber numberWithFloat:0.6] afterDelay:4];
    
    [self performSelector:@selector(setUploadProgress:) withObject:[NSNumber numberWithFloat:0.7] afterDelay:5];
    
    [self performSelector:@selector(setUploadProgress:) withObject:[NSNumber numberWithFloat:1.0] afterDelay:8];

}
-(void)setUploadProgress:(NSNumber*)progress{
    uploadTableViewCell * cell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [cell.progress setProgress:[progress floatValue] animated:YES];
    float num=[progress floatValue];
    
    
    cell.percentLabel.text=[NSString stringWithFormat:@"%d%%",(int)([progress floatValue]*100)];
    if (num==0.0) {
         cell.percentLabel.text=@"0%";
    }
    if (num==0.2) {
        cell.percentLabel.text=@"20%";
    }
    if (num==0.3) {
        cell.percentLabel.text=@"30%";
    }
    if (num==0.6) {
        cell.percentLabel.text=@"60%";
    }
    if (num==0.7) {
        cell.percentLabel.text=@"70%";
    }
    if (num==1.0) {
        cell.percentLabel.text=@"100%";
        cell.uploadStatus.text=@"上传完成";
        
//        UILocalNotification * localNoti=[[UILocalNotification alloc]init];
//      
//        
//        
//            localNoti.alertBody=@"上传完成";
//        
//        
//        
//        
//        localNoti.fireDate=[NSDate date];
//        
//        localNoti.soundName=@"default";
//        
//        
//        
//        [UIApplication sharedApplication].applicationIconBadgeNumber=[UIApplication sharedApplication].applicationIconBadgeNumber+1;
//        
//        [[UIApplication sharedApplication]scheduleLocalNotification:localNoti];
        
        
        if (_headImageArr.count>0) {
            
        
        [_headImageArr removeObjectAtIndex:0];
        [_titleArr removeObjectAtIndex:0];
        [_categaryArr removeObjectAtIndex:0];
        [_stateArr removeObjectAtIndex:0];
        [_nodeArr removeObjectAtIndex:0];
        [self.tableView reloadData];
//            [self setprogress];
            
            
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationItem.title=@"查看";
    
    
   UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    _timeDetail=[NSMutableArray new];
    _dataArray=[[NSMutableArray alloc]init];
    _messageArr=[NSMutableArray new];
    _nodeArr=[NSMutableArray new];
    _headImageArr=[NSMutableArray new];
    _titleArr=[NSMutableArray new];
    _categaryArr=[NSMutableArray new];
    _stateArr=[NSMutableArray new];
    
    [self loadData];
    
    UIButton * topButton=[UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame=CGRectMake(0, 64, self.view.frame.size.width, 40);
    [topButton setTitle:@"上传中" forState:UIControlStateNormal];
    topButton.tag=222;
    topButton.titleLabel.font=[UIFont systemFontOfSize:self.view.frame.size.width * 18/375];
    
    [topButton setTitleColor:[UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:1.0] forState:UIControlStateNormal];
   
    [topButton setImage:[UIImage imageNamed:@"icon_arrow_down@2x"] forState:UIControlStateNormal];
    [topButton setImage:[UIImage imageNamed:@"icon_arrow_up@2x"] forState:UIControlStateSelected];
    
    [topButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.view.frame.size.width/2+10, 0, self.view.frame.size.width/2-120)] ;
    [topButton setTitleEdgeInsets:UIEdgeInsetsMake(0, self.view.frame.size.width/2-90, 0, self.view.frame.size.width/2-80)];
    
    [topButton addTarget:self action:@selector(dropdownTab:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 191/255.0, 191/255.0, 191/255.0, 1 });
    topButton.layer.borderWidth=0.5;
    topButton.layer.borderColor=borderColorRef;
    
    
    [self.view addSubview:topButton];
    
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64 +40, self.view.frame.size.width, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    self.tableView1=[[UITableView alloc]initWithFrame:CGRectMake(0, 64 +40, self.view.frame.size.width, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    self.tableView1.delegate=self;
    self.tableView1.dataSource=self;
    [self.view addSubview:self.tableView1];
    self.tableView1.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView1.hidden=YES;
    
    
    self.tableView2=[[UITableView alloc]initWithFrame:CGRectMake(0, 64 +40, self.view.frame.size.width, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    self.tableView2.delegate=self;
    self.tableView2.dataSource=self;
    [self.view addSubview:self.tableView2];
    self.tableView2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView2.hidden=YES;
    
    
    
    self.tableView3=[[UITableView alloc]initWithFrame:CGRectMake(0, 64 +40, self.view.frame.size.width, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    self.tableView3.delegate=self;
    self.tableView3.dataSource=self;
    [self.view addSubview:self.tableView3];
    self.tableView3.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView3.hidden=YES;
    
    
    

    _hud = [WKProgressHUD showInView:self.view withText:@"数据加载中..." animated:YES];
    
    
//    UILocalNotification *localNote = [[UILocalNotification alloc] init];
//    
//    // 2.设置本地通知的内容
//    // 2.1.设置通知发出的时间
//    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
//    // 2.2.设置通知的内容
//    localNote.alertBody = @"在干吗?";
//    // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
//    localNote.alertAction = @"解锁";
//    // 2.4.决定alertAction是否生效
//    localNote.hasAction = NO;
//    // 2.5.设置点击通知的启动图片
//    localNote.alertLaunchImage = @"123Abc";
//    // 2.6.设置alertTitle
//    localNote.alertTitle = @"你有一条新通知";
//    // 2.7.设置有通知时的音效
//    localNote.soundName = @"buyao.wav";
//    // 2.8.设置应用程序图标右上角的数字
//    localNote.applicationIconBadgeNumber = 999;
//    
//    // 2.9.设置额外信息
//    localNote.userInfo = @{@"type" : @1};
//    
//    // 3.调用通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
    
    
}
-(void)dropdownTab:(UIButton*)button{
    
    if (button.selected==YES) {
        UIView * view=[self.view viewWithTag:111];
        [view removeFromSuperview];
        view=nil;
        
        [_dropDownTab removeFromSuperview];
        
        _dropDownTab=nil;
        
        
        button.selected=NO;
    }else{
    
        UIView * backgroudView=[[UIView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height)];
        
        backgroudView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        backgroudView.tag=111;
        
        
        [self.view addSubview:backgroudView];
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
       
        // 连续敲击2次
        tap.numberOfTapsRequired = 1;
        // 需要2根手指一起敲击
        tap.numberOfTouchesRequired = 1;
        
        
        [backgroudView addGestureRecognizer:tap];
        
       
        [tap addTarget:self action:@selector(tapIconView)];
        
        
        
        NSString * text=button.titleLabel.text;
        _dropDownTab=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, self.view.frame.size.width, 160)style:UITableViewStylePlain];
        _dropDownTab.delegate=self;
        _dropDownTab.dataSource=self;
        
        [self.view addSubview:_dropDownTab];
        
        if ([text isEqualToString:@"上传中"]) {
            NSArray * arr=@[@"1",@"2",@"2",@"2"];
            _messageArr=[NSMutableArray arrayWithArray:arr];
            
        }if ([text isEqualToString:@"处理中"]) {
            NSArray * arr=@[@"2",@"1",@"2",@"2"];
            _messageArr=[NSMutableArray arrayWithArray:arr];
            
        }if ([text isEqualToString:@"已发布"]) {
            
            NSArray * arr=@[@"2",@"2",@"1",@"2"];
            _messageArr=[NSMutableArray arrayWithArray:arr];
            
            
        }if ([text isEqualToString:@"待发布"]) {
            
            
            NSArray * arr=@[@"2",@"2",@"2",@"1"];
            _messageArr=[NSMutableArray arrayWithArray:arr];
            
        }
        

        
        
        button.selected=YES;
    }
    
    
    
    
}
-(void)tapIconView{
    [_dropDownTab removeFromSuperview];
    _dropDownTab=nil;
    
    UIView * view=[self.view viewWithTag:111];
    
    [view removeFromSuperview];
    
    view=nil;

    UIButton * button=[self.view viewWithTag:222];
    
    button.selected=NO;
    

}
-(void)viewDidLayoutSubviews {
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}
-(void)Back:(UIBarButtonItem*)button{

    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"liyantang" object:nil];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==_tableView) {
        
        
       return _nodeArr.count;
    
    }else if (tableView==_tableView1) {
        
        return _nodeArr.count;
        
    }else if (tableView==_tableView2) {
        return _nodeArr.count;
    }else if (tableView==_tableView3) {
        return _nodeArr.count;
    }
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_tableView) {
       
        
        
            uploadTableViewCell * cell=[uploadTableViewCell cellWithTableView:tableView];
            [cell.headImage setImageWithURL:[NSURL URLWithString:@"http://bag.89mc.com:8090/bjd/knowledge/img/23ef1153-ca76-4588-b000-d819e7a4a1af.jpg"] placeholderImage:[UIImage imageNamed:@"material_default_pic_2"]];
            cell.titleLabel.text=_titleArr[indexPath.row];
            cell.categaryLabel.text=_categaryArr[indexPath.row];
            if (indexPath.row==0) {
                cell.uploadStatus.text=@"上传中";
            }else{
            
            cell.uploadStatus.text=@"等待中";
            
            }
            cell.progress.progress=0;
            cell.percentLabel.text=@" 0% ";

        
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.nodeLabel.text=_nodeArr[indexPath.row];
            cell.nodeLabel.font=[UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width*14/375];
            return cell;
        
        
    
  
    }else if (tableView==_dropDownTab){
    
    
    
    
    UITableViewCell * cell=[[UITableViewCell alloc]init];
    if (indexPath.row==0) {
        cell.textLabel.text=@"上传中";
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"处理中";
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"已发布";
    }if (indexPath.row==3) {
        cell.textLabel.text=@"待发布";
    }
    
    if ([_messageArr[indexPath.row]isEqualToString:@"1"]) {
        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, 10, 20, 20)];
        image.image=[UIImage imageNamed:@"icon_xialaxuanzhong@2x"];
        
        
        [cell.contentView addSubview:image];
    }
    
    cell.textLabel.font=[UIFont systemFontOfSize:self.view.frame.size.width *16/375];
    cell.textLabel.textColor=[UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0];
    return cell;
    }else if (tableView==_tableView1){
    
                    OneImageTableViewCell * cell=[[OneImageTableViewCell alloc]init];
        
        
                    NSString *str = [NSString stringWithFormat:@"%@",@"时间管理"];
                    cell.titleLabel.text = str;
                    cell.titleLabel.numberOfLines = 0;//根据最大行数需求来设置
                    cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                    CGSize maximumLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 215/375, 9999);//labelsize的最大值
                    //关键语句
                    CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
                    cell.titleLabel.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width * 149/375, 15, [UIScreen mainScreen].bounds.size.width * 215/375, expectSize.height);
        
        
                    cell.DetailLabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y+3, cell.titleLabel.frame.size.width, 35);
                    cell.nodeLabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width* 190/375, 95.5,[UIScreen mainScreen].bounds.size.width * 100/375, 20);
                    cell.nodeLabel.textAlignment=NSTextAlignmentLeft;
                    cell.nodeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];
                    cell.nodeLabel.font=[UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width *14/375];
                    cell.nodeLabel.text=_nodeArr[indexPath.row];
                    cell.DetailLabel.text=[NSString stringWithFormat:@"%@",@"时间管理"];
                    [cell.headImage setImageWithURL:[NSURL URLWithString:@"http://bag.89mc.com:8090/bjd/knowledge/img/ed00bf82-31cc-4446-9ecd-162812842fdd.jpg"]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
                    if (indexPath.row<2) {
                        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*130/375-30, 0, 30, 30)];
                        image.image=[UIImage imageNamed:@"image_new@2x"];
                        [cell.headImage addSubview:image];
                    }
        
        
        
                    cell.videoTimeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
      
                    cell.commentImage.hidden=YES;
                    cell.flowerImage.hidden=YES;
        
                    UILabel * label=[cell.contentView viewWithTag:1000];
                    [label removeFromSuperview];
                    label=nil;
        
                    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width* 285/375, 96.5,[UIScreen mainScreen].bounds.size.width * 80/375, 20)];
                    timeLabel.text=nil;
        
                    timeLabel.tag=1000;
        
        
        
                    if ([[NSString stringWithFormat:@"%@",_stateArr[indexPath.row]]  isEqualToString:@"1"]) {
                        timeLabel.text=@"审核中";
                        timeLabel.textColor=[UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
                    }
                    if ([[NSString stringWithFormat:@"%@",_stateArr[indexPath.row]] isEqualToString:@"2"]) {
                        timeLabel.text=@"转码中";
                        timeLabel.textColor=[UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
                    }
                    if ([[NSString stringWithFormat:@"%@",_stateArr[indexPath.row]] isEqualToString:@"3"]) {
                        timeLabel.text=@"驳回";
                        timeLabel.textColor=[UIColor colorWithRed:237/255.0 green:125/255.0 blue:127/255.0 alpha:1.0];
                    }
                    if ([[NSString stringWithFormat:@"%@",_stateArr[indexPath.row]] isEqualToString:@"4"]) {
                        timeLabel.text=@"审核通过";
                        timeLabel.textColor=[UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
                    }
                    if ([[NSString stringWithFormat:@"%@",_stateArr[indexPath.row]] isEqualToString:@"5"]) {
                        timeLabel.text=@"上传未完成";
                        timeLabel.textColor=[UIColor colorWithRed:237/255.0 green:125/255.0 blue:127/255.0 alpha:1.0];
                    }
                    if ([[NSString stringWithFormat:@"%@",_stateArr[indexPath.row]] isEqualToString:@"6"]) {
                        timeLabel.text=@"后台上传";
                        timeLabel.textColor=[UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
                    }

                    timeLabel.textAlignment=NSTextAlignmentRight;
                    timeLabel.font=[UIFont systemFontOfSize:14];
                    [cell.contentView addSubview:timeLabel];
                    
                    
                    cell.categaryLabel.hidden=NO;
                    cell.categaryLabel.text=_categaryArr[indexPath.row];
                    
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
           }else if (tableView==_tableView2){

                    OneImageTableViewCell * cell=[[OneImageTableViewCell alloc]init];
        
        
                    NSString *str = [NSString stringWithFormat:@"%@",@"时间管理"];
                    cell.titleLabel.text = str;
                    cell.titleLabel.numberOfLines = 0;//根据最大行数需求来设置
                    cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                    CGSize maximumLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 215/375, 9999);//labelsize的最大值
                    //关键语句
                    CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
                    cell.titleLabel.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width * 149/375, 15, [UIScreen mainScreen].bounds.size.width * 215/375, expectSize.height);
        
        
                    cell.DetailLabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y+3, cell.titleLabel.frame.size.width, 35);
                    cell.nodeLabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width* 190/375, 95.5,[UIScreen mainScreen].bounds.size.width * 100/375, 20);
                    cell.nodeLabel.textAlignment=NSTextAlignmentLeft;
                    cell.nodeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];
                    cell.nodeLabel.font=[UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width *14/375];
                    cell.nodeLabel.text=_nodeArr[indexPath.row];
                    cell.DetailLabel.text=[NSString stringWithFormat:@"%@",@"时间管理"];
                    [cell.headImage setImageWithURL:[NSURL URLWithString:@"http://bag.89mc.com:8090/bjd/knowledge/img/ed00bf82-31cc-4446-9ecd-162812842fdd.jpg"]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
               
        
        
        
                    cell.videoTimeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        //            cell.commentLabel.text=@"11";
        //            cell.flowerLabel.text=@"22";
                    cell.commentImage.hidden=YES;
                    cell.flowerImage.hidden=YES;
        
                    UILabel * label=[cell.contentView viewWithTag:1000];
                    [label removeFromSuperview];
                    label=nil;
        
                    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width* 285/375, 96.5,[UIScreen mainScreen].bounds.size.width * 80/375, 20)];
                    timeLabel.text=nil;
        
                    timeLabel.tag=1000;
        
               
               
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
               
               
               NSDate*date=[dateFormatter dateFromString:_timeDetail[indexPath.row]];

               
               
               
               
               
               NSCalendar *calendar = [NSCalendar currentCalendar];
               
               int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
               
               
               
               // 1.获得当前时间的年月日
               
               NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
               
               
               
               // 2.获得self的年月日
               
               NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
               
               if (nowCmps.year == selfCmps.year) {
                   
                   NSLog(@"今年");
                 
                   
                   if ((selfCmps.year == nowCmps.year) &&
                       
                       (selfCmps.month == nowCmps.month) &&
                       
                       (selfCmps.day == nowCmps.day)) {
                       NSLog(@"是今天");
                       NSString * str=[dateFormatter1 stringFromDate:date];
                       timeLabel.text=str;
                   }else{
                       
                       NSLog(@"是今年不是今天");
                       NSString * str=[dateFormatter2 stringFromDate:date];
                       timeLabel.text=str;
                   }
                   
                   
               }else{
               
                  
                   
                   NSLog(@"不是今年");
                   
                   
                   NSString * str=[dateFormatter3 stringFromDate:date];
                   
                   timeLabel.text=str;
                   
//                   NSCalendar *calendar = [NSCalendar currentCalendar];
//                   
//                   int unit = NSCalendarUnitYear;
//                   
//                   
//                   
//                   // 1.获得当前时间的年月日
//                   
//                   NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//                   
//                   
//                   
//                   // 2.获得self的年月日
//                   
//                   NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
                   
                   
                   
                 
               
               
               
               
               }
               
              
               
               
               
               
               
                    timeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];
                    timeLabel.textAlignment=NSTextAlignmentRight;
                    timeLabel.font=[UIFont systemFontOfSize:14];
                    [cell.contentView addSubview:timeLabel];
                    
                    
                    cell.categaryLabel.hidden=NO;
                    cell.categaryLabel.text=_categaryArr[indexPath.row];
                    
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
    }else if (tableView==_tableView3){
    
                    OneImageTableViewCell * cell=[[OneImageTableViewCell alloc]init];
        
                    NSString *str = [NSString stringWithFormat:@"%@",@"时间管理"];
                    cell.titleLabel.text = str;
                    cell.titleLabel.numberOfLines = 0;//根据最大行数需求来设置
                    cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                    CGSize maximumLabelSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 215/375, 9999);//labelsize的最大值
                    //关键语句
                    CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
                    cell.titleLabel.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width * 149/375, 15, [UIScreen mainScreen].bounds.size.width * 215/375, expectSize.height);
        
        
                    cell.DetailLabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y+3, cell.titleLabel.frame.size.width, 35);
                    cell.nodeLabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width* 190/375, 95.5,[UIScreen mainScreen].bounds.size.width * 100/375, 20);
                    cell.nodeLabel.textAlignment=NSTextAlignmentLeft;
                    cell.nodeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];
                    cell.nodeLabel.font=[UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width *14/375];
                    cell.nodeLabel.text=_nodeArr[indexPath.row];
                    cell.DetailLabel.text=[NSString stringWithFormat:@"%@",@"时间管理"];
                    [cell.headImage setImageWithURL:[NSURL URLWithString:@"http://bag.89mc.com:8090/bjd/knowledge/img/ed00bf82-31cc-4446-9ecd-162812842fdd.jpg"]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
                    if (indexPath.row<2) {
                        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*130/375-30, 0, 30, 30)];
                        image.image=[UIImage imageNamed:@"image_new@2x"];
                        [cell.headImage addSubview:image];
                    }
        
        
        
                    cell.videoTimeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        //            cell.commentLabel.text=@"11";
        //            cell.flowerLabel.text=@"22";
                    cell.commentImage.hidden=YES;
                    cell.flowerImage.hidden=YES;
        
                    UILabel * label=[cell.contentView viewWithTag:1000];
                    [label removeFromSuperview];
                    label=nil;
        
                    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width* 285/375, 96.5,[UIScreen mainScreen].bounds.size.width * 80/375, 20)];
                    timeLabel.text=nil;
        
                    timeLabel.tag=1000;
        
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
        
        
        NSDate*date=[dateFormatter dateFromString:_timeDetail[indexPath.row]];
        
        
        
        
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
        
        
        
        // 1.获得当前时间的年月日
        
        NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
        
        
        
        // 2.获得self的年月日
        
        NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
        
        if (nowCmps.year == selfCmps.year) {
            
            NSLog(@"今年");
            
            
            if ((selfCmps.year == nowCmps.year) &&
                
                (selfCmps.month == nowCmps.month) &&
                
                (selfCmps.day == nowCmps.day)) {
                NSLog(@"是今天");
                NSString * str=[dateFormatter1 stringFromDate:date];
                timeLabel.text=str;
            }else{
                
                NSLog(@"是今年不是今天");
                NSString * str=[dateFormatter2 stringFromDate:date];
                timeLabel.text=str;
            }
            
            
        }else{
            
            
            
            NSLog(@"不是今年");
            
            
            NSString * str=[dateFormatter3 stringFromDate:date];
            
            timeLabel.text=str;
            
            //                   NSCalendar *calendar = [NSCalendar currentCalendar];
            //
            //                   int unit = NSCalendarUnitYear;
            //
            //
            //
            //                   // 1.获得当前时间的年月日
            //
            //                   NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
            //
            //
            //
            //                   // 2.获得self的年月日
            //
            //                   NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
            
            
            
            
            
            
            
            
        }
        

        timeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];

                    timeLabel.textAlignment=NSTextAlignmentRight;
                    timeLabel.font=[UIFont systemFontOfSize:14];
                    [cell.contentView addSubview:timeLabel];
        
        
                    cell.categaryLabel.hidden=NO;
                    cell.categaryLabel.text=@"微课";
                    
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_dropDownTab) {
        return 40;
    }
    
    return 125;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        
    
    
    if (indexPath.row==0) {
        
        self.socketClient=[[AsyncSocket alloc]initWithDelegate:self];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * host=[user objectForKey:@"uploadIP"];
        NSInteger port=[[user objectForKey:@"uploadPORT"] integerValue];
        
        
        NSLog(@"%@%ld",host,(long)port);
        
        if ([self.socketClient connectToHost:host onPort:port error:nil]){
            NSLog(@"连接成功");
        
        }
        NSString * path=[user objectForKey:@"path"];
        NSData *fileData=[NSData dataWithContentsOfFile:path];
        NSString * header=[NSString stringWithFormat:@"file&&%@&&%lu",[path lastPathComponent],(unsigned long)fileData.length];
        
        NSData * headerData=[header dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData * allData=[NSMutableData dataWithCapacity:50];
        [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
        
        [self.socketClient writeData:allData withTimeout:-1 tag:0];
        
        
    }
    }else{
        UIView * view=[self.view viewWithTag:111];
        [view removeFromSuperview];
        
        view=nil;
        
        UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
        
        NSString * text=cell.textLabel.text;
        
        UIButton * button=[self.view viewWithTag:222];
        [button setTitle:text forState:UIControlStateNormal];
        [_dropDownTab removeFromSuperview];
        _dropDownTab=nil;
        if ([text isEqualToString:@"上传中"]) {
            _iden=@"2";
            _identify=@"2";
            
            _tableView.hidden=NO;
            _tableView1.hidden=YES;
            _tableView2.hidden=YES;
            _tableView3.hidden=YES;
            
            
            [self.tableView reloadData];
        }if ([text isEqualToString:@"处理中"]) {
            _iden=@"1";
            _identify=@"1";
            _tableView.hidden=YES;
            _tableView1.hidden=NO;
            _tableView2.hidden=YES;
            _tableView3.hidden=YES;
            
            [self.tableView1 reloadData];
        }if ([text isEqualToString:@"已发布"]) {
            _iden=@"2";
            _identify=@"1";
            
            _tableView.hidden=YES;
            _tableView1.hidden=YES;
            _tableView2.hidden=NO;
            _tableView3.hidden=YES;
            
            
            [self.tableView2 reloadData];
        }if ([text isEqualToString:@"待发布"]) {
            _iden=@"2";
            _identify=@"1";
            
            _tableView.hidden=YES;
            _tableView1.hidden=YES;
            _tableView2.hidden=YES;
            _tableView3.hidden=NO;
            
            
            [self.tableView3 reloadData];
        }
     
        UIButton * button1=[self.view viewWithTag:222];
        
        button1.selected=NO;
        
    
    }
    
    
}

-(void)shangchuan{


    _scokets=[NSMutableArray new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * session=[AFHTTPSessionManager manager];
    session.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/shareKnowledgeMoreParam.mob",URLDOMAIN];
    
    
    NSDictionary * dic=@{@"token":[user objectForKey:@"token"],@"title":@"abc",@"flag":@"1",@"content":@"def",@"problem":@"qqqq",@"answer":@"wwww",@"fileURL":@"IMG_1606.MOV",@"type":@"1",@"contentAgo":@"rrrrr",@"contentAfter":@"tttttt",@"mapID":@"1",@"keyWords":@"1,2",@"exampleID":@"1",@"exampleScore":@"5",@"isReplace":@"0"};
    
    
    
    [session POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        
        NSString * host=responseObject[@"ip"] ;
        NSInteger port=[responseObject[@"port"] integerValue];
        NSString * KPID=responseObject [@"kpID"];
        
        NSLog(@"%@%ld",host,(long)port);
        
        
        NSString * path=[user objectForKey:@"videoPath"];
        _fileData=[NSData dataWithContentsOfFile:path];
        
        if (_fileData.length==0) {
            _fileData=[NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
            
        }
        
        
        
        NSFileManager* manager = [NSFileManager defaultManager];
        
        
        
        unsigned long long length = [[manager attributesOfItemAtPath:path error:nil] fileSize];
        NSLog(@"%lu",(unsigned long)length);
        NSLog(@"%@",path);
        
        NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
        
        [forMatter setDateFormat:@"HH:mm:ss yyyy-MM-dd"];
        
        
        NSString * header=[NSString stringWithFormat:@"Content-Length=%lu;filename=%@;sourceid=;kpid=%@;absPath=%@\n",(unsigned long)length,[path lastPathComponent],KPID,[path stringByExpandingTildeInPath]];
        NSLog(@"%@",header);
        
        NSData * headerData=[header dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData * allData=[NSMutableData dataWithCapacity:50];
        [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
        [allData appendData:_fileData];
        _asyncSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _asyncSocket.delegate = self;
        NSError *error = nil;
        [_asyncSocket connectToHost:host onPort:port withTimeout:-1 error:&error];
        
        
        if (error!=nil) {
            NSLog(@"连接失败：%@",error);
        }else{
            NSLog(@"连接成功");
        }
        
        [_asyncSocket writeData:headerData withTimeout:-1 tag:0];
        [_asyncSocket readDataWithTimeout:-1 tag:0];
        
//        _labelUploadInfo=nil;
//        
//        [_labelUploadInfo removeFromSuperview];
//        
//        self.labelUploadInfo=[[UILabel alloc]initWithFrame:CGRectMake(100, 200, 200, 30)];
//        self.labelUploadInfo.text = [NSString stringWithFormat:@"文件大小 %f MB",_fileData.length/1024.00/1024.00];
//        [self.view addSubview:self.labelUploadInfo];
//        
//        
//        _uploadLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 400, 200, 40)];
//        [self.view addSubview:_uploadLabel];
//        
//        
//        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];//初始化条状进度条
//        self.progressView.frame=CGRectMake(100, 400, 100, 10);
//        self.progressView.backgroundColor=[UIColor brownColor];
        
        
//        self.progressView.center = self.view.center;
//        self.progressView.trackTintColor=[UIColor greenColor];
//        
//        self.progressView.progress = 0;//设置进度条进度为50%
//        [self.view addSubview:self.progressView];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    



}




- (void)socket:(GCDAsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError");
    //[self logInfo:FORMAT(@"Client Disconnected: %@:%hu", [sock connectedHost], [sock connectedPort])];
    if (err) {
        NSLog(@"错误报告：%@",err);
    }else{
        NSLog(@"连接工作正常");
    }
    _asyncSocket = nil;
}
-(void)socket:(GCDAsyncSocket*)sock  didWriteDataWithTag:(long)tag
{
    
    
    
//    _uploadLabel.text=[NSString stringWithFormat:@"%f",1.000000];
//    NSLog(@"发送完成!!!%ld",tag);
//    [self.progressView setProgress:1.0];
}
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost");
    //    NSData *writeData = [@"connected\r\n" dataUsingEncoding:NSUTF8StringEncoding];
    //    [sock writeData:writeData withTimeout:-1 tag:0];
    
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"didReadData");
    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length])];
    NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    
    
    
    if(msg)
    {
        NSLog(@"%@",msg);
        if ([msg containsString:@"sourceid"]) {
            NSArray * arr=[msg componentsSeparatedByString:@"="];
//            [self initNetworkCommunication];
            
            NSLog(@"%ld",(long)[arr[2] integerValue]);
            if ([arr[2] integerValue]!=0) {
                
                [_asyncSocket writeData:_fileData withTimeout:-1 tag:0];
                
                
                NSLog(@"文件长度%lu",(unsigned long)_fileData.length);
                
                [_asyncSocket readDataWithTimeout:-1 tag:0];
            }else{
                NSLog(@"文件长度%lu",(unsigned long)_fileData.length);
                [_asyncSocket writeData:_fileData withTimeout:-1 tag:0];
                [_asyncSocket readDataWithTimeout:-1 tag:0];
                
                
                
            }
            
        }
        
        
    }
    else
    {
        NSLog(@"错误");
    }
    [sock readDataWithTimeout:-1 tag:0]; //一直监听网络
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    
    NSLog(@"%lu",(unsigned long)partialLength);
}
-(void)socket:(GCDAsyncSocket*)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    _pesentLength += partialLength;
    
//    float  upload =(float)_pesentLength/_fileData.length;
//    _uploadLabel.text=[NSString stringWithFormat:@"%f",upload];
//    
//    NSLog(@"%f",upload);
//    
//    [self.progressView setProgress:upload];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    NSLog(@"发送完成!");
    _fileData=nil;
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"连接断开了");
    _fileData=nil;
    
    
    NSLog(@"%@",err);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden=YES;
//
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=YES;
    
    
}

-(void)uploadVideo{

    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view
//            [progressView setProgress:uploadProgress.fractionCompleted];
        });
    }completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          if (error) {
                                              NSLog(@"Error: %@", error);
                                          } else {
                                              NSLog(@"%@ %@", response, responseObject);
                                          }
                                      }];
    [uploadTask resume];

}




-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=NO;
}
@end
