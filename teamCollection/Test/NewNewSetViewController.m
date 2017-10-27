//
//  NewNewSetViewController.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewNewSetViewController.h"
#import "NewLoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "OtherTableViewCell.h"
#import "SetViewController.h"
#import "NewSetTableViewCell.h"
#import "SupportViewController.h"
#import "AFNetworking.h"
#import "offLineStudyViewController.h"
#import "CollectionViewController.h"
#import "followViewController.h"
#import "studyCalendarViewController.h"
#import "NewstudyCalendarViewController.h"
#import "studyHistoryViewController.h"
#import "commentListViewController.h"
#import "messageNoticeViewController.h"
#import "CommentViewController.h"
#import "PrefixHeader.pch"
#import "newDetailViewController.h"
#import "followViewController.h"
#import "biaoganViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface NewNewSetViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * nameArr;
@property(nonatomic,strong)NSArray * imageArr;
@property(nonatomic,strong)UIImageView * headView;
@property(nonatomic,strong)UILabel * bigLabel;
@property(nonatomic,strong)UIButton * wenhaoBtn;
@property(nonatomic,strong)UILabel * lvLabel;
@property(nonatomic,strong)UIImageView * bigImageView;
@end

@implementation NewNewSetViewController
-(void)receiveNotificiation:(NSNotification *)no {

    [self loadView2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"ViewController" object:@"zhangsan"];

    UIView * vackVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    vackVIew.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:vackVIew];

    _bigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH *210/375)];
    
    _bigImageView.image=[UIImage imageNamed:@"myimage_background@2x"];
    
    [self.view addSubview:_bigImageView];
    _nameArr=@[@[@"通讯录"],@[@"我的收藏",@"我的评论"],@[@"学习日历",@"离线学习",@"学习历史"],@[@"联系我们"]];
 _imageArr=@[@[@"icon_list_defult"],@[@"icon_collect_defult",@"icon_comment_Deefult",@"icon_questionnaire_defult"],@[@"icon_calendar_defult",@"icon_offline_defult",@"icon_records_defult"],@[@"icon_phone_defult"]];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionFooterHeight=10;
    [_tableView setSeparatorColor:[UIColor colorWithRed:229/255.0  green:236/255.0  blue:241/255.0 alpha:1.0]];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.sectionHeaderHeight=0;
    [_tableView registerNib:[UINib nibWithNibName:@"OtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"other"];
    [self.view addSubview:_tableView];
   
    [self setHeadView];
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    view.tintColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
  
}



-(void)setHeadView{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    UIView * navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    
    
    navView.tag=1234;
    navView.backgroundColor=[UIColor clearColor];
    
    
    
    UIImageView * view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH *230/375)];
    
    view.backgroundColor=[UIColor clearColor];
//    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    button.frame=CGRectMake( 15, 30, 40, 40);
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 22, 20)];
//    [button setImage:[UIImage imageNamed:@"icon_setting_defult"] forState:UIControlStateNormal];
//    
//    [button addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
//    
//    [self.navigationItem setLeftBarButtonItem:left];
    
    
    
//    [navView addSubview:button];
    
    
//    UIButton * meg=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    meg.frame=CGRectMake(self.view.frame.size.width-15-18, 30, 19, 18) ;
//    
//    [meg addTarget:self action:@selector(Message:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [meg setBackgroundImage:[UIImage imageNamed:@"icon_message_defult"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:meg];
//    
//    [self.navigationItem setRightBarButtonItem:right];
    
    
//    [navView addSubview:meg];
    
    
    
    
//    self.navigationItem.title=@"我的";
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH * 30/375],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(-WIDTH*7/375, 6, 20, 18);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_setting_defult"] forState:UIControlStateNormal];
    UIButton *view1 = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20, 30)];
    [view1 addSubview:button1];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:view1];
    [button1 addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
    
    [view1 addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    
   UIButton * rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(WIDTH*7/375, 6, 19, 18);
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_message_defult"] forState:UIControlStateNormal];
    UIButton * b=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 19, 30)];
    [b addSubview:rightButton];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:b];
    
    
    
    
    
    
    [rightButton addTarget:self action:@selector(Message:) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(Message:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH* 10/375, WIDTH, 64)];
    
    label.textColor=[UIColor whiteColor];
    label.text=@"我的";
    label.textAlignment=NSTextAlignmentCenter;
    
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:WIDTH *18/375]];
    [navView addSubview:label];
    
    UIButton * Btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    
    Btn1.frame=CGRectMake(WIDTH*125/375,WIDTH* 111/375, WIDTH*100/375,WIDTH* 30/375);
    
    
    
    
    [Btn1 setTitle:@"登录/注册" forState:UIControlStateNormal];
    [Btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    Btn1.backgroundColor=[UIColor colorWithRed:64/255.0 green:194/255.0 blue:252/255.0 alpha:1.0];
    Btn1.layer.cornerRadius=WIDTH * 4/375;
    
    
    Btn1.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    Btn1.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    Btn1.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    Btn1.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:Btn1.bounds cornerRadius:WIDTH * 4/375];
    
    
    //设置阴影路径
    Btn1.layer.shadowPath = path2.CGPath;
    
    Btn1.tag=30000;
    
    
    
    [Btn1 addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn1];
    Btn1.hidden=YES;
    
    [self.view addSubview:navView];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:navView];
    UIView * abcView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*25/375, HEIGHT*94/667,WIDTH*61.5/375 , WIDTH*61.5/375)];
    
    abcView.layer.cornerRadius=abcView.frame.size.width/2;
    
    abcView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    abcView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    abcView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    abcView.layer.shadowRadius = 5;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:abcView.bounds cornerRadius:abcView.frame.size.width/2];
    
    
    //设置阴影路径
    abcView.layer.shadowPath = path.CGPath;
    
    
    [view addSubview:abcView];
    
    view.userInteractionEnabled=YES;
    view.tag=119;
    _headView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*25/375, HEIGHT*94/667,WIDTH*61.5/375 , WIDTH*61.5/375)];
    _headView.image=[UIImage imageNamed:@"班组汇图标"];
    _headView.layer.cornerRadius=_headView.frame.size.width/2;
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 199/255.0, 234/255.0, 249/255.0, 1 });
    _headView.layer.borderWidth=WIDTH*1/375;
    _headView.layer.borderColor=borderColorRef;
   
//    _headView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    _headView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
//    _headView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//    _headView.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.headView.bounds cornerRadius:_headView.frame.size.width/2];
//    
//
//    //设置阴影路径
//    _headView.layer.shadowPath = path.CGPath;
    
    _headView.clipsToBounds=YES;
    
   
    
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    
    NSString *documentsPath =documentsDirectory;
    
    
    NSString * save=[NSString stringWithFormat:@"%@/1.png",documentsPath];
    
    NSURL * url=[NSURL fileURLWithPath:save];
    NSData * data=[NSData dataWithContentsOfURL:url];
    if ( data) {
        _headView.image=[UIImage imageWithData:data];
        
        
        
        [_headView setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImageViewURL"]]];
        
    }else{
        
        [_headView setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImageViewURL"]]];
        
    }
    
    [view addSubview:_headView];
    
    UIButton * userDetail =[UIButton buttonWithType:UIButtonTypeSystem];
    userDetail.frame=CGRectMake(WIDTH*25/375, HEIGHT*94/667,WIDTH*61.5/375 , WIDTH*61.5/375);
    userDetail.backgroundColor=[UIColor clearColor];
    userDetail.layer.cornerRadius=userDetail.frame.size.width/2;
    [userDetail addTarget:self action:@selector(toDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:userDetail];
    
    
    
    
    
    UILabel * nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(HEIGHT*105/667,HEIGHT*98/667, WIDTH, 20)];
    
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.textAlignment=NSTextAlignmentLeft;
    
    
    nameLabel.tag=4321;
    
    UIButton * Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    
    Btn.frame=CGRectMake(WIDTH*125/375,WIDTH* 175/375, WIDTH*125/375,WIDTH* 30/375);
    
    Btn.tag=23456;
    UILabel * Lbale=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*38/375, 0, WIDTH*87/375, WIDTH* 30/375)];
    
    Lbale.text=@"企业已认证";
    Lbale.textAlignment=NSTextAlignmentLeft;
    
    
    
    
    
    
    
    
    
    Lbale.font=[UIFont systemFontOfSize:WIDTH* 13/375];
    
    Lbale.textColor=[UIColor whiteColor];
    [Btn addSubview:Lbale];
    
    UIImageView * renImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *14/375, WIDTH*8/375, WIDTH *14/375, WIDTH *14/375)];
    renImage.image=[UIImage imageNamed:@"icon_qiye_defult@2x"];
    
    [Btn addSubview:renImage];
    
    
    Btn.backgroundColor=[UIColor colorWithRed:64/255.0 green:194/255.0 blue:252/255.0 alpha:1.0];
    Btn.layer.cornerRadius=WIDTH * 4/375;
    
    
    Btn.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    Btn.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    Btn.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    Btn.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:Btn.bounds cornerRadius:WIDTH * 4/375];
    
    
    //设置阴影路径
    Btn.layer.shadowPath = path1.CGPath;

    
    
    
    
    [Btn addTarget:self action:@selector(qurenzheng:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
  
    
    nameLabel.text=[user objectForKey:@"userName"];
    
    
    
    UIView * progressView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*130/375,WIDTH* 148/375, WIDTH*355/750, WIDTH*4/375)];
    
    progressView.tag=2367;
    UIView * liangView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH*170/375,WIDTH* 148/375-WIDTH*0.75/375 , WIDTH *5.5/375, WIDTH *5.5/375)];
    liangView.tag=2233;
    liangView.layer.cornerRadius=WIDTH *5.5/375/2;
  
    liangView.backgroundColor=[UIColor colorWithRed:255/255.0 green:247/255.0 blue:235/255.0 alpha:1.0];
    
    
    liangView.layer.shadowColor = [UIColor whiteColor].CGColor;//shadowColor阴影颜色
    liangView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    liangView.layer.shadowOpacity = 1;//阴影透明度，默认0
    liangView.layer.shadowRadius = 3;//阴影半径，默认3
    
//    路径阴影
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:liangView.bounds cornerRadius:WIDTH *5.5/375/2];
    
    
    //设置阴影路径
    liangView.layer.shadowPath = path3.CGPath;
    
    
    
   
    
    
    
    
    
    UIColor *colorOne = [UIColor colorWithRed:(255/255.0)  green:(225/255.0)  blue:(153/255.0)  alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(255/255.0)  green:(96/255.0)  blue:(0/255.0)  alpha:1.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil ,nil];
    
    
    
    NSArray *locations = @[@(0.0f) ,@(1.0f)];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = progressView.bounds;
    
    headerLayer.startPoint = CGPointMake(0, 1);
    headerLayer.endPoint = CGPointMake(1, 1);
    headerLayer.cornerRadius=WIDTH*4/375/2;
    [progressView.layer insertSublayer:headerLayer atIndex:0];
    [view addSubview:progressView];
    [view addSubview:liangView];
    
    NSString * progress=[user objectForKey:@"abcProgress"];
    if (progress.length>0) {
        
    
    
    float abc=[progress floatValue];
    [liangView setFrame:CGRectMake(WIDTH*130/375+ WIDTH*355/750*abc, WIDTH* 148/375-WIDTH*0.75/375, WIDTH *5.5/375, WIDTH *5.5/375)];
    
    }
    
//    UILabel * renzheng=[[UILabel alloc]initWithFrame:CGRectMake(0,WIDTH *167/375,WIDTH, 20)];
//    renzheng.text=@"您已是认证企业";
//    renzheng.font=[UIFont systemFontOfSize:WIDTH *14/375];
//    renzheng.textColor=[UIColor whiteColor];
//    renzheng.textAlignment=NSTextAlignmentCenter;
//    [view addSubview:renzheng];
   
    NSLog(@"企业ID:%@",[user objectForKey:@"companyID"]);
    
    
    
    
    if ([[user objectForKey:@"companyID"]isEqualToString:@"-1"]) {
       
        Lbale.text=@"企业未认证";
        
        Lbale.textColor=[UIColor whiteColor];
        
    }
    
    
    
    
    
    /*  整个的大标签  */
    _bigLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *105/375 ,WIDTH* 122/375, self.view.frame.size.height/2, 20)];
    
     _bigLabel.font=[UIFont systemFontOfSize:WIDTH* 13/375];
    
    [view addSubview:_bigLabel];
    
    
    
    
    _lvLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *105/375, WIDTH*142.5/375, WIDTH*30/375, WIDTH*15/375)];
    NSString * current = [NSString stringWithFormat:@"%@",[user objectForKey:@"curLevelNum"]]  ;
    _lvLabel.text=[NSString stringWithFormat:@"V%@",current];
    NSMutableAttributedString * allStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"V%@",current]];
    NSRange one=NSMakeRange(0, 1);
    NSRange two=NSMakeRange(1, [[allStr string] rangeOfString:current].length);

    [allStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"BodoniMT-Bold" size:WIDTH * 16.5/375],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.0 green:203/255.0 blue:21/255.0 alpha:1.0]} range:one];
    [allStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"BodoniMT-Bold" size:WIDTH *10/375],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.0 green:203/255.0 blue:21/255.0 alpha:1.0]} range:two];
    [_lvLabel setAttributedText:allStr];
    [view addSubview:_lvLabel];
    _bigLabel.text=[NSString stringWithFormat:@"标杆排行 %@  积分 %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalRanking"],[[NSUserDefaults standardUserDefaults]objectForKey:@"totalIntegral"] ];
    
    _bigLabel.textColor=[UIColor whiteColor];
    
    CGSize size = [_bigLabel.text sizeWithAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:WIDTH* 13/375]}];
    _wenhaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _wenhaoBtn.frame=CGRectMake(WIDTH*108/375+size.width+2,WIDTH* 124/375,WIDTH* 15/375, WIDTH* 15/375);
    [_wenhaoBtn setBackgroundImage:[UIImage imageNamed:@"xiaowenhao"] forState:UIControlStateNormal];
    [_wenhaoBtn addTarget:self action:@selector(jifenDetail:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_wenhaoBtn];
    
    
    

    
    [view addSubview:nameLabel];
    
 
    self.tableView.tableHeaderView=view;
    
    
    
}
-(void)toDetail:(UIButton *)button{
    
    
    NSString * userName=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"companyID"]];
    
    NSString * token=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    
    if (token.length>8) {
        
    
    
    if ([userName isEqualToString:@"-1"]) {
        
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未进行企业认证" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else{
        
       
        newDetailViewController * detail=[[newDetailViewController alloc]init];
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    }else{
    
        [self Login:nil];
    }
    
}
-(void)Message:(UIButton*)button{
//    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//   
//    biaoganViewController * detail=[[biaoganViewController alloc]init];
//    
//    detail.webUrl=[NSString stringWithFormat:@"%@/WeChat/myInfoWarn.wc?state=%@S%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"]];
//  
//    [self.navigationController pushViewController:detail animated:YES];
    
    
    NSString * token=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    if (token.length>8) {
        
        messageNoticeViewController * massage=[[messageNoticeViewController alloc]init];
        massage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:massage animated:YES];
        
    }else{
        
        [self Login:nil];
    }
    

}

-(void)jifenDetail:(UIButton*)button{

    biaoganViewController * b=[[biaoganViewController alloc]init];
    b.webUrl=[NSString stringWithFormat:@"%@/WeChat/getIntegralHistory.wc?state=%@S%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],[[NSUserDefaults standardUserDefaults] objectForKey:@"companyID"]];
    b.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:b animated:YES];
}
-(void)qurenzheng:(UIButton*)button{
    
//    UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"学习顾问为您详细介绍" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [av show];
    
}
-(void)set:(UIButton *)button{
    
    NSString * token=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    if (token.length>8) {
    
        SetViewController * set=[[SetViewController alloc]init];
        set.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:set animated:YES];
    
    }else{
    
        [self Login:nil];
    }
    
    
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewSetTableViewCell * cell=[ NewSetTableViewCell cellWithTableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.headImage.image=[UIImage imageNamed:_imageArr[indexPath.section][indexPath.row]];
    cell.nameLabel.text=_nameArr[indexPath.section][indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_nameArr[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{return 0;}


-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 13, 0, 0)];
    }
}



-(void)viewWillAppear:(BOOL)animated{
    
    [self loadView1];

    
}
-(void)loadView2{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _headView.image=[UIImage imageNamed:@"weidenglutouxiang@2x"];
    });
    
    _bigLabel.hidden=YES;
    
    _lvLabel.hidden=YES;
    _wenhaoBtn.hidden=YES;
    
    UILabel * label=[self.view viewWithTag:4321];
    
    label.hidden=YES;
    
    UIView * view1=[self.view viewWithTag:2367];
    
    view1.hidden=YES;
    
    UIView * View=[self.view viewWithTag:2233];
    View.hidden=YES;
    
    UIButton * Btn1=[self.view viewWithTag:23456];
    
    Btn1.hidden=YES;
    UIButton * Btn=[self.view viewWithTag:30000];
    
    Btn.hidden=NO;
    



}
-(void)loadView1{

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//    self.navigationController.navigationBarHidden=YES;
    self.navBarBgAlpha=@"0.0";

    if ([[user objectForKey:@"token"] length]>5) {
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        NSString * URL=[NSString stringWithFormat:@"%@/BagServer/userHonorInfo.mob",URLDOMAIN];
        
        
        
        
        
        NSDictionary * parameters=@{@"token":[user objectForKey:@"token"]};
        
        
        [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if (dic.count!=0) {
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                
                
                [user setObject:dic[@"curLevelNum"] forKey:@"curLevelNum"];
                [user setObject:dic[@"totalIntegral"] forKey:@"totalIntegral"];
                [user setObject:[NSString stringWithFormat:@"%@",dic[@"totalRanking"]] forKey:@"totalRanking"];
                [user setObject:dic[@"headIconUrl"] forKey:@"headImageViewURL"];
                
                float cur=[dic[@"curLevelNum"] floatValue];
                float totle=[dic[@"levelTotalNum"] floatValue];
                
                float progress  =cur/totle;
                [user setObject:[NSString stringWithFormat:@"%f",progress] forKey:@"abcProgress"];
                
                
                _bigLabel.text=[NSString stringWithFormat:@"标杆排行 %@  积分 %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalRanking"],[[NSUserDefaults standardUserDefaults]objectForKey:@"totalIntegral"] ];
                
                _bigLabel.textColor=[UIColor whiteColor];
                
                _bigLabel.font=[UIFont systemFontOfSize:WIDTH* 13/375];
                
                
                NSString *s=[NSString stringWithFormat:@"%@",dic[@"curLevelNum"]];
                
                _lvLabel.text=[NSString stringWithFormat:@"V%@",s];
                
                
                NSMutableAttributedString * allStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"V%@",s ]];
                NSRange one=NSMakeRange(0, 1);
                NSRange two=NSMakeRange(1, [[allStr string] rangeOfString:s ].length);
                
                [allStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"BodoniMT-Bold" size:WIDTH * 16.5/375],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.0 green:203/255.0 blue:21/255.0 alpha:1.0]} range:one];
                [allStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"BodoniMT-Bold" size:WIDTH *10/375],NSForegroundColorAttributeName:[UIColor colorWithRed:248/255.0 green:203/255.0 blue:21/255.0 alpha:1.0]} range:two];
                
                
                [_lvLabel setAttributedText:allStr];
                
        CGSize size = [_bigLabel.text sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:WIDTH* 13/375]}];
                
                _wenhaoBtn.frame=CGRectMake(WIDTH* 108/375+size.width+2, WIDTH* 124/375,WIDTH* 15/375, WIDTH* 15/375);
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *documentsPath =documentsDirectory;
                NSString * save=[NSString stringWithFormat:@"%@/1.png",documentsPath];
                
                NSURL * url=[NSURL fileURLWithPath:save];
                NSData * data=[NSData dataWithContentsOfURL:url];
                if (data) {
                    [_headView setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImageViewURL"]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
                }else{
                    [_headView setImageWithURL:[NSURL URLWithString:[user objectForKey:@"headImageViewURL"]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
                }
                
                
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        
        _headView.image=[UIImage imageNamed:@"weidenglutouxiang@2x"];
        _bigLabel.hidden=YES;
        
        _lvLabel.hidden=YES;
        _wenhaoBtn.hidden=YES;
        
        UILabel * label=[self.view viewWithTag:4321];
        
        label.hidden=YES;
        
        UIView * view1=[self.view viewWithTag:2367];
        
        view1.hidden=YES;
        
        UIView * View=[self.view viewWithTag:2233];
        View.hidden=YES;
        
        UIButton * Btn1=[self.view viewWithTag:23456];
        
        Btn1.hidden=YES;
        
        UIButton * Btn=[self.view viewWithTag:30000];
        
        Btn.hidden=NO;
        
        
        
       
        
        
        
        
        
        
//        UIView * view=[[UIView alloc]initWithFrame:self.view.bounds];
//        view.backgroundColor=[UIColor whiteColor];
//        
//        view.tag=12;
//        
//        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 114/320, 64+HEIGHT*78/568, WIDTH * 90/320, HEIGHT* 80/568)];
//        
//        
//        imageView.image=[UIImage imageNamed:@"weidengluyemian"];
//        
//        
//        [view addSubview:imageView];
//        
//        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+HEIGHT*190/568, WIDTH, 20)];
//        
//        label1.text=@"请登录后查看";
//        label1.font=[UIFont systemFontOfSize:18];
//        label1.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//        
//        label1.textAlignment=NSTextAlignmentCenter;
//        
//        [view addSubview:label1];
//        

//        
//        UIButton*chongxin1=[UIButton buttonWithType:UIButtonTypeCustom];
//        chongxin1.frame=CGRectMake(WIDTH *100/320,64+ HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
//        
//        [chongxin1 setTitle:@"登录" forState:UIControlStateNormal];
//        
//        chongxin1.layer.cornerRadius=4.5;
//        
//        
//        [chongxin1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        [chongxin1 setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
//        
//        [chongxin1 addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [view addSubview:chongxin1];
//        
//        [self.view addSubview:view];
//        
        
        
    }

}
-(void)Login:(UIButton *)button{
    NewLoginViewController * his=[[NewLoginViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    if ([[user objectForKey:@"token"] length]>5) {
        
    
    
    
    if (indexPath.section==0) {
        
        
        biaoganViewController * c=[[biaoganViewController alloc]init];

        
         c.webUrl=[NSString stringWithFormat:@"%@/BagServer/contact/addressList.html?token=%@",URLDOMAIN,[user objectForKey:@"token"]];
        c.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:c animated:YES];
        
        

    }if (indexPath.section==1) {
        
        
        if (indexPath.row==0) {
            CollectionViewController * c=[[CollectionViewController alloc]init];
            c.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:c animated:YES];
        }  if (indexPath.row==1) {
            commentListViewController * c=[[commentListViewController alloc]init];
            c.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:c animated:YES];
        }  
        
        
    }if (indexPath.section==2) {
        if (indexPath.row==0) {
            NewstudyCalendarViewController * c=[[NewstudyCalendarViewController alloc]init];
            c.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:c animated:YES];
        }
        
        if (indexPath.row==1) {
            offLineStudyViewController * off=[[offLineStudyViewController alloc]init];
            off.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:off animated:YES];
            
        }  if (indexPath.row==2) {
            studyHistoryViewController * c=[[studyHistoryViewController alloc]init];
            c.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:c animated:YES];
        }if (indexPath.row==3) {
            followViewController  * c=[[followViewController alloc]init];
            c.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:c animated:YES];
        }
        
    }if (indexPath.section==3) {
        SupportViewController * support=[[SupportViewController alloc]init];
        support.hidesBottomBarWhenPushed=YES;

        [self.navigationController pushViewController:support animated:YES];
        
    }
    }else{
    
    
        [self Login:nil];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex==1) {
        
        NSString *number = @"4006501308";
        
        
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


    
        CGFloat  offy=scrollView.contentOffset.y;
        CGFloat  alpha=offy/10.00;
    
    if (offy>0) {
        UIView * view=[self.view viewWithTag:1234];
        view.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:alpha];
        
        CGRect rect = _bigImageView.frame;
        rect.size.height = WIDTH*210/375;
        rect.size.width = WIDTH ;
        rect.origin.x = 0;
        rect.origin.y = -offy;
        _bigImageView.frame = rect;
        
    }else if(offy<0){
       
        CGRect rect = _bigImageView.frame;
        rect.size.height = WIDTH *210/375-offy;
        rect.size.width = WIDTH* ((WIDTH *210/375-offy)/(WIDTH *210/375));
        rect.origin.x =  -(rect.size.width-WIDTH)/2;
        rect.origin.y = 0;
        _bigImageView.frame = rect;
    }
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return WIDTH*45/375;
}

@end
