//
//  NewFlowerListViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/22.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "NewFlowerListViewController.h"
#import "ULBCollectionViewFlowLayout.h"
#import "NewFlowerListCollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewFlowerListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSString * URL;

@end
static NSString * const reuseIdentifier = @"Flow";

@implementation NewFlowerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"]?[user objectForKey:@"token"]:@"";
    
    self.navigationItem.title=self.NavTitle;
    if ([self.NavTitle isEqualToString:@"他们已经赞赏过"]) {
        _URL=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getAddExampleScoreUsers.mob?token=%@&knowledge_id=%@&company_id=%@&exam_id=%@&currPage=1&pageSize=10",URLDOMAIN,token,self.kpID,self.companyID,self.exampleID];
    }else{
    
        _URL=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getAllPraseUsers.mob?token=%@&currentPage=%@&pagesize=%@&kpID=%@",URLDOMAIN,token,@"0",@"60",self.kpID];
    }
    
    [self loadData];
    UIButton *  button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
}
-(void)Back:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadData{
    _dataArr = [NSMutableArray new];
   
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager POST:_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic=(NSDictionary *)responseObject;
        
        NSLog(@"%@",dic);
        
        if (dic) {
            
            
            
            NSString * status=[NSString stringWithFormat:@"%@",dic[@"status"]];
            int  num=[dic[@"userNum"] intValue];
            if (status.length>0) {
                if ([status isEqualToString:@"0"]) {
                    if (num>0) {
                        NSArray *arr=dic[@"list"];
                        
                        for (NSDictionary * subDic in arr) {
                            [_dataArr addObject:subDic];
                        }
                    
                        
                        NSLog(@"%@",_dataArr);
                   
                        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)collectionViewLayout:layout];
                        self.collectionView.backgroundColor=[UIColor whiteColor];
                        self.collectionView.alwaysBounceVertical=YES;
                        self.collectionView.delegate=self;
                        self.collectionView.dataSource=self;
                        [self.collectionView registerClass:[NewFlowerListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
                        
                        [self.view addSubview:self.collectionView];
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}




#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    
    
    return _dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewFlowerListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:_dataArr[indexPath.row][@"headIcon"]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
    cell.titlelabel.text=_dataArr[indexPath.row][@"userName"];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.view.frame.size.width/6, WIDTH*65/375);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




@end
