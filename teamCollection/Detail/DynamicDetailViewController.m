//
//  DynamicDetailViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/4/12.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "studyHistoryCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
#import "biaoganViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface DynamicDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;


@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,strong)NSMutableArray * detailArray;
@property(nonatomic,strong)NSMutableArray * lookArray;
@property(nonatomic,strong)NSMutableArray * timeArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSMutableArray * categoryArray;
@property(nonatomic,strong)NSMutableArray * kpIdArray;

@end

@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    NSString * string=[NSString stringWithFormat:@"%@的动态",[[NSUserDefaults standardUserDefaults] objectForKey:@"Cname"]];
    self.navigationItem.title=string;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)collectionViewLayout:flowLayout];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    
    [self.collectionView registerClass:[studyHistoryCollectionViewCell class] forCellWithReuseIdentifier:@"studyHistoryCollectionViewCell"];
    [self.view addSubview:self.collectionView];

    
    UIButton * collection=[UIButton buttonWithType:UIButtonTypeSystem];
    collection.frame=CGRectMake(0, 64, self.view.frame.size.width/2, 30);
    [collection setTitle:@"我的收藏" forState:UIControlStateNormal];
    [collection addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:collection];
    
    UIButton * share=[UIButton buttonWithType:UIButtonTypeSystem];
    [share setTitle:@"我的分享" forState:UIControlStateNormal];
    share.frame=CGRectMake(self.view.frame.size.width/2, 64, self.view.frame.size.width/2, 30);
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:share];

    share.backgroundColor=[UIColor whiteColor];
    collection.backgroundColor=[UIColor whiteColor];
    
    [self loadData];
    
    
}
-(void)loadData{
    _dataArray=[NSMutableArray new];
    _categoryArray=[NSMutableArray new];
    _kpIdArray=[NSMutableArray new];
    _imageArray=[NSMutableArray new];
    _timeArray=[NSMutableArray new];
    _titleArray=[NSMutableArray new];
    _lookArray=[NSMutableArray new];
    _detailArray=[NSMutableArray new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[user objectForKey:@"responseObject"];
    
    _dataArray=dic[@"shareList"];
  
    if (_dataArray.count>0) {
        
        
               for (NSDictionary * subDic in _dataArray) {
            [_categoryArray addObject:subDic[@"catagoryName"]];
            [_kpIdArray addObject:subDic[@"kpID"]];
            [_imageArray addObject:subDic[@"iconURL"]];
            [_timeArray addObject:subDic[@"releaseTime"]];
            [_titleArray addObject:subDic[@"title"]];
            [_lookArray addObject:subDic[@"readCount"]];
            [_detailArray addObject:subDic[@"summary"]];
        }
        
        
        [self.collectionView reloadData];


    }else{
    
        [_collectionView removeFromSuperview];
        _collectionView=nil;
        
        UIView * v=[[UIView alloc]initWithFrame:self.view.bounds];
        v.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:v];
        UILabel * nilLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0,150, self.view.frame.size.width, 20)];
        nilLabel1.textColor=[UIColor grayColor];
        nilLabel1.textAlignment=NSTextAlignmentCenter;
        //    nilLabel1.text=@"学习无捷径.....";
        
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
        
        
        //    UILabel * second=[UILabel alloc]initWithFrame:cg
        
        
        
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
        
        [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
        
        [chongxin addTarget:self action:@selector(shuaxin:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:chongxin];
        

    
    }
    
}
-(void)shuaxin:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSLog(@"%lu",(unsigned long)_dataArray.count);
    return _dataArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden=@"studyHistoryCollectionViewCell";
    
    studyHistoryCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    [cell.downloadBtn addTarget:self action:@selector(downLoadKnowledge:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor=[UIColor whiteColor];
    
    NSString * str=[NSString stringWithFormat:@"%@",_imageArray[indexPath.row]];
    
    NSURL * url=[NSURL URLWithString:str];
    [cell.mainImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"material_default_pic_2"]];
    cell.detailLabel.text=_detailArray[indexPath.row];
    NSString * string=[NSString stringWithFormat:@"%@",_timeArray[indexPath.row]];
    NSArray * arr=[string componentsSeparatedByString:@" "];
    cell.timeLabel.text=arr[0];
    cell.titleLabel.text=_titleArray[indexPath.row];
    cell.lookTimeLabel.text= [NSString stringWithFormat:@"%@",_lookArray[indexPath.row]]    ;
    cell.categaryLabel.text=_categoryArray[indexPath.row];
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width-20, 110);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 1, 20);
    
}

-(void)collection{

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[user objectForKey:@"responseObject"];
    
    _dataArray=dic[@"collectionList"];
    
    for (NSDictionary * subDic in _dataArray) {
        [_categoryArray addObject:subDic[@"catagoryName"]];
        [_kpIdArray addObject:subDic[@"kpID"]];
        [_imageArray addObject:subDic[@"iconURL"]];
        [_timeArray addObject:subDic[@"releaseTime"]];
        [_titleArray addObject:subDic[@"title"]];
        [_lookArray addObject:subDic[@"readCount"]];
        [_detailArray addObject:subDic[@"summary"]];
    }
    
    
    [self.collectionView reloadData];

}
-(void)share{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSDictionary * dic=[user objectForKey:@"responseObject"];
    
    _dataArray=dic[@"shareList"];
    
    for (NSDictionary * subDic in _dataArray) {
        [_categoryArray addObject:subDic[@"catagoryName"]];
        [_kpIdArray addObject:subDic[@"kpID"]];
        [_imageArray addObject:subDic[@"iconURL"]];
        [_timeArray addObject:subDic[@"releaseTime"]];
        [_titleArray addObject:subDic[@"title"]];
        [_lookArray addObject:subDic[@"readCount"]];
        [_detailArray addObject:subDic[@"summary"]];
    }
    
    
    [self.collectionView reloadData];


}
-(void)Back:(UIBarButtonItem*)buton{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)downLoadKnowledge:(UIButton *)button{
   
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    biaoganViewController * know=[[biaoganViewController alloc]init];
    know.kpId=self.kpIdArray[indexPath.row];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],self.kpIdArray[indexPath.row],@"1080"];
    know.webUrl=str;
    
    [self.navigationController pushViewController:know animated:YES];



}
-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    image.hidden=YES;
}
@end
