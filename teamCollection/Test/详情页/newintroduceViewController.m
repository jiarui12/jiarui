//
//  newintroduceViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/30.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "newintroduceViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "UIImageView+WebCache.h"
#import "newWeiKeTableViewCell.h"
#import "Reachability.h"
#import "nonetConViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface newintroduceViewController ()<UITableViewDelegate,UITableViewDataSource,UnfoldDelegate>
@property(nonatomic,strong)NSMutableArray * imageArr;
@property(nonatomic,strong)UIView * background;
@property(nonatomic,strong)NSString * zongfen;
@property(nonatomic,strong)NSString * shangde;
@property(nonatomic,strong)NSString * exampleId;
@property(nonatomic,strong)NSMutableArray * headImageArr;
@property(nonatomic,strong)NSMutableArray * AllImageArr;
@property(nonatomic,strong)NSString * companyID;
@property(nonatomic,assign)NSInteger addScoreTimes;
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UILabel * flowerLabel;
@property(nonatomic,assign)CGFloat contentHeight;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * detailStr;
@property(nonatomic,assign)BOOL zhankai;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIActivityIndicatorView * activityIndicatorView;
@end

@implementation newintroduceViewController

-(void)receiveNotificiation1:(NSNotification*)n{
    
    
    _flowerLabel.text=[NSString stringWithFormat:@"%ld",[_flowerLabel.text integerValue]+1];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    
    [center addObserver:self selector:@selector(receiveNotificiation1:) name:@"shuaxindianzan" object:nil];
    
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.frame=CGRectMake(WIDTH/2-22, WIDTH/3, 44, 44);
    
    [self.view addSubview:self.activityIndicatorView];
    
    
    
    [self.activityIndicatorView startAnimating];
    if ([self isExistenceNetwork]) {
        [self loadData];
 
    }else{
    
        [self.activityIndicatorView stopAnimating];

        [self loadNoWifi];
    
    }
    
    
}
-(void)loadData{
   
    
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppGetKonwledgeDetail.mob?token=%@&knowledge_id=%@",URLDOMAIN,[userInfo objectForKey:@"token"],self.parameter];
    
    
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dic);
        
        [self.activityIndicatorView stopAnimating];

        
        if ([dic count]>0) {
            
            if ([dic[@"knowledge"] count]>0) {
                
                NSArray  * subDic=(NSArray *)dic[@"knowledge"];
                        UIView *imgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/750)];
                        imgView.backgroundColor=[UIColor whiteColor];
                      
              
                        UILabel * titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(12*WIDTH/375, 21*WIDTH/375,WIDTH, 16*WIDTH/375)];
                        
                        titleLabel.text=[NSString stringWithFormat:@"%@",[subDic firstObject][@"knowledge_title"]];
                
                
                titleLabel.font=[UIFont systemFontOfSize:17*WIDTH/375];

                titleLabel.numberOfLines=2;
                
                titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                CGSize maximumLabelSize = CGSizeMake(WIDTH * 351/375, 9999);//labelsize的最大值
                //关键语句
                CGSize expectSize = [titleLabel sizeThatFits:maximumLabelSize];
                
                
                
                
                titleLabel.frame=CGRectMake(12*WIDTH/375, 21*WIDTH/375,expectSize.width, expectSize.height);
                
                        [imgView addSubview:titleLabel];
                
                

                
                UIImageView * headView=[[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTH/375, expectSize.height+31*WIDTH/375, 24*WIDTH/375, 24*WIDTH/375)];
                headView.layer.cornerRadius=12*WIDTH/375;
                
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
                headView.layer.borderWidth=0.5;
                headView.layer.borderColor=borderColorRef;
                
                headView.layer.masksToBounds=YES;
                [headView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[subDic firstObject][@"image_host"],[subDic firstObject][@"head_portrait"]]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
                
                [imgView addSubview:headView];
                
                
                UILabel * nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(42*WIDTH/375, expectSize.height+31*WIDTH/375, 60, 24*WIDTH/375)];
                
                        nameLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
                        
                        nameLabel.font=[UIFont systemFontOfSize:12*WIDTH/375];
                        nameLabel.text=[NSString stringWithFormat:@"%@",[subDic firstObject][@"userName"]];
                        [imgView addSubview:nameLabel];
                        
                        NSString *theText = [NSString stringWithFormat:@"%@",[subDic firstObject][@"userName"]];
                        
                        CGSize theStringSize = [theText sizeWithFont:[UIFont systemFontOfSize:12*WIDTH/375]
                                                   constrainedToSize:nameLabel.frame.size
                                                       lineBreakMode:nameLabel.lineBreakMode];
                        
                        
                UILabel * categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 54/375+theStringSize.width,expectSize.height+35*WIDTH/375, 30*WIDTH/375, 17)];
                
                        
                        
                        
                        CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
                        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                        CGColorRef borderColorRef1 = CGColorCreate(colorSpace1,(CGFloat[]){ 41/255.0, 180/255.0, 237/255.0, 1 });
                        
                        categaryLabel.layer.borderColor=borderColorRef1;
                        categaryLabel.layer.cornerRadius=5;
                        
                        categaryLabel.textAlignment=NSTextAlignmentCenter;
                        categaryLabel.layer.borderWidth=0.5;
                        categaryLabel.textColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
                        categaryLabel.text=[NSString stringWithFormat:@"%@",[subDic firstObject][@"catName"]];
                        
                        
                        categaryLabel.font=[UIFont systemFontOfSize:WIDTH* 11/375];
                        
                        [imgView addSubview:categaryLabel];
                        
                        
                        
                        
                        
                        
                        
                        
                        
                UILabel * studyNum=[[UILabel alloc]initWithFrame:CGRectMake(0, expectSize.height+31*WIDTH/375, WIDTH*363/375 , 24*WIDTH/375)];
                
                        
                        studyNum.font=[UIFont systemFontOfSize:12*WIDTH/375];
                        studyNum.text=[NSString stringWithFormat:@"%@人学过",[subDic firstObject][@"watchNum"]];
                        
                        
                        studyNum.textAlignment=NSTextAlignmentRight;
                        [imgView addSubview:studyNum];
                        studyNum.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
                        
                        
                        CGSize theSize = [[NSString stringWithFormat:@"%@人学过",[subDic firstObject][@"watchNum"]] sizeWithFont:[UIFont systemFontOfSize:12*WIDTH/375]
                                                                                                            constrainedToSize:studyNum.frame.size
                                                                                                                lineBreakMode:studyNum.lineBreakMode];
                        
                        
                        
                        
                UIImageView *flowerImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-theSize.width-22*WIDTH/375-28*WIDTH/375, expectSize.height+36*WIDTH/375,WIDTH *12/375, WIDTH *12/375)];
                
                        
                        flowerImage.image=[UIImage imageNamed:@"dianzandeS"];
                        [imgView addSubview:flowerImage];
                        
                        
                        
                        
                _flowerLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-theSize.width-12*WIDTH/375-28*WIDTH/375, expectSize.height+31*WIDTH/375, 25,24*WIDTH/375)];
                        _flowerLabel.font=[UIFont systemFontOfSize:12*WIDTH/375];
                        _flowerLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
                        _flowerLabel.text=[NSString stringWithFormat:@"%@",[subDic firstObject][@"likeCount"]];
                        
                        _flowerLabel.textAlignment=NSTextAlignmentCenter;
                        
                        
                        [imgView addSubview:_flowerLabel];
                        
                
                
                
                UIView  * footer=[[UIView alloc]initWithFrame:CGRectMake(0, expectSize.height+76*WIDTH/375, WIDTH, 12*WIDTH/375)];
                footer.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
                [imgView addSubview:footer];
                        
                [self.view addSubview:imgView];
                
                imgView.frame=CGRectMake(0, 0, WIDTH, expectSize.height+88*WIDTH/375);
              NSString * a  =[NSString stringWithFormat:@"%@",[subDic firstObject][@"knowledge_content"]];
                
                NSString *b=[a stringByReplacingOccurrencesOfString:@"\r\n"withString:@"<br>"];
                NSString * c=[b stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
                NSString * d=[c stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                
                
                _detailStr = [d stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
                _detailStr=[NSString stringWithFormat:@"%@",[_detailStr stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]];
                
                
                
                
                _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)style:UITableViewStylePlain];
                _tableView.delegate=self;
                _tableView.dataSource=self;
                _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                _tableView.separatorStyle = NO;
                _tableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
                [self.view addSubview:_tableView];
                
                _tableView.tableHeaderView=imgView;
                
                
                        
                    }
                    
            
            
        
        }else{
        
          
        
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);

        [self.activityIndicatorView stopAnimating];

    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{



    
    newWeiKeTableViewCell * cell=[newWeiKeTableViewCell cellWithTableView:tableView];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([_detailStr isEqualToString:@""]) {
        _detailStr=[NSString stringWithFormat:@"%@",@"暂时没有内容介绍"];
    }
    
    
    if (_zhankai) {
        [cell setIntroductionText1:[NSString stringWithFormat:@"%@",_detailStr]];
    }else{
        [cell setIntroductionText:[NSString stringWithFormat:@"%@",_detailStr]];

    }
    cell.delegate=self;
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    
    NSLog(@"%f",cell.frame.size.height);
    
    return cell.frame.size.height;

}
-(void)UnfoldCellDidClickUnfoldBtn{

//     CGSize contentH = [_detailStr boundingRectWithSize:CGSizeMake(351*WIDTH/375, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*WIDTH/375]} context:nil].size;
//    
//    _heigt=contentH.height;
    _zhankai=YES;
    
    [self.tableView reloadData];

}

- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch([reachability currentReachabilityStatus]){
        case NotReachable: isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN: isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi: isExistenceNetwork = TRUE;
            break;
    }
    return isExistenceNetwork;
}
-(void)loadNoWifi{
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    
    _backView.backgroundColor=[UIColor whiteColor];
    
  
    
    
    
    
    
    UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,HEIGHT *150/568, WIDTH,HEIGHT *12.5/568)];
    frist.text=@"亲，您的手机网络不太顺畅哦~";
    frist.textAlignment=NSTextAlignmentCenter;
    frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    
    [_backView addSubview:frist];
    
    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT * (217.5-20-10)/568, WIDTH,HEIGHT* 10/568)];
    
    second.text=@"请检查您的手机是否联网";
    
    second.textAlignment=NSTextAlignmentCenter;
    
    second.font=[UIFont systemFontOfSize:15];
    
    second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    [_backView addSubview:second];
    
    
    
    //    [_backView addSubview:button];
    UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
    chongxin.frame=CGRectMake(WIDTH *100/320,HEIGHT* 210/568,WIDTH *120/320, HEIGHT*35/568);
    
    [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
    
    chongxin.layer.cornerRadius=4.5;
    
    
    [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
    
    [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_backView addSubview:chongxin];
    
    
    UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *115/320,HEIGHT*55/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
    big.image=[UIImage imageNamed:@"image_net"];
    
    
    [_backView addSubview:big];
    
    
    [self.view addSubview:_backView];
    
}
-(void)shuaxinle:(UIButton *)button{
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinleya" object:nil userInfo:nil];

}

-(void)loadShibai{
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    
    _backView.backgroundColor=[UIColor whiteColor];
    
    
    
    
    
    
    
    UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,HEIGHT *150/568, WIDTH,HEIGHT *12.5/568)];
    frist.text=@"服务器开小差了～";
    frist.textAlignment=NSTextAlignmentCenter;
    frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    
    [_backView addSubview:frist];
    
    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT * (217.5-20-10)/568, WIDTH,HEIGHT* 10/568)];
    
    second.text=@"请检查您的手机是否联网";
    
    second.textAlignment=NSTextAlignmentCenter;
    
    second.font=[UIFont systemFontOfSize:15];
    
    second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
//    [_backView addSubview:second];
    
    
    
    //    [_backView addSubview:button];
    UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
    chongxin.frame=CGRectMake(WIDTH *100/320,HEIGHT* 210/568,WIDTH *120/320, HEIGHT*35/568);
    
    [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
    
    chongxin.layer.cornerRadius=4.5;
    
    
    [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
    
    [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_backView addSubview:chongxin];
    
    
    UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *115/320,HEIGHT*55/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
    big.image=[UIImage imageNamed:@"image_net"];
    
    
    [_backView addSubview:big];
    
    
    [self.view addSubview:_backView];


}
@end
