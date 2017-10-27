//
//  introduceKnowledgeViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "introduceKnowledgeViewController.h"
#import <WebKit/WebKit.h>
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ImageBrowserViewController.h"
#import "MBProgressHUD+HM.h"
#import "NewFlowerListViewController.h"
#import "Reachability.h"
#import "nonetConViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface introduceKnowledgeViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)WKWebView *webView;
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
@property(nonatomic,assign)BOOL isBiaogan;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,assign)BOOL isJiazai;
@property(nonatomic,assign)BOOL isNojiazai;
@property(nonatomic,strong)NSString * biangan;
@property(nonatomic,assign)CGFloat topHeight;
@end

@implementation introduceKnowledgeViewController
-(void)receiveNotificiation1:(NSNotification*)n{

    
    _flowerLabel.text=[NSString stringWithFormat:@"%ld",[_flowerLabel.text integerValue]+1];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    
    [center addObserver:self selector:@selector(receiveNotificiation1:) name:@"shuaxindianzan" object:nil];
    
    if ([self isExistenceNetwork]) {
        [self loadData];
    }else{
    
        [self loadNoWifi];
    
    }
    
    // 3.判断网络状态
   
    
//    
//    
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    // 2.设置网络状态改变后的处理
//    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        // 当网络状态改变了, 就会调用这个block
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//
//                if (!_isNojiazai) {
//                    [self loadData];
//
//                }
//                break;
//            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                if (!_isJiazai) {
//                    [self loadNoWifi];
//
//                }
//               
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                NSLog(@"手机自带网络");
//                if (!_isNojiazai) {
//                    [self loadData];
//                    
//                }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
//                NSLog(@"WIFI");
//                if (!_isNojiazai) {
//                   
//                    
//                }
//                break;
//        }
//    }];
//    // 3.开始监控
//    [mgr startMonitoring];
    
     [self loadData];
}
-(void)loadData{
    [_webView removeFromSuperview];
    _isJiazai=YES;
    _webView=nil;
    
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppGetKonwledgeDetail.mob?token=%@&knowledge_id=%@",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId];
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        if ([dic count]>0) {
            
            if ([dic[@"knowledge"] count]>0) {
                
                NSArray  * subDic=(NSArray *)dic[@"knowledge"];
                
                if ([[subDic firstObject][@"knowledge_content"] length]>0) {
                    
                    
                    
                    
                    
                    
                    
                    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
                    
                    // 设置偏好设置
                    config.preferences = [[WKPreferences alloc] init];
                    // 默认为0
                    //    config.preferences.minimumFontSize = 10;
                    // 默认认为YES
                    config.preferences.javaScriptEnabled = YES;
                    // 在iOS上默认为NO，表示不能自动通过窗口打开
                    
                    // web内容处理池
                    config.processPool = [[WKProcessPool alloc] init];
                    
                    // 通过JS与webview内容交互
                    config.userContentController = [[WKUserContentController alloc] init];
                    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
                    // 我们可以在WKScriptMessageHandler代理中接收到
                    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
                    self.webView.multipleTouchEnabled = NO;
                    
                    
                    _webView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
                    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
                    _webView.scrollView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
                    if ([subDic firstObject][@"example_score"]) {
                        _webView.scrollView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
                     
                        
                        _shangde=[NSString stringWithFormat:@"%@",[subDic firstObject][@"example_score"]];
                        _zongfen=[NSString stringWithFormat:@"%@",[subDic firstObject][@"integral"]];
                        _companyID=[NSString stringWithFormat:@"%@",[subDic firstObject][@"companyId"]];
                        _exampleId=[NSString stringWithFormat:@"%@",[subDic firstObject][@"example_userID"]];
                        _addScoreTimes=[[NSString stringWithFormat:@"%@",[subDic firstObject][@"addScoreTimes"]] integerValue];
                        
                        _biangan=[NSString stringWithFormat:@"%@",[subDic firstObject][@"exampleIsExist"]];
                        _isBiaogan=YES;
                        
                        
                        
                        
                        
                        
                        
                        UIView *imgView = [[UIView alloc] initWithFrame:CGRectMake(0, -286*WIDTH/375, _webView.frame.size.width, 286*WIDTH/375)];
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
                        headView.layer.masksToBounds=YES;
                        
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
                        headView.layer.borderWidth=0.5;
                        headView.layer.borderColor=borderColorRef;
                        
                        
                        [headView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[subDic firstObject][@"image_host"],[subDic firstObject][@"head_portrait"]]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
                        
                        [imgView addSubview:headView];
                        
                        
                        imgView.frame=CGRectMake(0,-(expectSize.height+92*WIDTH/375+128*WIDTH/375+24*WIDTH/375), WIDTH, expectSize.height+92*WIDTH/375+128*WIDTH/375+24*WIDTH/375);
                        
                        _webView.scrollView.contentInset = UIEdgeInsetsMake(expectSize.height+92*WIDTH/375+128*WIDTH/375+24*WIDTH/375,0, 588*WIDTH/750, 0);

                        _topHeight=expectSize.height+92*WIDTH/375+128*WIDTH/375+24*WIDTH/375;
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
                        
                        studyNum.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
                        studyNum.textAlignment=NSTextAlignmentRight;
                        [imgView addSubview:studyNum];
                        
                        
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
                        
                        
                        
                        UIView * xian=[[UIView alloc]initWithFrame:CGRectMake(12*WIDTH/375, expectSize.height+72*WIDTH/375, 351*WIDTH/375, 1)];
                        
                        xian.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                        
                        [imgView addSubview:xian];
                        
                        
                        
                        
                        
                        UIImageView * headImage1=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-55*WIDTH/375, expectSize.height+96*WIDTH/375, 110*WIDTH/375, 116*WIDTH/375)];
                        //                        headImage1.image=[UIImage imageNamed:@"biaoganKuang"];
                        headImage1.layer.masksToBounds=YES;
                        headImage1.layer.cornerRadius=55*WIDTH/375;
                        
                        [headImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[subDic firstObject][@"image_host"],[subDic firstObject][@"example_headportrait"]]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
                        [imgView addSubview:headImage1];
                        
                        UIImageView * headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-64*WIDTH/375, expectSize.height+92*WIDTH/375, 128*WIDTH/375, 128*WIDTH/375)];
                        headImage.image=[UIImage imageNamed:@"biaoganKuang"];
                        
                        UILabel * biaoganLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH * 87 /375, 128*WIDTH/375, 30)];
                        biaoganLabel.textColor=[UIColor whiteColor];
                        biaoganLabel.textAlignment=NSTextAlignmentCenter;
                        
                        
                        biaoganLabel.text=[subDic firstObject][@"example_username"];
                        
                        [headImage addSubview:biaoganLabel];
                        
                        [imgView addSubview:headImage];

                        
                        
                        
                        
                        [self.webView.scrollView addSubview:imgView];
                        

                        
                        
                        
                        
                        
                        
                        

                    }else{
                        
                        
                        UIView *imgView = [[UIView alloc] initWithFrame:CGRectMake(0, -220*WIDTH/750, _webView.frame.size.width, 220*WIDTH/750)];
                        imgView.backgroundColor=[UIColor whiteColor];
                       
                       
                        UILabel * titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(12*WIDTH/375, 21*WIDTH/375,WIDTH, 16*WIDTH/375)];
                        titleLabel.numberOfLines=2;
                        titleLabel.text=[NSString stringWithFormat:@"%@",[subDic firstObject][@"knowledge_title"]];
                        titleLabel.font=[UIFont systemFontOfSize:17*WIDTH/375];

//                        titleLabel.text=@"啊啦解放啦解放啦就啊啦放假啦警方立即阿里风景啦解放啦解放啦距离放假啊啦放假啦解放啦距离放假啊了了发卡量放假啊啦放假啊啦解放啦解放啦距离";
                        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                        CGSize maximumLabelSize = CGSizeMake(WIDTH * 351/375, 9999);//labelsize的最大值
                        //关键语句
                        CGSize expectSize = [titleLabel sizeThatFits:maximumLabelSize];
                        

                        
                        
                        titleLabel.frame=CGRectMake(12*WIDTH/375, 21*WIDTH/375,expectSize.width, expectSize.height);
                        
                        
                        [imgView addSubview:titleLabel];
                        
                        
                        UIImageView * headView=[[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTH/375, expectSize.height+31*WIDTH/375, 24*WIDTH/375, 24*WIDTH/375)];
                        headView.layer.cornerRadius=12*WIDTH/375;
                        headView.layer.masksToBounds=YES;
                        
                        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
                        headView.layer.borderWidth=0.5;
                        headView.layer.borderColor=borderColorRef;
                        
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

                        
                        _webView.scrollView.contentInset = UIEdgeInsetsMake(expectSize.height+73*WIDTH/375,0, 0, 0);
                        UIView * xian=[[UIView alloc]initWithFrame:CGRectMake(12*WIDTH/375, expectSize.height+72*WIDTH/375, 351*WIDTH/375, 1)];
                        xian.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                        imgView.frame=CGRectMake(0,  -expectSize.height-72*WIDTH/375, WIDTH,  expectSize.height+72*WIDTH/375);
                        [imgView addSubview:xian];
                        [_webView.scrollView addSubview:imgView];
                    
                    }
                    
              
                    
                    [userInfo setObject:[NSString stringWithFormat:@"%@",[subDic firstObject][@"star"]] forKey:[NSString stringWithFormat:@"%@",self.kpId]];
                    
                    // 导航代理
                    self.webView.navigationDelegate = self;
                    // 与webview UI交互代理
                    self.webView.UIDelegate = self;
                    
                    
                    
                    
                    
                    
                    
                    
                    WKUserContentController *userCC = config.userContentController;
                    //JS调用OC 添加处理脚本
                    
                    [userCC addScriptMessageHandler:self name:@"closeView"];
                    
                    [userCC addScriptMessageHandler:self name:@"showName"];
                    
                    [userCC addScriptMessageHandler:self name:@"startShot"];
                    [userCC addScriptMessageHandler:self name:@"submit"];
                    [userCC addScriptMessageHandler:self name:@"datas"];
                    [userCC addScriptMessageHandler:self name:@"chat"];
                    [userCC addScriptMessageHandler:self name:@"shuaxin"];
                    [userCC addScriptMessageHandler:self name:@"learningReminder"];
                    [userCC addScriptMessageHandler:self name:@"downloadVideo"];
                    [userCC addScriptMessageHandler:self name:@"showMobile"];
                    [userCC addScriptMessageHandler:self name:@"sys"];
                    [userCC addScriptMessageHandler:self name:@"queryPhoto"];
                    [userCC addScriptMessageHandler:self name:@"frashMeta"];
                    [userCC addScriptMessageHandler:self name:@"goback"];
                    [userCC addScriptMessageHandler:self name:@"login"];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    NSMutableString * s=[NSMutableString stringWithFormat:@"%@",[subDic firstObject][@"knowledge_content"]];
                    
                    NSString * s1=[subDic firstObject][@"image_host"];
                    NSString * temp=@"src=\"";
                    
                    NSString * Tem=@"<img";
                    NSString * s2=@"<img onclick='showImg(this)'";
                    NSString *cca1 = [s stringByReplacingOccurrencesOfString:temp withString:[NSString stringWithFormat:@"%@%@",temp,s1 ]] ;
                    NSString * cca2=[cca1 stringByReplacingOccurrencesOfString:Tem withString:s2];
                    NSString * aaa=[NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta name=\"viewport\" content=\"initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width\">  <meta charset=\"utf-8\"><title></title></head><body><script type=\"text/javascript\"> function showImg(item){var data ={\"index\":item.src};if((typeof circle_Andorid) == 'undefined') {window.webkit.messageHandlers.queryPhoto.postMessage(item.src);}else{circle_Andorid.watchBigPic(JSON.stringify(item.src));}} </script> <style> .content-box{overflow: hidden; width=100%%; white-space: normal;font-size:17px} b{padding:0px 0px; font-size: 17px;font-weight: 500;  color:#333;} div,p{ font-size:16px;color:#333} .content-box>img{display: block; width:100%%;  margin:10px auto;}  </style><div id=\"webview_content_wrapper\" class='content-box'> %@</div></body></html>",cca2];
                    
                    NSString * bbb=[aaa stringByReplacingOccurrencesOfString:@"<pre" withString:@"<p"];
                    
                    NSString * ccc=[bbb stringByReplacingOccurrencesOfString:@"</pre>" withString:@"</p>"];
                    
                    
                    NSLog(@"%@",ccc);
                    
                    
                    _imageArr=[NSMutableArray new];
                    NSError *error = NULL;
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(src|SRC)=(\\\"|\')(.*?)(\"|\')" options:NSRegularExpressionCaseInsensitive error:&error];
                    
                    NSArray * arr=[regex matchesInString:cca2 options:0 range:NSMakeRange(0, [cca2 length])];
                    
                    
                    
                    
                    
                    
                    
                    
                    for (int i=0; i<arr.count; i++) {
                        NSTextCheckingResult *result=arr[i];
                        
                        
                        NSString * src=[cca2 substringWithRange:result.range];
                        
                        
                        
                        NSLog(@"%@",src);
                        
                        
                        
                        [_imageArr addObject:[src componentsSeparatedByString:@"\""][1]];
                        
                    }
                    
                    NSLog(@"%@",_imageArr);
                    
//                    if (result) {
//                        
//
//                        
//                        NSString * src=[cca2 substringWithRange:result.range];
//                        
//                        
//                        NSLog(@"%@",src);
//                        
//                        
//                        [_imageArr addObject:[src componentsSeparatedByString:@"\""][1]];
//                        
//                    }
                    
                    
                    [_webView loadHTMLString:ccc baseURL:nil];
                    
                    
                    
                    
                    [self.view addSubview:self.webView];
                    
                    
                    
                    
                }
            }
            
            
            
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:dic[@"kpData"]];
            for (NSString *keyStr in mutableDic.allKeys) {
                
                if ([[mutableDic objectForKey:keyStr] isEqual:[NSNull null]]) {
                    
                    [mutableDic setObject:@"" forKey:keyStr];
                }
                else{
                    
                    [mutableDic setObject:[mutableDic objectForKey:keyStr] forKey:keyStr];
                }
            }
            
            
//            [userInfo setObject:mutableDic forKey:@"KPDATA"];
            
            if (dic[@""]) {
                
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
   
    
    if ([message.name isEqualToString:@"queryPhoto"]) {
        NSString *dic=(NSString *)message.body;
        
        
        NSInteger a=[_imageArr indexOfObject:dic];
        [ImageBrowserViewController show:self type:PhotoBroswerVCTypePush index:a imagesBlock:^NSArray *{
            return _imageArr;
        }];
    }
    
    
    
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
//    
//        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//        [av show];
    
    
    NSLog(@"%@",message);
  
    
    
    completionHandler();
    
    
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

//    UIScrollView * scroll=_webView.scrollView.subviews.firstObject;

    
    if (_isBiaogan) {
        
        [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable res, NSError * _Nullable error) {
            
            
            
        _contentHeight=[res floatValue];
            
            UIView * View=[[UIView alloc]initWithFrame:CGRectMake(0, _contentHeight, _webView.frame.size.width, 588*WIDTH/750)];
            View.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            
            
            _button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            _button.frame=CGRectMake(WIDTH/2-36*WIDTH/375, 70*WIDTH/375, 72*WIDTH/375, 72*WIDTH/375);
            if (_addScoreTimes==0&&[_biangan isEqualToString:@"1"]) {
                [_button setImage:[UIImage imageNamed:@"shangjifen"] forState:UIControlStateNormal];
                
            }else{
                [_button setImage:[UIImage imageNamed:@"unshangjinfen"] forState:UIControlStateNormal];
                _button.enabled=NO;
            }
            
            
            [_button addTarget:self action:@selector(shangjifen:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIView * fristView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 166*WIDTH/375)];
            fristView.backgroundColor=[UIColor whiteColor];
            [View addSubview:fristView];
            
            
            
            UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(34*WIDTH/375, 34*WIDTH/375, 79*WIDTH/375, 1)];
            
            view1.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            
            [fristView addSubview:view1];
            
            
            UIView * view2=[[UIView alloc]initWithFrame:CGRectMake(WIDTH-34*WIDTH/375- 79*WIDTH/375, 34*WIDTH/375, 79*WIDTH/375, 1)];
            
            view2.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            
            [fristView addSubview:view2];
            
            
            UILabel * lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 30*WIDTH/375, WIDTH, 12*WIDTH/375)];
            
            
            lable1.text=@"很棒的标杆，奖赏一下";
            lable1.textAlignment=NSTextAlignmentCenter;
            lable1.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
            lable1.font=[UIFont systemFontOfSize:13*WIDTH/375];
            
            [fristView addSubview:lable1];
            
            [fristView addSubview:_button];
            
            _background=[[UIView alloc]initWithFrame:CGRectMake(0,178*WIDTH/375, WIDTH, WIDTH*100/375)];
            
            _background.backgroundColor=[UIColor whiteColor];
            
            
            
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(12*WIDTH/375, 12*WIDTH/375, 200, 16*WIDTH/375)];
            label.font=[UIFont systemFontOfSize:14 *WIDTH/375];
            [_background addSubview:label];
            
            
            UILabel * Zanwu=[[UILabel alloc]initWithFrame:CGRectMake(0, 56*WIDTH/375, WIDTH, 16*WIDTH/375)];
            
            Zanwu.font=[UIFont systemFontOfSize:13*WIDTH/375];
            Zanwu.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
            Zanwu.textAlignment=NSTextAlignmentCenter;
            
            [_background addSubview:Zanwu];
            
            Zanwu.tag=1234;
            Zanwu.text=@"暂时还没有奖赏";
            label.text=@"他们已奖赏过（0人）";
            label.tag=12345;
            [View addSubview:_background];
            
            
            
            
            
            [_webView.scrollView addSubview:View];
            
            
            [self loadData1];
            
            
        }];

        
        
    }
    
}
-(void)shangjifen:(UIButton *)button{
    NSInteger zong=[_zongfen integerValue];
    NSInteger shang=[_shangde integerValue];
    if (zong>=shang) {
        
        NSString * message=[NSString stringWithFormat:@"你当前有%ld积分，确定要奖赏对方%ld积分？",(long)zong,(long)shang];
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
    }else{
    
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你当前积分不足，无法进行奖赏。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [av show];
    }
    
    


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1) {
        
        NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppExampleAddScore.mob?token=%@&knowledge_id=%@&add_score=%@&example_userID=%@&rule_code=add_for_exam_knowledge",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId,self.shangde,self.exampleId];
        [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           
            if ([arr[@"responseText"] isEqualToString:@"成功"]) {
                
                [MBProgressHUD showSuccess:@"奖赏成功"];
                [self loadData1];
                
                [_button setImage:[UIImage imageNamed:@"unshangjinfen"] forState:UIControlStateNormal];
                _button.enabled=NO;
                
            }else{
                [MBProgressHUD showError:@"奖赏失败"];

            
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MBProgressHUD showError:@"奖赏失败"];

            
        }];
        
        
        
    }

}

-(void)loadData1{
   
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"]?[user objectForKey:@"token"]:@"";
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/knowledgeAppDetail/getAddExampleScoreUsers.mob?token=%@&knowledge_id=%@&company_id=%@&exam_id=%@&currPage=1&pageSize=10",URLDOMAIN,token,self.kpId,self.companyID,self.exampleId];
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic=(NSDictionary *)responseObject;
        if (dic) {
            
            
            
            
            NSString * status=[NSString stringWithFormat:@"%@",dic[@"status"]];
            int  num=[dic[@"totalNumber"] intValue];
            if (status.length>0) {
                if ([status isEqualToString:@"0"]) {
                    if (num>0) {
                        UILabel * label=[_background viewWithTag:1234];
                        label.hidden=YES;
                        UILabel * label1=[_background viewWithTag:12345];
                        label1.text=[NSString stringWithFormat:@"他们已经赞赏过（%d人）",num];
                        
                        NSArray *arr=dic[@"list"];
                        _headImageArr = [NSMutableArray new];
                        _AllImageArr=[NSMutableArray new];
                        for (NSDictionary * subDic in arr) {
                            [_headImageArr addObject:subDic[@"head_portrait"]];
                            [_AllImageArr addObject:subDic[@"head_portrait"]];
                        }
                        if (_headImageArr.count>6) {
                            _headImageArr =[NSMutableArray arrayWithArray:[_headImageArr subarrayWithRange:NSMakeRange(0, 5)]] ;
                            [_headImageArr addObject:@"THeMore"];
                        }
                        for (int i=10; i<20; i++) {
                            UIButton * b=[_background viewWithTag:i];
                            [b removeFromSuperview];
                            b=nil;
                        }
                        for (int i=20; i<30; i++) {
                            UIImageView * b=[_background viewWithTag:i];
                            [b removeFromSuperview];
                            b=nil;
                        }
                        for (int i=0; i<_headImageArr.count; i++) {
                            UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*12/375+i*WIDTH/6,WIDTH *48/375, 36*WIDTH/375, 36*WIDTH/375)];
                            
                            image.tag=20+i;
                            image.layer.masksToBounds = YES;
                            image.layer.cornerRadius=18*WIDTH/375;
                            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                            // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                            CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
                            image.layer.borderWidth=0.5;
                            image.layer.borderColor=borderColorRef;
                            
                            
                            [image sd_setImageWithURL:[NSURL URLWithString:_headImageArr[i]] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
                            [_background addSubview:image];
                            
                            
                            UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH*12/375+i*WIDTH/6,WIDTH *48/375, 36*WIDTH/375, 36*WIDTH/375)];
                            
                            button.tag=10+i;
                            
                            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [_background addSubview:button];
                            _background.hidden=NO;
                            
                            CGFloat allHeight=HEIGHT-12*WIDTH/375;
                            if (_contentHeight>allHeight) {
                                _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight,0, 550*WIDTH/750, 0);

                            }else{
                                if (_contentHeight+550*WIDTH/750>allHeight) {
                                    _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight,0,_contentHeight+550*WIDTH/750-allHeight , 0);
                                }else{
                                _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight-12*WIDTH/375,0,0 , 0);
                                
                                }
                            
                            
                            
                            }
                            
                            
                            
                            
                        }
                    }else{
                        _background.hidden=YES;
                        _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight,0,0 , 0);
                        
                        
                        
                        CGFloat allHeight=HEIGHT-12*WIDTH/375;
                        if (_contentHeight>allHeight) {
                            _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight,0, 388*WIDTH/750, 0);
                            
                        }else{
                            if (_contentHeight+388*WIDTH/750>allHeight) {
                                _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight,0,_contentHeight+388*WIDTH/750-allHeight , 0);
                            }else{
                                _webView.scrollView.contentInset = UIEdgeInsetsMake(_topHeight,0,0 , 0);
                                
                            }
                            
                            
                            
                        }
                        

                    }
                    
                    
                    
                }
                
                
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)btnClick:(UIButton *)button{
    
    
    
    
    
    
    
    if (_AllImageArr.count>6) {
        
        if (button.tag==15) {
            
            NewFlowerListViewController * new=[[NewFlowerListViewController alloc]init];
            new.kpID=self.kpId;
            UILabel * label1=[_background viewWithTag:12345];
            new.exampleID=self.exampleId;
            new.companyID=self.companyID;
            new.NavTitle=label1.text;
            [self.navigationController pushViewController:new animated:YES];
            
            
        }
        
    }else{
        
        
        
        
    }
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}
- (void)addObserverForWebViewContentSize{
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:nil];
}
- (void)removeObserverForWebViewContentSize{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
-(void)dealloc{

    [self removeObserverForWebViewContentSize];
   

}

-(void)loadNoWifi{
    _isNojiazai=YES;
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    
    _backView.backgroundColor=[UIColor whiteColor];
    

    
    
    
    
    UILabel * frist=[[UILabel alloc]initWithFrame:CGRectMake(0,HEIGHT *190/568, WIDTH,HEIGHT *12.5/568)];
    frist.text=@"亲，您的手机网络不太顺畅哦~";
    frist.textAlignment=NSTextAlignmentCenter;
    frist.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    
    [_backView addSubview:frist];
    
    UILabel * second=[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT * 217.5/568, WIDTH,HEIGHT* 10/568)];
    
    second.text=@"请检查您的手机是否联网";
    
    second.textAlignment=NSTextAlignmentCenter;
    
    second.font=[UIFont systemFontOfSize:15];
    
    second.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    
    [_backView addSubview:second];
    
    
    
    //    [_backView addSubview:button];
    UIButton*chongxin=[UIButton buttonWithType:UIButtonTypeCustom];
    chongxin.frame=CGRectMake(WIDTH *100/320,HEIGHT* 240/568,WIDTH *120/320, HEIGHT*35/568);
    
    [chongxin setTitle:@"重新加载" forState:UIControlStateNormal];
    
    chongxin.layer.cornerRadius=4.5;
    
    
    [chongxin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chongxin setBackgroundColor:[UIColor colorWithRed:39/255.0 green:128/255.0 blue:231/255.0 alpha:1.0]];
    
    [chongxin addTarget:self action:@selector(shuaxinle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_backView addSubview:chongxin];
    
    
    UIImageView * big=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *120/320,HEIGHT*75/568,WIDTH *92.5/320, HEIGHT * 82.5/568)];
    big.image=[UIImage imageNamed:@"image_net"];
    
    
    [_backView addSubview:big];
    
    
    [self.view addSubview:_backView];

}
-(void)shuaxinle:(UIButton *)button{

    [self loadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinleya" object:nil userInfo:nil];


}
-(void)nonetCon:(UIButton *)button{
    nonetConViewController * no=[[nonetConViewController alloc]init];
    
    [self.navigationController pushViewController:no animated:YES];
    
    
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

@end
