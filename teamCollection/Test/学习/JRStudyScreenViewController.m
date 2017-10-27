//
//  JRStudyScreenViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/2.
//  Copyright © 2017年 八九点. All rights reserved.
//
#import "TheVideoClassViewController.h"
#import "JRStudyScreenViewController.h"
#import "MMComBoBox.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "WKProgressHUD.h"
#import "followTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "nonetConViewController.h"
#import "biaoganViewController.h"
#import "LeftImageTableViewCell.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "OneImageTableViewCell.h"
#import "newSearchViewController.h"
#import "MJRefresh.h"
#import "JRSegmentViewController.h"
#import "introduceKnowledgeViewController.h"
#import "AboutKnowledgeTableViewController.h"
#import "NewCommentListTableViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface JRStudyScreenViewController ()<MMComBoBoxViewDataSource, MMComBoBoxViewDelegate,UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) UIButton *nextPageBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)NSMutableString * ranking;
@property(nonatomic,strong)MMSingleItem *rootItem2;


@property(nonatomic,strong)NSMutableString * tempTitle;

@end

@implementation JRStudyScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"知识列表";
    
    
    
    
    _ranking=[NSMutableString stringWithFormat:@"new"];
//    _nodeID=[NSMutableString stringWithFormat:@""];
//    _nodeName=[NSMutableString stringWithFormat:@"明晰角色"];
    //===============================================Init===============================================
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    self.comBoBoxView.cate=self.categoryID;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIButton * searchBn=[UIButton  buttonWithType:UIButtonTypeCustom];
    searchBn.frame=CGRectMake(0, 0, 20, 20);
    
    [searchBn setImage:[UIImage imageNamed:@"study_search"] forState:UIControlStateNormal];
    
    [searchBn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:searchBn];
    
    [self.navigationItem setRightBarButtonItem:right];
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArray=[NSMutableArray new];
    
    if ([_categoryID isEqualToString:@"1"]) {
       
        
        
          [self loadData];  
    }

    if ([_categoryID isEqualToString:@"2"]) {
        
        
        self.tableView.tableHeaderView=nil;
        [self loadData];
    }
    

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],_dataArray[indexPath.row][@"kp_id"],@"1080"];
    biaoganViewController * detail=[[biaoganViewController alloc]init];
    detail.webUrl=str;
    detail.kpId=_dataArray[indexPath.row][@"kp_id"];
    
    NSString * cate=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"catName"]];

    
     [user setObject:[NSString stringWithFormat:@"%@a%lda%lda%@",_dataArray[indexPath.row][@"kp_id"],indexPath.section,(long)indexPath.row,cate] forKey:@"shuaxin"];
//    [self.navigationController pushViewController:detail animated:YES];
    
    
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
    
    AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
    
    
    NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
    
    a.kpId=_dataArray[indexPath.row][@"kp_id"];
    b.kpID=_dataArray[indexPath.row][@"kp_id"];
    
    
    c.kpID=_dataArray[indexPath.row][@"kp_id"];
    [vc setViewControllers:@[a,b,c]];
    [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
    vc.kpID=_dataArray[indexPath.row][@"kp_id"];
    vc.kTitle=_dataArray[indexPath.row][@"title"];
    vc.kContent=_dataArray[indexPath.row][@"paper"];
    vc.kIconUrl=_dataArray[indexPath.row][@"iconUrl"];
    

    if ([cate isEqualToString:@"微课"]) {
        TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
        
        video.kpId=_dataArray[indexPath.row][@"kp_id"];
        video.kTitle=_dataArray[indexPath.row][@"title"];
        video.kContent=_dataArray[indexPath.row][@"paper"];
        video.kIconUrl=_dataArray[indexPath.row][@"iconUrl"];
        video.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:video animated:YES];
    }else{
    
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString * cate=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"catName"]];
    //    NSString * imag=[NSString stringWithFormat:@"%@",_subArr[indexPath.row][@"img_content"]];
    
    //    NSArray * arr=[imag componentsSeparatedByString:@","];
    
    
    if ([cate isEqualToString:@"微课"]) {
        OneImageTableViewCell * cell=[OneImageTableViewCell cellWithTableView:tableView];
        
        
        NSString *str = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
        cell.DetailLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"paper"]];
        [cell.headImage sd_setImageWithURL:_dataArray[indexPath.row][@"iconUrl"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        cell.categaryLabel.text=[NSString stringWithFormat:@"微课-[%@]",_dataArray[indexPath.row][@"node_name"]];
        
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]];
        cell.categaryLabel.text=@"微课";
        cell.nodeLabel.text=_dataArray[indexPath.row][@"node_name"];
        
        
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str]];
        NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:_keyWord].location, [[noteStr string] rangeOfString:_keyWord].length);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] range:redRange];
        cell.titleLabel.attributedText=noteStr;
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        
        
        
        
        
        CGSize theSize = [[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.flowerImage.frame=CGRectMake(347*WIDTH/375-theSize.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        
        cell.commentLabel.frame=CGRectMake(WIDTH* 10/375, 100*WIDTH/375, cell.flowerImage.frame.origin.x-WIDTH* 15/375 , 10);
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        
        CGSize Size = [[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.commentImage.frame=CGRectMake(cell.flowerImage.frame.origin.x-WIDTH* 24/375-Size.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        
        
        
        
        
        
        
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
        
        return cell;
    }else{
        
        
        LeftImageTableViewCell * cell=[LeftImageTableViewCell cellWithTableView:tableView];
        
        NSString *str = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"title"]];
        cell.titleLabel.text = str;
        cell.titleLabel.numberOfLines = 2;//根据最大行数需求来设置
        cell.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH * 215/375, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [cell.titleLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        
        
        cell.titleLabel.frame = CGRectMake( WIDTH * 149/375, 15, WIDTH * 215/375, expectSize.height);
        
        
        
        cell.DetailLabel.frame=CGRectMake(WIDTH * 149/375, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.width, 35);
        
        
        cell.DetailLabel.text=_dataArray[indexPath.row][@"paper"];
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        cell.flowerLabel.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]];
        
        [cell.OneImage sd_setImageWithURL:_dataArray[indexPath.row][@"iconUrl"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        
        cell.categaryLabel.text=_dataArray[indexPath.row][@"catName"];
        
        
        cell.nodeLabel.text=_dataArray[indexPath.row][@"node_name"];
        
        
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str]];
        NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:_keyWord].location, [[noteStr string] rangeOfString:_keyWord].length);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] range:redRange];
        cell.titleLabel.attributedText=noteStr;
        
        
        
        CGSize theSize = [[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"likeNum"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.flowerImage.frame=CGRectMake(347*WIDTH/375-theSize.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        
        cell.commentLabel.frame=CGRectMake(WIDTH* 10/375, 100*WIDTH/375, cell.flowerImage.frame.origin.x-WIDTH* 15/375 , 10);
        
        cell.commentLabel.text=  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]];
        
        CGSize Size = [[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"comment_count"]]sizeWithFont:[UIFont systemFontOfSize:11*WIDTH/375]constrainedToSize:cell.flowerLabel.frame.size lineBreakMode:cell.flowerLabel.lineBreakMode];
        
        
        
        cell.commentImage.frame=CGRectMake(cell.flowerImage.frame.origin.x-WIDTH* 24/375-Size.width, 98*WIDTH/375,WIDTH *13.5/375, WIDTH *13.5/375);
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
        return cell;
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    

    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 125*WIDTH/375;
}
-(void)loadData{
    
    
    i=1;
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"加载中.." animated:YES];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    if (_keyWord.length==0) {
        _keyWord=[NSMutableString stringWithFormat:@""];
    }
    if (_nodeID.length==0) {
        _nodeID=[NSMutableString stringWithFormat:@""];
    }
    if (_category.length==0) {
        _category=[NSMutableString stringWithFormat:@""];
    }
    
  NSString * url=[NSString stringWithFormat:@"%@/BagServer/getKnowledgeByMap.mob?token=%@&currPage=1&pageSize=10&category=%@&order_by=%@&key_word=%@&node_id=%@",URLDOMAIN,[user objectForKey:@"token"],_category,_ranking,_keyWord,_nodeID];
    
     NSString *encodingString =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",encodingString);
    
    [manager POST:encodingString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud dismiss:YES];
        
        
        
        if ([responseObject[@"knowledge_List"] count]!=0) {
            _dataArray=[NSMutableArray new];
            

            for (NSDictionary * a in responseObject[@"knowledge_List"]) {
                
                [_dataArray addObject:a];
                
            }
            UIView * view=[self.view viewWithTag:2367];
            
            [view removeFromSuperview];
            
            view=nil;
            
            
            [_tableView removeFromSuperview];
            _tableView=nil;
            
            
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104)style:UITableViewStylePlain];
            
            _tableView.delegate=self;
            _tableView.dataSource=self;
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [self.view addSubview:_tableView];
            
            [_tableView reloadData];
            [self setFooterView];
            [self setRefreshView];
            
            
            
            
            
            if (!(_keyWord.length>0)) {
                
                
                
            
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30*WIDTH/375)];
            NSString * cout=[NSString stringWithFormat:@"%@",responseObject[@"totalNumber"]];
            label.text=[NSString stringWithFormat:@"在“%@”分类下，找到%@门课程",_nodeName,cout];
            label.backgroundColor=[UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1.0];
            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:13*WIDTH/375];
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"在“%@”分类下，找到%@个知识",_nodeName,cout]];
            NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:_nodeName].location, [[noteStr string] rangeOfString:_nodeName].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] range:redRange];
            label.attributedText=noteStr;
            
            
            
            
            _tableView.tableHeaderView=label;
            }
            
            
            if ([_categoryID isEqualToString:@"2"]) {
                _tableView.tableHeaderView=nil;
            }
            
            
        }else{
            [_tableView removeFromSuperview];
            _tableView=nil;
            
            UIView * v=[[UIView alloc]initWithFrame:CGRectMake(0, 104, WIDTH,HEIGHT)];
            v.backgroundColor=[UIColor whiteColor];
            v.tag=2367;
            
            [self.view addSubview:v];
         
            
            
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*108/568, WIDTH * 90/320, HEIGHT* 80/568)];
            
            
            imageView.image=[UIImage imageNamed:@"wixiaoxi"];
            
            
            [self.view addSubview:imageView];
            
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*220/568, WIDTH, 20)];
            
            label.text=@"暂无搜索相关结果";
            label.font=[UIFont systemFontOfSize:17];
            label.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            
            label.textAlignment=NSTextAlignmentCenter;
            
            [self.view addSubview:label];
            
            
            
            
            
            UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0,64+ HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
            
            second.text=@"";
            
            second.textAlignment=NSTextAlignmentCenter;
            
            second.font=[UIFont systemFontOfSize:14];
            
            second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
            
            [self.view addSubview:second];
            
            
            
            
         
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
        _backView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        
        _backView.backgroundColor=[UIColor whiteColor];
        
        UIImageView * wifiImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*8.5/320, HEIGHT*8/568,WIDTH* 15/320, WIDTH* 15/320)];
        wifiImage.image=[UIImage imageNamed:@"icon_wifi_defult_2x"];
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, HEIGHT*35/568)];
        
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
        
        [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_backView addSubview:chongxin];
        
        
        UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320, 64+HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
        big.image=[UIImage imageNamed:@"image_net"];
        
        
        [_backView addSubview:big];
        
        
        [self.view addSubview:_backView];
        
    }];
}

-(void)setRefreshView{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    
    
}

-(void)shuaxinle:(UIButton *)button{
    [_backView removeFromSuperview];
    
    _backView =nil;
    [self loadData];
}
-(void)nonetCon:(UIButton *)button{
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    [self.navigationController pushViewController:no animated:YES];
    
    
}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.comBoBoxView dimissPopView];
}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)search:(UIBarButtonItem *)button{
    newSearchViewController * new=[[newSearchViewController alloc]init];
    
    [self.navigationController pushViewController:new animated:NO];


}
#pragma mark - Action


#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                
                
                
                
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
         
           
            
            if ([rootItem.title isEqualToString:@"最新排序"]) {
                
                if ([title isEqualToString:@"热门排序"]) {
                    _ranking=[NSMutableString stringWithString:@"hot"];
                }else{
                    _ranking=[NSMutableString stringWithString:@"new"];
                    
                }
                
                
            }else if ([rootItem.title isEqualToString:@"全部类型"]||[rootItem.title isEqualToString:@"微课"]||[rootItem.title isEqualToString:@"微例"]||[rootItem.title isEqualToString:@"百问"]||[rootItem.title isEqualToString:@"百科"]){
            
                
                
                NSLog(@"%@",title);
                
                
                if ([title isEqualToString:@"微课"]) {
                    
                    _category=[NSMutableString stringWithFormat:@"2"];
                    
                }if ([title isEqualToString:@"微例"]) {
                    _category=[NSMutableString stringWithFormat:@"3"];

                }if ([title isEqualToString:@"百问"]) {
                    _category=[NSMutableString stringWithFormat:@"4"];

                }if ([title isEqualToString:@"百科"]) {
                    _category=[NSMutableString stringWithFormat:@"5"];

                }if ([title isEqualToString:@"全部类型"]) {
                    
                    _category=[NSMutableString stringWithFormat:@""];
                    
                }
            
            
            }else{
            
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                
                NSDictionary * arr=[user objectForKey:@"allNodeList"];

                for (NSDictionary * dic in arr[@"firstNodeListStr"]) {
                    
                    if ([dic[@"map_name"] isEqualToString:title]) {
                        _nodeID=[NSMutableString stringWithFormat:@"%@",dic[@"map_id"]];
                    }
                    
                    
                    
                }
                
                for (NSDictionary * dic in arr[@"secondNodeList"]) {
                    
                    
                    
                    
                    if ([dic[@"map_name"] isEqualToString:title]) {
                        _nodeID=[NSMutableString stringWithFormat:@"%@",dic[@"map_id"]];
                    }
                    
                    for (NSDictionary * subDic in dic[@"thirdNodeList"]) {
                        
                        if ([subDic[@"map_name"] isEqualToString:title]) {
                            
                            
                            
                            
                            
                            _nodeID=[NSMutableString stringWithFormat:@"%@",subDic[@"map_id"]];
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                NSLog(@"nodeID:%@",_nodeID);
                
                if ([title isEqualToString:@"全部知识"]) {
                    _nodeID=[NSMutableString stringWithFormat:@""];
                }
                
                _nodeName=[NSMutableString stringWithFormat:@"%@",title];
            }
            
            
            if (![_tempTitle isEqualToString:title]) {
                _tempTitle=[NSMutableString stringWithFormat:@"%@",title];
                
                
                
                [self loadData];
            }
            
           
            
            
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            break;}
        case MMPopupViewDisplayTypeFilters:{
            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                        
                        
                        
                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                }
                
                
                
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];
            
            break;}
        default:
            break;
    }
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        
        NSLog(@"%@",_secondName);
        
        if (_secondName.length>0) {
            _rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:_secondName];

        }else{
            _rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"全部类型"];

        
        }
        
        if (_category.length>0) {
            if ([_category isEqualToString:@"2"]) {
                if (self.isMultiSelection)
                    _rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
                
               
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected  titleName:[NSString stringWithFormat:@"全部类型"]]];
                
                 [_rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"微课" subtitleName:nil code:nil]];
                
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微例"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百问"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百科"]]];
            } if ([_category isEqualToString:@"3"]) {
                if (self.isMultiSelection)
                    _rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
                

                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected  titleName:[NSString stringWithFormat:@"全部类型"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微课"]]];
                
                [_rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"微例" subtitleName:nil code:nil]];
                
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百问"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百科"]]];
            } if ([_category isEqualToString:@"4"]) {
                if (self.isMultiSelection)
                    _rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
                
               
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected  titleName:[NSString stringWithFormat:@"全部类型"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微课"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微例"]]];
                 [_rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"百问" subtitleName:nil code:nil]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百科"]]];
            } if ([_category isEqualToString:@"5"]) {
                if (self.isMultiSelection)
                    _rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
                
               
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected  titleName:[NSString stringWithFormat:@"全部类型"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微课"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微例"]]];
                [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百问"]]];
                
                 [_rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"百科" subtitleName:nil code:nil]];
                
            }
            
            
            
            
            
            
            
        }else{
            if (self.isMultiSelection)
                _rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
            
            [_rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"全部类型" subtitleName:nil code:nil]];
            [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected  titleName:[NSString stringWithFormat:@"微课"]]];
            [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"微例"]]];
            [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百问"]]];
            [_rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"百科"]]];
        
        }
        
        
        
       
        
        
        MMSingleItem *rootItem3 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"最新排序"];
        
        if (self.isMultiSelection)
            rootItem3.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem3  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"最新排序" subtitleName:nil code:nil]];
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"热门排序"]]];
        
        
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        NSDictionary * arr=[user objectForKey:@"allNodeList"];
        NSArray * arr1=arr[@"firstNodeListStr"];
        NSMutableArray * titleArr=[NSMutableArray new];
        NSMutableArray * idArr=[NSMutableArray new];
        
        if (arr.count>0) {
            for (NSDictionary *dic in arr1 ) {
                [titleArr addObject:dic[@"map_name"]];
                [idArr addObject:dic[@"map_id"]];
            }
        }
        
        
        
        if (!self.nodeName) {
            self.nodeName=[NSMutableString stringWithFormat:@"全部知识"];
        }
        //root 5
        MMMultiItem *rootItem5 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:self.nodeName];
        
        
        
        
        rootItem5.displayType = MMPopupViewDisplayTypeMultilayer;
        rootItem5.numberOflayers = MMPopupViewThreelayers;
     
        
//        NSLog(@"%@",self.categoryID);
        
        MMItem *item5_a = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:@"全部知识" subtitleName:@"全部知识"];
        [rootItem5 addNode:item5_a];
        
        for (int i = 0; i < titleArr.count; i++){
            MMItem *item5_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:titleArr[i] subtitleName:@"全部知识"];
            
            if ([self.categoryID isEqualToString:@"1"]) {
item5_A.isSelected = (i == [self.fristSelect intValue]);
            }else{
            
            }

            
            [rootItem5 addNode:item5_A];
            
            
            MMItem *item5_b = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:@"全部知识" subtitleName:@"全部知识"];
            [item5_A addNode:item5_b];
            for (int j = 0; j < [arr[@"secondNodeList"] count]; j ++) {
                NSString * a=[NSString stringWithFormat:@"%@",arr[@"secondNodeList"][j][@"related_id"]];
                NSString * b=[NSString stringWithFormat:@"%@",arr1[i][@"map_id"]];
                if ([a isEqualToString:b]) {
                
                   

                    
                    MMItem *item5_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",arr[@"secondNodeList"][j][@"map_name"]] subtitleName:[NSString stringWithFormat:@"%@",arr[@"secondNodeList"][j][@"map_id"]]];
                    
                    if ([self.categoryID isEqualToString:@"1"]) {
item5_B.isSelected = (i == [self.fristSelect intValue] && j == [self.secendSelect intValue]);
                    }
                    
                    [item5_A addNode:item5_B];
                    
                    if ([arr[@"secondNodeList"][j][@"thirdNodeList"] count]>0) {
                        MMItem *item5_C = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",@"全部知识"] subtitleName:@"全部知识"];
                        
                        
                        
                        [item5_B addNode:item5_C];
                    }
                    
                    for (int k = 0; k <[arr[@"secondNodeList"][j][@"thirdNodeList"] count]; k++) {
                        MMItem *item5_C = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"%@",arr[@"secondNodeList"][j][@"thirdNodeList"][k][@"map_name"]] subtitleName:[NSString stringWithFormat:@"%@",arr[@"secondNodeList"][j][@"thirdNodeList"][k][@"map_id"]]];
                        
                        
                        if ([self.categoryID isEqualToString:@"1"]) {
                            item5_C.isSelected = (i == [self.fristSelect intValue] && j == [self.secendSelect intValue] && k == -1);
                        }
                        
                        [item5_B addNode:item5_C];
                    }
                    
                }
              
                
                
            }
        }
        
        [mutableArray addObject:rootItem5];
        [mutableArray addObject:_rootItem2];
        [mutableArray addObject:rootItem3];
        
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}
-(void)shuaxin:(UIButton*)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
static int i=1;
-(void)setFooterView{
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        i++;
        [self loadDataWithPage:i];
        [self.tableView reloadData];
        
    }];
    
    self.tableView.mj_footer.automaticallyHidden=YES;
    
}
-(void)loadDataWithPage:(int)page{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/getKnowledgeByMap.mob?token=%@&currPage=%d&pageSize=10&category=%@&order_by=%@&key_word=%@&node_id=%@",URLDOMAIN,[user objectForKey:@"token"],page,_category,_ranking,_keyWord,_nodeID];
    
    
    
    NSString *encodingString =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager POST:encodingString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([responseObject[@"knowledge_List"] count]>0) {
            for (NSDictionary * a in responseObject[@"knowledge_List"]) {
                [_dataArray addObject:a];
                
                
            }
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}
-(void)setKeyWord:(NSMutableString *)keyWord{

    NSLog(@"%@",keyWord);
    self.tableView.tableHeaderView=nil;
    _keyWord=[NSMutableString stringWithFormat:@"%@",keyWord];
    [self loadData];

}
-(void)viewWillAppear:(BOOL)animated{

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * s=[user objectForKey:@"shuaxin"];
    
    
    if (s.length>2) {
        
        
        
        NSArray * arr=[s componentsSeparatedByString:@"a"];
        NSString * cate=arr[3];
        
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        NSString * URL=[NSString stringWithFormat:@"%@/ba/api/index/get_knowlege_comment_like_count?token=%@&knowledgeId=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],arr[0]];
        
        
        NSLog(@"%@",URL);
        
        
        [manager POST:URL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                 
                                                                options:NSJSONReadingMutableContainers
                                 
                                                                  error:nil];
            
            
            
            
            NSLog(@"%@",dic);
            
            if (_dataArray.count>[arr[1] integerValue]) {
                
                
                if (_dataArray.count>0&&[[_dataArray objectAtIndex:[arr[1] integerValue]] count]>0) {
                    
                    //    NSMutableDictionary * subDic=[_subArr objectAtIndex:[arr[1] integerValue]];
                    NSString * like=[NSString stringWithFormat:@"%@",dic[@"likeNum"]];
                    
                    NSString * comment=[NSString stringWithFormat:@"%@",dic[@"commentNum"]];
                    
                    
                    
                    //    [subDic setObject:like forKey:@"likeNum"];
                    //    [subDic setObject:comment forKey:@"comment_count"];
                    
                    if ([cate isEqualToString:@"微课"]) {
                        
                        OneImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
                        cell.flowerLabel.text=like;
                        
                        cell.commentLabel.text=comment;
                        
                        
                    }else{
                        LeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
                        cell.flowerLabel.text=like;
                        
                        cell.commentLabel.text=comment;
                        

                    
                    }
                    
                    
                    
//                    if([cate isEqualToString:@"3"]) {
//                        
//                        LeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
//                        cell.flowerLabel.text=like;
//                        
//                        cell.commentLabel.text=comment;
//                        
//                        
//                    }if([cate isEqualToString:@"4"]) {
//                        
//                        LeftImageTableViewCell * cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr[2] integerValue] inSection:[arr[1] integerValue]]];
//                        cell.flowerLabel.text=like;
//                        
//                        cell.commentLabel.text=comment;
//                        
//                        
//                    }if([cate isEqualToString:@"5"]) {
//                        
//                        
//                    }
                    [user setObject:@"" forKey:@"shuaxin"];
                }
                
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
        
    }


}
@end
