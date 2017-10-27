 //
//  BagCollectionViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/7/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "BagCollectionViewController.h"
#import "BagCollectionViewCell.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "NewLoginViewController.h"
#import "PrefixHeader.pch"
#import "UIImageView+WebCache.h"
#import "nonetConViewController.h"
#import "Reachability.h"
#import "ULBCollectionViewFlowLayout.h"
#import "biaoganViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface BagCollectionViewController ()<UICollectionViewDelegateFlowLayout,ULBCollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray * titleArr;
@property(nonatomic,strong)NSMutableArray * headImage;
@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,strong)NSMutableArray * nodeIDArr;
@property(nonatomic,strong)NSString * cate;
@property(nonatomic,strong)NSMutableArray * idArray;
@property(nonatomic,strong)NSMutableArray * conpanyIDARR;
@property(nonatomic,strong)NSMutableArray * nodedetailArr;
@property(nonatomic,strong)UIView * backView;
@end

@implementation BagCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _titleArr=[NSMutableArray new];
    _headImage=[NSMutableArray new];
    _nodeIDArr=[NSMutableArray new];
    _titleArray=[NSMutableArray new];
    _conpanyIDARR=[NSMutableArray new];
    _idArray=[NSMutableArray new];
    
    _nodedetailArr=[NSMutableArray new];
    
    [self loadDATA];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSString * URL=[NSString stringWithFormat:@"%@/BagServer/getStudyNodeList.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    

        if (dic.count!=0) {
            _titleArr=[NSMutableArray new];
            _headImage=[NSMutableArray new];
            
            
            _nodeIDArr =[NSMutableArray new];
            _nodedetailArr=[NSMutableArray new];
            
            for (NSDictionary * Dic in dic) {
                
                [_titleArr addObject:Dic[@"nodeName"]];

                [_headImage addObject:Dic[@"iconURL"]];
                [_nodeIDArr addObject:Dic[@"id"]];
                [_nodedetailArr addObject:Dic[@"nodedetail"]];
                
            }
         
            
           
            
        }
        
        
        
         [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    

    
    self.collectionView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    ULBCollectionViewFlowLayout * la=[[ULBCollectionViewFlowLayout alloc]init];
//    la.footerReferenceSize=CGSizeMake(WIDTH, WIDTH*10/375);
    self.collectionView.alwaysBounceVertical=YES;
    self.collectionView.collectionViewLayout=la;
    
    
    [self.collectionView registerClass:[BagCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    self.collectionView.backgroundView.backgroundColor=[UIColor redColor];
    


    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    
    
    
   
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _titleArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    

    
    
     return 0;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
 
     cell.titlelabel.text=_nodedetailArr[indexPath.section][indexPath.item][@"nodeName"];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
-(UIColor*)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{

    return [UIColor whiteColor];

}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(self.view.frame.size.width/3, 45);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH* 20/375, WIDTH* 20/375, 200, 20)];

  
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
//  label.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:17];
    label.font=[UIFont systemFontOfSize:WIDTH* 15/375];

    NSString *str = [NSString stringWithFormat:@"%@",_titleArr[indexPath.section]];
    label.text = str;
    label.numberOfLines = 0;//根据最大行数需求来设置
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    
    
    label.frame = CGRectMake(WIDTH* 20/375, WIDTH* 30/375, 200, expectSize.height);
    
    [headerView addSubview:label];
    
    
    label.backgroundColor=[UIColor whiteColor];
    UIImageView * image=[[UIImageView alloc]init];
    image.frame=CGRectMake(WIDTH* 13/375,WIDTH *31.5/375,WIDTH* 3/375,WIDTH *15/375);
    image.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    [headerView addSubview:image];
    
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*15/375)];
    view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    [headerView addSubview:view];
    
    UIView * xianView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH* 13/375,WIDTH *59/375,WIDTH* 349/375,1)];
    xianView.backgroundColor=[UIColor colorWithRed:224/255.0 green:233/255.0 blue:240/255.0 alpha:1.0];
    headerView.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:xianView];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0 ,20, WIDTH, WIDTH *60/375-20);
    
    button.tag=indexPath.section;
     [button addTarget:self action:@selector(bagController:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    button.backgroundColor=[UIColor redColor];
    [headerView addSubview:button];
    
   
    
    
    
    return headerView;
}

-(void)bagController:(UIButton*)button{

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * s=[NSString stringWithFormat:@"%@",_nodeIDArr[button.tag]];

    biaoganViewController * all=[[biaoganViewController alloc]init];
    all.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&nodeID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],s];
    [self.navigationController pushViewController:all animated:YES];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];

    NSString * s=[NSString stringWithFormat:@"%@",_nodedetailArr[indexPath.section][indexPath.row][@"id"]];

    biaoganViewController * all=[[biaoganViewController alloc]init];
    all.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&nodeID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],s];
    [self.navigationController pushViewController:all animated:YES];
    

    
    
   
    if ([_cate isEqualToString:@"2"]) {
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"您还不是企业认证用户" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"再看看",@"立即认证", nil];
        
        [av show];
    }
    
    
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 10, 0, 45);
//}


-(void)setDataWith:(NSString *)categary{
//    _titleArr=[NSMutableArray new];
//    _headImage=[NSMutableArray new];
//    _nodeIDArr=[NSMutableArray new];
//    _titleArray=[NSMutableArray new];
//    if ([categary isEqualToString:@"1"]) {
//        _cate=@"1";
//        
//        
//        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
//        
//        NSString * URL=[NSString stringWithFormat:@"%@/BagServer/getStudyObjectList.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
//        
//        [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//         
//            
//            
//            if (dic.count!=0) {
//                for (NSDictionary * Dic in dic) {
//                    
//                    [_titleArr addObject:Dic[@"nodeName"]];
//                    
//                    [_headImage addObject:Dic[@"iconURL"]];
//                    [_nodeIDArr addObject:Dic[@"id"]];
//                }
//                for (int i=0; i<_nodeIDArr.count; i++) {
//                    
//                    
//                    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getNodeList.mob?token=%@&studyObjectID=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],_nodeIDArr[i]];
//                    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//                        
//                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                        
//                        NSMutableArray * name=[NSMutableArray new];
//                        
//                        for (NSDictionary * subDic in dic) {
//                            
//                            [name addObject:subDic[@"nodeName"]];
//                           
//                        }
//                        [_titleArray addObject:name];
//                        
//                        
////                         _titleArray=@[@[@"班组例会",@"质量管理",@"安全生产",@"优质服务"], @[@"明细角色",@"自我管理",@"任务管理"],@[@"成都论坛",@"厦门论坛"]];
//                        
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        
//                    }];
//                }
//                 [self.collectionView reloadData];
//                
//            }
//            
//            
//            
//            
//          
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//        }];
//        
//        
//
//        
//        
//        
//    
//        
//       
//    }else{
//       _cate=@"2";
//             _headImage=[NSMutableArray arrayWithObjects:@"frist",@"second",@"bajiudainguan", nil];
//             _titleArr=[NSMutableArray arrayWithObjects:@"星兵营",@"群英汇",@"八九点知识库",nil];
//        _titleArray=[NSMutableArray arrayWithArray:@[@[@"人际关系",@"人际关系",@"社交礼仪",@"情商管理",@"日常学习" ,@"设厂营销"],@[@"团队建设",@"高效沟通",@"员工辅导",@"班组建设"], @[@"销售市场",@"咨询文案",@"网络技术",@"综合管理",@"通用知识"]]];
//    }

}
-(void)dealloc{
    

}
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    [_backView removeFromSuperview];
    
    _backView=nil;
    
    if (token.length>5) {
        [self shuaxin:nil];
    }else{
    
    
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor whiteColor];
        
        view.tag=12;
        
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
        
        
        imageView.image=[UIImage imageNamed:@"weidengluyemian"];
        
        
        [view addSubview:imageView];
        
        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*175/568, WIDTH, 20)];
        
        label1.text=@"书包目前暂无分类哦~";
        label1.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label1.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label1];
        
        
        
        UILabel * label2=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*205/568, WIDTH, 20)];
        
        label2.text=@"登录后将查看更多知识栏目";
        label2.font=[UIFont systemFontOfSize:WIDTH*16/375];
        label2.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        
        label2.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:label2];
        
        
        
        
        
        
        UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
        chongxin1.frame=CGRectMake(WIDTH *100/320,HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
        
        [chongxin1 setTitle:@"登录" forState:UIControlStateNormal];
        
        chongxin1.layer.cornerRadius=4.5;
        
        
        [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [chongxin1 setBackgroundColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0]];
        
        [chongxin1 addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:chongxin1];
        
        [self.view addSubview:view];
        
    
    }
    
    
    

}
-(void)Login:(UIButton *)button{
    NewLoginViewController * his=[[NewLoginViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    
}
-(void)loadDATA{
    
    
    _titleArr=[NSMutableArray new];
    _headImage=[NSMutableArray new];
    _nodeIDArr=[NSMutableArray new];
    _titleArray=[NSMutableArray new];
    _conpanyIDARR=[NSMutableArray new];
    _idArray=[NSMutableArray new];
    _nodedetailArr=[NSMutableArray new];
    
    
    
    
    
    
  
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"bagcollection"];
    
    NSArray * dict=[NSArray arrayWithContentsOfFile:filePath];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
    
    [_backView removeFromSuperview];
    
    _backView=nil;
    Reachability * wifi=[Reachability reachabilityForLocalWiFi];
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus]==NotReachable&&[conn currentReachabilityStatus]==NotReachable) {
        if (dict.count>0) {
            _titleArr=[NSMutableArray new];
            _headImage=[NSMutableArray new];
            
            
            _nodeIDArr =[NSMutableArray new];
            _nodedetailArr=[NSMutableArray new];
            
        
                for (NSDictionary * Dic in dict) {
                    
                    [_titleArr addObject:Dic[@"nodeName"]];
                    [_headImage addObject:Dic[@"iconURL"]];
                    [_nodeIDArr addObject:Dic[@"id"]];
                    [_nodedetailArr addObject:Dic[@"nodedetail"]];
                    
                }
            
            [self.collectionView reloadData];
            
        }
        else{
        
        
        _backView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        _backView.backgroundColor=[UIColor whiteColor];
        
        UIImageView * wifiImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*8.5/320, HEIGHT*8/568,WIDTH* 15/320, WIDTH* 15/320)];
        wifiImage.image=[UIImage imageNamed:@"icon_wifi_defult_2x"];
        
        
        
        
        
        
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT*35/568)];
        
        topView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        
        
        [topView addSubview:wifiImage];
        
        
        
        
        
        
        UIImageView * jiantou=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 300/320,HEIGHT* 10/568, WIDTH * 8/320,HEIGHT *15/568)];
        
        jiantou.image=[UIImage imageNamed:@"icon_go_defult_2x"];
        [topView addSubview:jiantou];
        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
        
        button.frame=CGRectMake(0, 0, WIDTH, HEIGHT*35/568) ;
        
        
        [button addTarget:self action:@selector(nonetCon:) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:button];
        
        
        
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT*35/568)];
        label.text=@"网络请求失败，请检查您的网络设置";
        label.textColor=[UIColor whiteColor];
        
        label.font=[UIFont systemFontOfSize:16];
        label.textAlignment=NSTextAlignmentCenter;
        [topView addSubview:label];
        
        UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,64+HEIGHT *190/568, WIDTH,HEIGHT *12.5/568)];
        frist.text=@"亲，您的手机网络不太顺畅哦~";
        frist.textAlignment=NSTextAlignmentCenter;
        frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        
        
        [_backView addSubview:frist];
        
        UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
        
        second.text=@"请检查您的手机是否联网";
        
        second.textAlignment=NSTextAlignmentCenter;
        
        second.font=[UIFont systemFontOfSize:15];
        
        second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        
        [_backView addSubview:second];
        
        
        [_backView addSubview:topView];
        
        //    [_backView addSubview:button];
        UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
        chongxin.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
        
        [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
        
        chongxin.layer.cornerRadius=4.5;
        
        
        [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
        
        [chongxin addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_backView addSubview:chongxin];
        
        
        UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320, 64+HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
        big.image=[UIImage imageNamed:@"image_net"];
        
        
        [_backView addSubview:big];
        
        
        [self.view addSubview:_backView];
    }
        
    }else{
        
        if (dict.count>0) {
            
            _titleArr=[NSMutableArray new];
            _headImage=[NSMutableArray new];
            
            
            _nodeIDArr =[NSMutableArray new];
            _nodedetailArr=[NSMutableArray new];
            
            
            for (NSDictionary * Dic in dict) {
                
                [_titleArr addObject:Dic[@"nodeName"]];
                [_headImage addObject:Dic[@"iconURL"]];
                [_nodeIDArr addObject:Dic[@"id"]];
                [_nodedetailArr addObject:Dic[@"nodedetail"]];
                
            }
            
            [self.collectionView reloadData];

            
        }else{
        
        
        }
        
        
      
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        NSString * URL=[NSString stringWithFormat:@"%@/BagServer/getStudyNodeList.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
        
        [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
       
            
            if (dic.count!=0) {
                _titleArr=[NSMutableArray new];
                _headImage=[NSMutableArray new];
                
                
                _nodeIDArr =[NSMutableArray new];
                _nodedetailArr=[NSMutableArray new];
                
                for (NSDictionary * Dic in dic) {
                    
                    [_titleArr addObject:Dic[@"nodeName"]];
                    [_headImage addObject:Dic[@"iconURL"]];
                    [_nodeIDArr addObject:Dic[@"id"]];
                    [_nodedetailArr addObject:Dic[@"nodedetail"]];
                    
                }
                
            
                
                [self.collectionView reloadData];
                NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"bagcollection"];
                [dic writeToFile:filePath atomically:NO];
                
                
            }else{
                
                UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
                view.backgroundColor=[UIColor whiteColor];
                view.tag=12;
                
                
                UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
                
                
                imageView.image=[UIImage imageNamed:@"image_server"];
                
                
                [view addSubview:imageView];
                
                UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
                
                label1.text=@"服务器开小差了~工程师正在召唤它...";
                label1.font=[UIFont systemFontOfSize:18];
                label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
                
                label1.textAlignment=NSTextAlignmentCenter;
                
                [view addSubview:label1];
                
                
                //    UILabel * second=[UILabel alloc]initWithFrame:cg
                
                
                
                UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
                
                second1.text=@"意见";
                
                second1.textAlignment=NSTextAlignmentLeft;
                
                second1.font=[UIFont systemFontOfSize:14];
                
                second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
                
                [view addSubview:second1];
                
                UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
                
                fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
                [fankui setTitle:@"反馈" forState:UIControlStateNormal];
                fankui.titleLabel.font=[UIFont systemFontOfSize:14];
                [view addSubview:fankui];
                
                UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
                
                xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
                
                [view addSubview:xiahua];
                
                
                UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
                chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
                
                [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
                
                chongxin1.layer.cornerRadius=4.5;
                
                
                [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
                
                [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [view addSubview:chongxin1];
                
                [self.view addSubview:view];
                
            }
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (dict.count>0) {
                
                
                _titleArr=[NSMutableArray new];
                _headImage=[NSMutableArray new];
                
                
                _nodeIDArr =[NSMutableArray new];
                _nodedetailArr=[NSMutableArray new];
                
                
                for (NSDictionary * Dic in dict) {
                    
                    [_titleArr addObject:Dic[@"nodeName"]];
                    [_headImage addObject:Dic[@"iconURL"]];
                    [_nodeIDArr addObject:Dic[@"id"]];
                    [_nodedetailArr addObject:Dic[@"nodedetail"]];
                    
                }
                
                [self.collectionView reloadData];
                
                
                
            }else{
                
                
                
                UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
                view.backgroundColor=[UIColor whiteColor];
                
                view.tag=12;
                
                UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
                
                
                imageView.image=[UIImage imageNamed:@"image_server"];
                
                
                [view addSubview:imageView];
                
                UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
                
                label1.text=@"服务器开小差了~工程师正在召唤它...";
                label1.font=[UIFont systemFontOfSize:18];
                label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
                
                label1.textAlignment=NSTextAlignmentCenter;
                
                [view addSubview:label1];
                
                
                //    UILabel * second=[UILabel alloc]initWithFrame:cg
                
                
                
                UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
                
                second1.text=@"意见";
                
                second1.textAlignment=NSTextAlignmentLeft;
                
                second1.font=[UIFont systemFontOfSize:14];
                
                second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
                
                [view addSubview:second1];
                
                UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
                
                fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
                [fankui setTitle:@"反馈" forState:UIControlStateNormal];
                fankui.titleLabel.font=[UIFont systemFontOfSize:14];
                [view addSubview:fankui];
                
                UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
                
                xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
                
                [view addSubview:xiahua];
                
                
                UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
                chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
                
                [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
                
                chongxin1.layer.cornerRadius=4.5;
                
                
                [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
                
                [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [view addSubview:chongxin1];
                
                [self.view addSubview:view];
            }
            
        }];
        
        
        

        
        
        
        
        
        
        
        
    }
    
    
    

}
-(void)shuaxin:(UIButton *) button{
    [_backView removeFromSuperview];
    
    
    _backView=nil;
    
    
    UIView * view1=[self.view viewWithTag:12];
    
    [view1 removeFromSuperview];
    
    view1=nil;
    
    
    
    NSUserDefaults * UserInfo=[NSUserDefaults standardUserDefaults];
    NSString * name=[UserInfo  objectForKey:@"nameStr"];
    NSString * pass = [UserInfo objectForKey:@"passStr"];
    NSString * imie =[UserInfo objectForKey:@"imie"];
    NSString * token=[UserInfo objectForKey:@"token"];
    if (token.length>5) {
        NSDictionary * parameter=@{@"phone":name,@"passwd":pass,@"imei":imie,@"platform":@"ios"};
        
        
        
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/ba/api/login/phone_login",URLDOMAIN];
        [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            if (dic.count>0) {
                if ([dic[@"ret"] isEqualToString:@"passwd_not_match"]) {
                    
                }else{
                    
                    
                    NSData * data=[dic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    
                    NSString * token1=Dic[@"token"];
                    if (Dic.count!=0) {
                        
                        NSUserDefaults *UserInfo = [NSUserDefaults standardUserDefaults];
                        [UserInfo setObject:token1 forKey:@"token"];
                        [UserInfo setObject:Dic[@"companyID"] forKey:@"companyID"];
                        [UserInfo setObject:Dic[@"companyNO"] forKey:@"companyNO"];
                        [UserInfo setObject:Dic[@"openfireDomain"] forKey:@"openfireDomain"];
                        [UserInfo setObject:Dic[@"openfireIP"] forKey:@"openfireIP"];
                        [UserInfo setObject:Dic[@"openfirePort"] forKey:@"openfirePort"];
                        [UserInfo setObject:Dic[@"phoneNum"] forKey:@"phoneNum"];
                        [UserInfo setObject:Dic[@"userID"] forKey:@"userID"];
                        [UserInfo setObject:Dic[@"userNO"] forKey:@"userNO"];
                    }
                }
                
            }
            [self loadDATA];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            
            
            
            UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
            view.backgroundColor=[UIColor whiteColor];
            
            view.tag=12;
            
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
            
            
            imageView.image=[UIImage imageNamed:@"image_server"];
            
            
            [view addSubview:imageView];
            
            UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
            
            label1.text=@"服务器开小差了~工程师正在召唤它...";
            label1.font=[UIFont systemFontOfSize:18];
            label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            
            label1.textAlignment=NSTextAlignmentCenter;
            
            [view addSubview:label1];
            
            
            
            
            
            UILabel * second1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
            
            second1.text=@"意见";
            
            second1.textAlignment=NSTextAlignmentLeft;
            
            second1.font=[UIFont systemFontOfSize:14];
            
            second1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
            
            [view addSubview:second1];
            
            UIButton * fankui=[UIButton buttonWithType:UIButtonTypeSystem];
            
            fankui.frame=CGRectMake(WIDTH/2-30, 64+ HEIGHT * 217.5/568, 30, HEIGHT* 10/568);
            [fankui setTitle:@"反馈" forState:UIControlStateNormal];
            fankui.titleLabel.font=[UIFont systemFontOfSize:14];
            [view addSubview:fankui];
            
            UIView * xiahua=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 64+ HEIGHT * 228.5/568, 30, 1)];
            
            xiahua.backgroundColor=[UIColor colorWithRed:45/255.0 green:143/255.0 blue:245/255.0 alpha:1.0];
            
            [view addSubview:xiahua];
            
            
            UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
            chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
            
            [chongxin1 setTitle:@"重新加载" forState:UIControlStateNormal];
            
            chongxin1.layer.cornerRadius=4.5;
            
            
            [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
            
            [chongxin1 addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [view addSubview:chongxin1];
            
            [self.view addSubview:view];
            
            
            
            
        }];
    }
    
  
    
    
    
    
   

}

//- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
//
//    return [UIColor whiteColor];
//}

-(void)nonetCon:(UIButton *)button{
    
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    
    [self.navigationController pushViewController:no animated:YES];
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//
//    return CGSizeMake(WIDTH,WIDTH* 10/375);
//}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,WIDTH* 60/375);
}
@end
