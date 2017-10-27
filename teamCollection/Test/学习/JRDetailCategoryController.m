//
//  JRDetailCategoryController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/4/26.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "JRDetailCategoryController.h"
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
#import "JRStudyScreenViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface  JRDetailCategoryController()<UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray * titleArr;
@property(nonatomic,strong)NSMutableArray * headImage;
@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,strong)NSMutableArray * nodeIDArr;
@property(nonatomic,strong)NSString * cate;
@property(nonatomic,strong)NSMutableArray * idArray;
@property(nonatomic,strong)NSMutableArray * conpanyIDARR;
@property(nonatomic,strong)NSMutableArray * nodedetailArr;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)NSMutableString * mpid;
@property(nonatomic,strong)NSMutableString * imageURL;
@property(nonatomic,strong)NSString * fristSelect;

@end

@implementation JRDetailCategoryController

static NSString * const reuseIdentifier = @"Cell";

-(void)receiveNotificiation:(NSNotification *)ntif{
    
    
    _mpid=[NSMutableString stringWithFormat:@"%@",ntif.userInfo[@"mpid"]];
    _fristSelect=[NSString stringWithFormat:@"%@",ntif.userInfo[@"index"]];
    [self loadDATA];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _titleArr=[NSMutableArray new];
    _headImage=[NSMutableArray new];
    _nodeIDArr=[NSMutableArray new];
    _titleArray=[NSMutableArray new];
    _conpanyIDARR=[NSMutableArray new];
    _idArray=[NSMutableArray new];
    
    _nodedetailArr=[NSMutableArray new];
    _mpid=[NSMutableString stringWithFormat:@"%@",@"2"];
    [self loadDATA];
    
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"refreshStudy" object:nil];
    
    self.collectionView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    ULBCollectionViewFlowLayout * la=[[ULBCollectionViewFlowLayout alloc]init];
    self.collectionView.alwaysBounceVertical=YES;
    self.collectionView.collectionViewLayout=la;
    
    
    [self.collectionView registerClass:[BagCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    
    
    
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    
    
    
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if ([_titleArr count]>0) {
        
        
        
        return [_titleArr count];

    }else{
    
    return 0;
    }

    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.titlelabel.text=_titleArr[indexPath.item];
    cell.contentView.layer.cornerRadius=4;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(104 * WIDTH/375,WIDTH* 36/375);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    headerView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
  
    
        
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(20*WIDTH/375, 20*WIDTH/375,238*WIDTH/375,WIDTH* 100/375)];
    
    
        
    
    [image sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
//    image.image=[UIImage imageNamed:@"BANNER1"];
    
    image.layer.cornerRadius=4;
    image.layer.masksToBounds=YES;
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    
    
    button.frame=CGRectMake(20*WIDTH/375, 20*WIDTH/375,238*WIDTH/375,WIDTH* 100/375);
    
    [button addTarget:self action:@selector(tapAvatarView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    button.tag=indexPath.section;
    
    [headerView addSubview:image];
    
    [headerView addSubview:button];
    
    return headerView;
}
-(void)tapAvatarView:(UIButton*)g{

    JRStudyScreenViewController * all=[[JRStudyScreenViewController alloc]init];
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * String1=[NSString stringWithFormat:@"%da%da%d",[_fristSelect intValue]+1,0,-1];
    [user setObject:String1 forKey:@"selectedArray"];
    
    
    
    //    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    //
    //    NSString * s=[NSString stringWithFormat:@"%@",_nodedetailArr[indexPath.section][indexPath.row][@"id"]];
    
    //    biaoganViewController * all=[[biaoganViewController alloc]init];
    //    all.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&nodeID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],s];
    
    all.nodeName=[NSMutableString stringWithFormat:@"%@",_nodedetailArr[g.tag]];
    all.secendSelect=[NSString stringWithFormat:@"%d",-1];
    all.nodeID=[NSMutableString stringWithFormat:@"%@",_idArray[g.tag]];
    all.categoryID=[NSString stringWithFormat:@"1"];
    all.fristSelect=[NSString stringWithFormat:@"%ld",[self.fristSelect integerValue]];
    
    all.hidesBottomBarWhenPushed=YES;
    
    
    [self.navigationController pushViewController:all animated:YES];

}
-(void)bagController:(UIButton*)button{
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * s=[NSString stringWithFormat:@"%@",_nodeIDArr[button.tag]];
    
    biaoganViewController * all=[[biaoganViewController alloc]init];
    all.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&nodeID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],s];
    all.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:all animated:YES];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JRStudyScreenViewController * all=[[JRStudyScreenViewController alloc]init];
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * String1=[NSString stringWithFormat:@"%da%lda%d",[_fristSelect intValue]+1,(long)indexPath.item+1,-1];
    [user setObject:String1 forKey:@"selectedArray"];

    
    
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    
//    NSString * s=[NSString stringWithFormat:@"%@",_nodedetailArr[indexPath.section][indexPath.row][@"id"]];
    
//    biaoganViewController * all=[[biaoganViewController alloc]init];
//    all.webUrl=[NSString stringWithFormat:@"%@/WeChat/nolimitNodeKPList.wc?userID=%@&companyID=%@&platform=ios&nodeID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],s];
    
    all.nodeName=[NSMutableString stringWithFormat:@"%@",_titleArr[indexPath.item]];
    all.secendSelect=[NSString stringWithFormat:@"%ld",(long)indexPath.item];
    all.nodeID=[NSMutableString stringWithFormat:@"%@",_nodeIDArr[indexPath.row]];
    all.categoryID=[NSString stringWithFormat:@"1"];
    all.fristSelect=[NSString stringWithFormat:@"%ld",[self.fristSelect integerValue]];
    all.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:all animated:YES];
    
    
    
    
    if ([_cate isEqualToString:@"2"]) {
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"您还不是企业认证用户" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"再看看",@"立即认证", nil];
        
        [av show];
    }
    
    
}





-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    [_backView removeFromSuperview];
    
    _backView=nil;
    
    if (token.length>8) {
        
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
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
  NSDictionary * dic = [user objectForKey:@"allNodeList"];
    
    NSArray * arr=dic[@"secondNodeList"];
    
    NSArray * Arr=dic[@"firstNodeListStr"];
 
    
    
    
    [_backView removeFromSuperview];
    
    _backView=nil;
    
        if (arr.count>0&&Arr.count>0) {
            
            
            
            
            _titleArr=[NSMutableArray new];
            
            
            _nodeIDArr =[NSMutableArray new];
            
            
            for (NSDictionary * subDic  in arr) {
                
                if ([[NSString stringWithFormat:@"%@",subDic[@"related_id"]] isEqualToString:_mpid]) {
                    
                    [_titleArr addObject:subDic[@"map_name"]];
                    [_nodeIDArr addObject:subDic[@"map_id"]];
                    
                }
                
                
                
            }
            
            for (NSDictionary * subDic in Arr) {
                
                if ([[NSString stringWithFormat:@"%@",subDic[@"map_id"]] isEqualToString:_mpid]) {
                    _imageURL=[NSMutableString stringWithFormat:@"%@",subDic[@"bag_img_url"]];
                    
                    
                    [_idArray addObject:subDic[@"map_id"]];
                    [_nodedetailArr addObject:subDic[@"map_name"]];
                }
                
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
    
    
    
    
    
    if (name.length>5&&token.length>8) {
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
                    
                    if (data) {
                        
                    
                    
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
            }
            [self loadDATA];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            
            
                       
            
            
            
        }];
    }
    
    
    
    
    
    
    
    
}



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
    
      return CGSizeMake(WIDTH/2-70,WIDTH* 120/375);
    
}

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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20 *WIDTH/375,20 *WIDTH/375 , 15 *WIDTH/375, 20 *WIDTH/375);
}
@end
