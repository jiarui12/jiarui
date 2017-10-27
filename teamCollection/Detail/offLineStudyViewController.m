//
//  offLineStudyViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/2/24.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "offLineStudyViewController.h"
#import "followTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "uploadTableViewCell.h"
#import "MCDownloadManager.h"
#import "MCWiFiManager.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import <MediaPlayer/MediaPlayer.h>
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface offLineStudyViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate>
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * titleArr;
@property(nonatomic,strong)NSMutableArray * ImageArr;
@property(nonatomic,strong)NSMutableArray * detailArr;
@property(nonatomic,strong)NSMutableArray * kpIDArr;
@property (strong, nonatomic) NSMutableArray *urls;

@property(nonatomic,strong)UIView * sectionView;



@end

@implementation offLineStudyViewController
{
NSMutableArray *selectedArr;
}
- (NSMutableArray *)urls
{
    
     NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    
    NSLog(@"%@",[user objectForKey:@"downloadArr"]);
    
    
    if ([[user objectForKey:@"downloadArr"] count]>0) {
        
        NSMutableArray * arr=[NSMutableArray arrayWithArray:[user objectForKey:@"downloadArr"]];
        
        
        if (!_urls) {
            self.urls = [NSMutableArray array];
            NSMutableArray * a=[NSMutableArray new];
            NSMutableArray * b=[NSMutableArray new];
            
            
            for (NSDictionary * subDic in arr) {
                
                NSLog(@"%@",subDic[@"videoSour"][@"INIT"]);
                
                MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:subDic[@"videoSour"][@"INIT"]];
                
              
                
                
                if (receipt.state == MCDownloadStateCompleted) {
                    [b  addObject:subDic];
                    
                }else {
                    [a addObject:subDic];
                }

                
                
                
                
            }
            
            
            
            
            [_urls addObject:a];
            
            [_urls addObject:b];
        }
        return _urls;

    }else{
    
      return nil;
    }
  
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UILabel * nilLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0,150, self.view.frame.size.width, 20)];
    nilLabel1.textColor=[UIColor grayColor];
    nilLabel1.textAlignment=NSTextAlignmentCenter;
    
    nilLabel1.text=@"里面暂无内容哦";
    
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
    
    
    imageView.image=[UIImage imageNamed:@"wixiaoxi"];
    
    
    [self.view addSubview:imageView];
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
    
    label.text=@"空空如也...";
    label.font=[UIFont systemFontOfSize:19];
    label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    
    label.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    
    
    
    
    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
    
    second.text=@"";
    
    second.textAlignment=NSTextAlignmentCenter;
    
    second.font=[UIFont systemFontOfSize:14];
    
    second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    [self.view addSubview:second];
    
    
    
    
    UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
    chongxin.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
    
    [chongxin setTitle:@"返回" forState:UIControlStateNormal];
    
    chongxin.layer.cornerRadius=4.5;
    
    
    [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chongxin setBackgroundColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0]];
    
    [chongxin addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:chongxin];
    
    
    
    self.navigationItem.title=@"离线学习";
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    selectedArr=[[NSMutableArray alloc]init];
    [selectedArr addObject:@"0"];
    [selectedArr addObject:@"1"];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    self.automaticallyAdjustsScrollViewInsets=NO;
   
        if ([[user objectForKey:@"downloadArr"] count]>0) {
            
            
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeCustom];
            button2.frame=CGRectMake(0, 0, 70, 20);
            [button2 setTitle:@"全部删除" forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button2.titleLabel.font=[UIFont systemFontOfSize:15*WIDTH/375];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [button2 addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationItem setRightBarButtonItem:left];
            
            
            self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
            self.tableView.delegate=self;
            self.tableView.dataSource=self;
            self.tableView.sectionFooterHeight=10;
            
            self.tableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
            [self.view addSubview:self.tableView];
            
            MCWiFiManager *wifiManager = [[MCWiFiManager alloc] init];
            [wifiManager scanNetworksWithCompletionHandler:^(NSArray<MCWiFi *> * _Nullable networks, MCWiFi * _Nullable currentWiFi, NSError * _Nullable error) {
                NSLog(@"name:%@ -- mac:%@",currentWiFi.wifiName,currentWiFi.wifiBSSID);
            }];
            
            NSLog(@"网关：%@",[wifiManager getGatewayIpForCurrentWiFi]);
        }else{
            
            
            
        }

    
    
    

   
    
    
    

    
}
-(void)deleteAll:(UIButton *)button{

    
    
    
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"清空所有知识点" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
    
    
    
    


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else{
    
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        
        NSLog(@"%@",self.urls);
        
        
        for (NSArray * dic in self.urls) {
            
            
            for (NSDictionary *subDic in dic) {
                
//                
//                NSLog(@"%@",subDic[@"videoSour"][@"INIT"]);
//                
//                
//                [[MCDownloadManager defaultInstance] removeWithURL:subDic[@"videoSour"][@"INIT"]];
            }
            
            
            
            
        }
        
        
        
                        
        [user setObject:[NSArray new] forKey:@"downloadArr"];
        
     
        
            [_tableView removeFromSuperview];
            _tableView =nil;
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button2.titleLabel.font=[UIFont systemFontOfSize:15*WIDTH/375];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [button2 addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationItem setRightBarButtonItem:left];
        
        
        

    }

}
-(void)shuaxin:(UIButton *)buttton{

    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WIDTH*45/375;
}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

#pragma mark - 自定义分组头
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    //1 自定义头部
    _sectionView=[[UIView alloc] init];
    _sectionView.backgroundColor=[UIColor whiteColor];
    _sectionView.layer.borderWidth=1;
    _sectionView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    // 2 增加按钮
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    if (section==0) {
        [button setTitle:[NSString stringWithFormat:@"缓存中(%lu)",(unsigned long)[_urls[0] count]] forState:UIControlStateNormal];
    }else{
    [button setTitle:[NSString stringWithFormat:@"已缓存(%lu)",(unsigned long)[_urls[1] count]] forState:UIControlStateNormal];
    }
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.frame=CGRectMake(10, 0, WIDTH, WIDTH*45/375);
    button.tag=section;
    button.titleLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
    [button addTarget:self action:@selector(clickTheGroup:) forControlEvents:UIControlEventTouchUpInside];
    [_sectionView addSubview:button];
    
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-WIDTH*45/375, 0, WIDTH*45/375, WIDTH*45/375)];
    
//    image.image=[UIImage imageNamed:@"icon_return_gray"];
    [image setImage:[UIImage imageNamed:@"icon_return_gray"]];
    image.contentMode=UIViewContentModeCenter;
    image.tag=100+section;
    [_sectionView addSubview:image];
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    if ([selectedArr containsObject:string]) {
       [UIView animateWithDuration:0.3 animations:^{
           image.transform=CGAffineTransformMakeRotation(M_PI/2);
       }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            image.transform=CGAffineTransformMakeRotation(0);
        }];
       

    }
    
    //3 添加左边的箭头
    return _sectionView;
    
}
-(void)clickTheGroup:(UIButton *)button{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([selectedArr containsObject:string])
    {
        [selectedArr removeObject:string];
        
       
        
    }
    else
    {
        [selectedArr addObject:string];
      
    }
    
    [_tableView reloadData];
//    UIImageView * image=[self.sectionView viewWithTag:100+button.tag];
//    
//    NSLog(@"%@",image.image);
//    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
//    if ([selectedArr containsObject:string])
//    {
//        
//        
//        image.transform=CGAffineTransformMakeRotation(M_PI/2);
//        image.backgroundColor=[UIColor redColor];
//        
//    }
//    else
//    {
//        
//        image.transform=CGAffineTransformMakeRotation(0);
//        
//        image.backgroundColor=[UIColor blueColor];
//    }
//    

}






-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    uploadTableViewCell * cell=[uploadTableViewCell cellWithTableView:tableView];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.urls[indexPath.section][indexPath.row][@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    
    
    cell.categaryLabel.text=self.urls[indexPath.section][indexPath.row][@"category"];
  
    cell.titleLabel.text =self.urls[indexPath.section][indexPath.row][@"title"] ;
    
    cell.url = self.urls[indexPath.section][indexPath.row][@"videoSour"][@"INIT"];
    cell.delegate = self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.nodeLabel.text=self.urls[indexPath.section][indexPath.row][@"nodeName"];
    if (indexPath.section==1) {
        cell.titleLabel.text = self.urls[indexPath.section][indexPath.row][@"title"];
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
        cell.DetailLabel.text=self.urls[indexPath.section][indexPath.row][@"summary"];
    }else{
    
        cell.progress.hidden=NO;
        cell.percentLabel.hidden=NO;
        cell.uploadStatus.hidden=NO;
    
        cell.DetailLabel.hidden=YES;
    }
    
   
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray * arr=[NSMutableArray arrayWithArray:[user objectForKey:@"downloadArr"]];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
       
        
        
        [[MCDownloadManager defaultInstance] removeWithURL:self.urls[indexPath.section][indexPath.row][@"videoSour"][@"INIT"]];
        [arr removeObject:self.urls[indexPath.section][indexPath.row]];
        
        [user setObject:arr forKey:@"downloadArr"];
        
        if (arr.count>0) {
            
            
            [self refreshData];
        }else{
           
            [_tableView removeFromSuperview];
            _tableView =nil;
            UIButton * button2=[UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button2.titleLabel.font=[UIFont systemFontOfSize:15*WIDTH/375];
            UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button2];
            [button2 addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationItem setRightBarButtonItem:left];
        
        }
        
        
    }
}


-(void)Back:(UIBarButtonItem*)button{
   
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=NO;
    self.navBarBgAlpha=@"1.0";
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([selectedArr containsObject:indexStr]) {
        return [self.urls[section] count];
    }
    
    return 0;
}
- (void)cell:(uploadTableViewCell *)cell didClickedBtn:(UIButton *)btn {
    MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:cell.url];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:receipt.filePath]];
    [vc presentViewController:mpc animated:YES completion:nil];
}
-(void)refreshData{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"downloadArr"] count]>0) {
        
        NSMutableArray * arr=[NSMutableArray arrayWithArray:[user objectForKey:@"downloadArr"]];
        
        
      
            self.urls = [NSMutableArray array];
            NSMutableArray * a=[NSMutableArray new];
            NSMutableArray * b=[NSMutableArray new];
            
            
            for (NSDictionary * subDic in arr) {
                MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:subDic[@"videoSour"][@"INIT"]];
                
                
                
                
                if (receipt.state == MCDownloadStateCompleted) {
                    [b  addObject:subDic];
                    
                }else {
                    [a addObject:subDic];
                }
                
                
            }
            
            
            
            
            [_urls addObject:a];
            
            [_urls addObject:b];
    }
    [_tableView reloadData];

}
@end
