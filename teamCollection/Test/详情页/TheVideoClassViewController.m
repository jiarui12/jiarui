//
//  TheVideoClassViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/23.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "TheVideoClassViewController.h"
#import "UIViewController+Cloudox.h"
#import "SRVideoPlayer.h"
#import "UINavigationController+Cloudox.h"
#import "AFNetworking.h"
#import "newCepingViewController.h"
#import "PrefixHeader.pch"
#import "HYPageView.h"
#import "XXTextView.h"
#import "MBProgressHUD+HM.h"
#import "XHStarRateView.h"
#import "WXApi.h"
#import "MCDownloadManager.h"
#import "UIImageView+WebCache.h"
#import "NewLoginViewController.h"
#import "Reachability.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SRVideoPlayerImageName(fileName) [@"SRVideoPlayer.bundle" stringByAppendingPathComponent:fileName]

@interface TheVideoClassViewController ()<UITextViewDelegate>
@property (nonatomic, strong) SRVideoPlayer *videoPlayer;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)newCepingViewController * ceping;

@property(nonatomic,strong)UIDatePicker * pickerView;
@property(nonatomic,strong)XXTextView * conmmentView;
@property(nonatomic,strong)UIView * conmentBackView;
@property(nonatomic,strong)UIButton * koBtn;
@property(nonatomic,strong)UIView * shareBackView;
@property(nonatomic,strong)UIView * mengban;
@property(nonatomic,strong)NSString * isCollect;
@property(nonatomic,strong)NSString * isPraised;
@property(nonatomic,strong)NSString * companyID;
@property(nonatomic,strong)NSString * releaseID;
@property(nonatomic,strong)NSString * companyName;
@property(nonatomic,strong)NSString * starLeve;
@property(nonatomic,strong)UIView * backGround;
@property(nonatomic,strong)NSString * theStar;
@property(nonatomic,strong)NSString * video;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,strong)UIImageView * backImage;
@property(nonatomic,strong)UIView * playerView;
@property(nonatomic,strong)NSString * videoName;
@property(nonatomic,strong)UIButton * button;

@end

@implementation TheVideoClassViewController
{

    NSMutableArray *downloadArr;

}
-(void)changeBgColor:(NSNotification*)no{

                UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
                button.frame=CGRectMake(0, 0, WIDTH, 210*WIDTH/375);
    
                button.backgroundColor=[UIColor blackColor];
                [button setTitle:@"播放出错，点击重试" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(chongxin:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];

    

}
-(void)changeBgColor1:(NSNotification*)no{
    
    [self loadData];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
    
    _backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/375)];
    _backImage.userInteractionEnabled=YES;
    
    _backImage.image=[UIImage imageNamed:@"placeholderImage"];
    
    
    [self.view addSubview:_backImage];
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
   
    
    
    _flag=NO;
    _mengban=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _mengban.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView)];
    [_mengban addGestureRecognizer:tapGesture];
    
    [self.navigationController.view addSubview:_mengban];
    
    _mengban.hidden=YES;

    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *  button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(0, 0, 30, 20);
    
    [_button setImage:[UIImage imageNamed:@"downLoadVideo"] forState:UIControlStateNormal];
    UIBarButtonItem * left1=[[UIBarButtonItem alloc]initWithCustomView:_button];
    [_button addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];

    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    
    
    
    
    UIButton *  button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(0, 0, 20, 20);
    
    [button2 setImage:[UIImage imageNamed:@"wexinshare"] forState:UIControlStateNormal];
    UIBarButtonItem * left2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    [button2 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItems:@[left2,left1]];

//    [self.navigationItem setRightBarButtonItem:left2];
    
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self loadData];
    [self showVideoPlayer];
    
    NSString * token=[user objectForKey:@"token"];
    
    if (token.length>8) {
        HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, WIDTH*210/375, WIDTH, HEIGHT-WIDTH*200/375) withTitles:@[@"介绍",@"测评",@"相关知识",@"评论"]withViewControllers:@[@"newintroduceViewController",@"newCepingViewController",@"AboutKnowledgeTableViewController",@"NewCommentListTableViewController"
                                                                                                                                                ] withParameters:@[self.kpId,self.kpId,self.kpId,self.kpId]];
        
        pageView.selectedColor = [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        pageView.unselectedColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        pageView.defaultSubscript = 0;
        
        [self.view addSubview: pageView];
    }else{
    
        HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, WIDTH*210/375, WIDTH, HEIGHT-WIDTH*183/375) withTitles:@[@"介绍",@"测评",@"相关知识",@"评论"]withViewControllers:@[@"newintroduceViewController"] withParameters:@[self.kpId,self.kpId,self.kpId,self.kpId]];
        
        pageView.selectedColor = [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        pageView.unselectedColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        pageView.defaultSubscript = 0;
        
        [self.view addSubview: pageView];
    
    
    }
    

    [self setBottomView];
    
    [self setShareAlert];
    
    
    

}

-(void)setBottomView{

    NSArray * imageNameArr=@[@"shoucangS",@"dianzandeS",@"dingshi",@"pingluns"];
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0,HEIGHT-WIDTH *49/375,WIDTH,WIDTH *49/375 )];
    
    
    
    _bottomView.backgroundColor=[UIColor whiteColor];
    
    for (int i = 0; i<4; i++) {
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*WIDTH/4, 0, WIDTH/4, WIDTH*49/375);
        [button setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        button.tag=10+i;
        [button addTarget: self action:@selector(clickBottomView:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
        
    }
    
    
    [self.view addSubview:self.bottomView];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    
    NSString * token=[user objectForKey:@"token"];
    if (token.length<8) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(0, 0, WIDTH, WIDTH *49/375);
        [button setTitle:@"请登录／注册" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=[UIColor whiteColor];
        [self.bottomView addSubview:button];
        
        
        
    }
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    
    view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    
    [self.bottomView addSubview:view];
    
    
    
    
    
    

}
-(void)toLogin:(UIButton *)b{

    NewLoginViewController * his=[[NewLoginViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    [self presentViewController:nav animated:YES completion:^{
        
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)downLoad:(UIButton *)bu{


    

    if ([self isExistenceNetwork]) {
    
        
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        
        NSString * token=[user objectForKey:@"token"];
        
        
        if (token.length>8) {
            
            
            
            
            if ([[user objectForKey:@"downloadArr"] count]>0) {
                downloadArr=[NSMutableArray arrayWithArray:[user objectForKey:@"downloadArr"]];
                if ([downloadArr containsObject:[user objectForKey:@"KPDATA"]]) {
                    UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该视频已缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [av show];
                }else{
                    
                    [MBProgressHUD showSuccess:@"正在缓存中"];
                    [bu setImage:[UIImage imageNamed:@"isDownLoad"] forState:UIControlStateNormal];
                    [downloadArr insertObject:[user objectForKey:@"KPDATA"] atIndex:0];
                }
            }else{
                downloadArr =[NSMutableArray new];
                if ([user objectForKey:@"KPDATA"]) {
                    [downloadArr addObject:[user objectForKey:@"KPDATA"]];
                    [bu setImage:[UIImage imageNamed:@"isDownLoad"] forState:UIControlStateNormal];
                    
                    [MBProgressHUD showSuccess:@"正在缓存中"];
                    
                    
                }else{
                    
                    [MBProgressHUD showError:@"资源未找到"];
                    
                    
                }
            }
            
            [user setObject:downloadArr forKey:@"downloadArr"];
            
            
            
            MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:[user objectForKey:@"KPDATA"][@"videoSour"][@"INIT"]];
            
            
            
            receipt.successBlock = ^(NSURLRequest * _Nullablerequest, NSHTTPURLResponse * _Nullableresponse, NSURL * _NonnullfilePath) {
                
                
            };
            
            receipt.failureBlock = ^(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response,  NSError * _Nonnull error) {
                
            };
            
            [[MCDownloadManager defaultInstance] downloadFileWithURL:[user objectForKey:@"KPDATA"][@"videoSour"][@"INIT"]progress:^(NSProgress * _Nonnull downloadProgress, MCDownloadReceipt *receipt){}destination:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSURL * _Nonnull filePath) {}failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {}];
            
            
            
        }else{
            
            
            [self toLogin:nil];
            
            
        }
        
    }else{
        [MBProgressHUD showError:@"网络未连接"];
        
    }
    
    
}
-(void)Back:(UIButton*)button{

    [self.navigationController popViewControllerAnimated:YES];
    [_videoPlayer destroyPlayer];

}

-(void)loadData{
    
    
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppGetKonwledgeDetail.mob?token=%@&knowledge_id=%@",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId];
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * arr=dic[@"knowledge"];
       
        
        _video=[NSString stringWithFormat:@"%@%@",[arr firstObject][@"video_host"],[arr firstObject][@"video_film"]];

        
        
        
//        _playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/375)];
//        [self.view addSubview:_playerView];
//        _videoPlayer = [SRVideoPlayer playerWithVideoURL:[NSURL URLWithString:_video] playerView:_playerView playerSuperView:_playerView.superview];
//        _videoPlayer.playerEndAction = SRVideoPlayerEndActionStop;
        
        _videoName=[NSString stringWithFormat:@"%@",[arr firstObject][@"knowledge_title"]];
        
//        _videoPlayer.videoName=_videoName;
        
        self.kTitle=[NSString stringWithFormat:@"%@",[arr firstObject][@"knowledge_title"]];
        
        
        
        [_backImage removeFromSuperview];
        _backImage = nil;
        
        
        _backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/375)];
        _backImage.userInteractionEnabled=YES;
        
        
        
        [self.view addSubview:_backImage];
        
        
        UIButton *videoImage=[UIButton buttonWithType:UIButtonTypeCustom];
        videoImage.frame=CGRectMake(WIDTH *149/375,WIDTH *80/375,WIDTH *80/375, WIDTH *80/375);
        
        
        [videoImage setImage:[UIImage imageNamed:@"icon_play_defult_2x"] forState:UIControlStateNormal];
        [videoImage addTarget:self action:@selector(bofang:) forControlEvents:UIControlEventTouchUpInside];
        
        [_backImage addSubview:videoImage];

        
        [_backImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arr firstObject][@"icon"]]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];

       
        
        
        
        if ([dic count]>0) {
            
            if ([dic[@"knowledge"] count]>0) {
                
                NSArray  * subDic=(NSArray *)dic[@"knowledge"];
                
                
                
                
                if ([[subDic firstObject][@"knowledge_content"] length]>0) {
                    _isCollect=[NSString stringWithFormat:@"%@",[subDic firstObject][@"isCollect"]];
                    _isPraised=[NSString stringWithFormat:@"%@",[subDic firstObject][@"isPraised"]];
                    
                    _companyID=[NSString stringWithFormat:@"%@",[subDic firstObject][@"companyId"]];
                    
                    _releaseID=[NSString stringWithFormat:@"%@",[subDic firstObject][@"update_userid"]];
                    
                    _companyName=[NSString stringWithFormat:@"%@",[subDic firstObject][@"author_company_name"]];
                    [userInfo setObject:[subDic firstObject][@"star"] forKey:[NSString stringWithFormat:@"%@",self.kpId]];
                    UIButton * a=(UIButton*)[_bottomView viewWithTag:10];
                    UIButton * b=(UIButton*)[_bottomView viewWithTag:11];
                    
                    
                    
                    if ([_isCollect isEqualToString:@"0"]) {
                        
                        [a setImage:[UIImage imageNamed:@"shoucangS"] forState:UIControlStateNormal];
                    }else{
                        [a setImage:[UIImage imageNamed:@"shoucangde"] forState:UIControlStateNormal];
                        
                    }
                    
                    
                    
                    if ([_isPraised isEqualToString:@"0"]) {
                        [b setImage:[UIImage imageNamed:@"dianzandeS"] forState:UIControlStateNormal];
                    }else{
                        [b setImage:[UIImage imageNamed:@"dianzande"] forState:UIControlStateNormal];
                    }
                    
                    
                    
                }
                
            }
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        
        [_backImage removeFromSuperview];
        _backImage = nil;
        
        
        _backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/375)];
        _backImage.userInteractionEnabled=YES;
        
        _backImage.backgroundColor=[UIColor blackColor];
        
        [self.view addSubview:_backImage];
        
        
        UIButton *videoImage=[UIButton buttonWithType:UIButtonTypeCustom];
        videoImage.frame=CGRectMake(WIDTH *149/375,WIDTH *80/375,WIDTH *80/375, WIDTH *80/375);
        
        
        [videoImage setImage:[UIImage imageNamed:@"icon_play_defult_2x"] forState:UIControlStateNormal];
        [videoImage addTarget:self action:@selector(bofang:) forControlEvents:UIControlEventTouchUpInside];
        
        [_backImage addSubview:videoImage];
        

        
        
        
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)quxiaole:(UIButton *)button{
    _mengban.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        _shareBackView.frame=CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375);
    }];
    
}
-(void)dismissContactView{
    
    _mengban.hidden=YES;
    _mengban.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        _shareBackView.frame=CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375);
        [_conmmentView resignFirstResponder];
        [_conmentBackView removeFromSuperview];
        
        _conmentBackView = nil;
        
        NSUserDefaults *userInfo=[NSUserDefaults standardUserDefaults];
        
        
        
        [userInfo setObject:_conmmentView.text forKey:[NSString stringWithFormat:@"a%@",self.kpId]];
        [self cancelPic];
        
        
    }];
    
}
-(void)clickBottomView:(UIButton *)button{
    
    
    
    if ([self isExistenceNetwork]) {
        [self setDatePicker];
        [self setCommentTextView];
        
        
        //    shoucangS  dianzandeS
        
        if (button.tag==10) {
            
            [self shoucang:button];
            
            
            
            
        }if (button.tag==11) {
            if ([_isPraised isEqualToString:@"0"]) {
                [self dianzan:button];
                
            }else{
                
                [MBProgressHUD showError:@"您已经赞过了"];
                
                
            }
            
        }
        if (button.tag==12) {
            
            
            
            
            [UIView animateWithDuration:0.5 animations:^{
                _mengban.hidden=NO;
                
                [self.navigationController.view bringSubviewToFront:_backGround];
                
                _backGround.frame=CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375);
            }];
            
            
            
        }if (button.tag==13) {
            
            _mengban.hidden=NO;
            [self.view bringSubviewToFront:_conmmentView];
            [self.conmmentView becomeFirstResponder];
            
        }
        
        
    }else{
        [MBProgressHUD showError:@"网络未连接"];
        
    }
    
    
    
}
-(void)setDatePicker{
    
    
    
    _backGround=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375)];
    _backGround.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, 0, WIDTH/2, WIDTH*43/375)];
    timeLabel.font=[UIFont systemFontOfSize:WIDTH* 14/375];
    timeLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    timeLabel.text=@"无";
    timeLabel.tag=1000;
    
    
    
    UIButton *finishbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    finishbutton.frame=CGRectMake(WIDTH *305/375, 0, WIDTH *70/375, WIDTH *43/375);
    [finishbutton setTitle:@"定时" forState:UIControlStateNormal];
    [finishbutton setTitleColor:[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    [finishbutton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [_backGround addSubview:finishbutton];
    
    
    UIButton *finishbutton1=[UIButton buttonWithType:UIButtonTypeSystem];
    finishbutton1.frame=CGRectMake(WIDTH *0/375, 0, WIDTH *70/375, WIDTH *43/375);
    [finishbutton1 setTitle:@"取消" forState:UIControlStateNormal];
    [finishbutton1 setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
    [finishbutton1 addTarget:self action:@selector(cancelPic) forControlEvents:UIControlEventTouchUpInside];
    [_backGround addSubview:finishbutton1];
    
    self.pickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,WIDTH*43/375, WIDTH,WIDTH*215/375 )];
    
    
    
    _pickerView.backgroundColor=[UIColor whiteColor];
    //指定数据源和委托
    
    _pickerView.datePickerMode=UIDatePickerModeDateAndTime;
    NSDate *minDate = [NSDate date];
    
    
    
    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:365*24*60*60];
    self.pickerView.maximumDate = maxDate;
    
    self.pickerView.minimumDate = minDate;
    [_backGround addSubview:self.pickerView];
    
    [self.navigationController.view addSubview:_backGround];
    
    
    
}

-(void)finish{
    _mengban.hidden=YES;
    
    NSDate *theDate = _pickerView.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    
    
    UIView * botton=[self.navigationController.view viewWithTag:100];
    [UIView animateWithDuration:0.5 animations:^{
        
        //        UIView * bottom=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375)];
        _backGround.frame=CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375);
    }];
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/add_study_plan.mob",URLDOMAIN];
    
    
    
    
    NSDictionary * dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"title":self.kTitle,@"kpID":self.kpId,@"planTime":[dateFormatter stringFromDate:theDate]};
    
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [MBProgressHUD showSuccess:@"学习安排定时成功"];
        
        NSString * str=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
        if ([str isEqualToString:@"1"]) {
            
            
            NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
            
            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            
            UIApplication *app = [UIApplication sharedApplication];
            if (notification != nil) {
                // 设置推送时间
                notification.fireDate = theDate;
                
                
                // 设置时区
                notification.timeZone = [NSTimeZone systemTimeZone];
                // 设置重复间隔
                notification.repeatInterval = 0;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                
                //                notification.soundName = @"Bell.caf";
                // 推送内容
                notification.alertBody = @"是时候学习知识点啦";
                notification.userInfo=@{@"type":@"alarm",@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"]};
                //显示在icon上的红色圈中的数字
                notification.applicationIconBadgeNumber = 1;
                //添加推送到UIApplication
                
                [app scheduleLocalNotification:notification];
                
            }
            
            //            else{
            //                //获取所有除与调度中的数组
            //                NSArray *locationArr = app.scheduledLocalNotifications;
            //                if (locationArr)
            //                {
            //                    for (UILocalNotification *ln in locationArr)
            //                    {
            //                        NSDictionary *dict =  ln.userInfo;
            //
            //                        if (dict)
            //                        {
            //                            NSString *obj = [dict objectForKey:@"amer.org"];
            //
            //                            if ([obj isEqualToString:@"key"])
            //                            {
            //                                //取消调度通知
            //                                [app cancelLocalNotification:ln];
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            
            
            
            
            
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"添加失败"];
        
    }];
    
    
    
    
    
    
    _pickerView=nil;
    [_pickerView removeFromSuperview];
    botton = nil;
    [botton removeFromSuperview];
    
}
-(void)cancelPic{
    
    
    _mengban.hidden=YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _backGround.frame=CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375);
    }];
    
    
    
    
    
    
    
    
    _pickerView=nil;
    [_pickerView removeFromSuperview];
    _backGround = nil;
    [_backGround removeFromSuperview];
    
    
}
-(void)setShareAlert{
    
    _shareBackView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375)];
    
    _shareBackView.backgroundColor=[UIColor whiteColor];
    
    
    UIButton * weixin=[UIButton buttonWithType:UIButtonTypeCustom];
    weixin.backgroundColor=[UIColor whiteColor];
    weixin.frame=CGRectMake(WIDTH/2-106*WIDTH/375,28*WIDTH/375 ,66*WIDTH/375, 66*WIDTH/375);
    [weixin setImage:[UIImage imageNamed:@"wx_logo_default"] forState:UIControlStateNormal];
    [_shareBackView addSubview:weixin];
    [weixin addTarget:self action:@selector(weixin:) forControlEvents:UIControlEventTouchUpInside];
    weixin.layer.cornerRadius=6;
    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-106*WIDTH/375,80*WIDTH/375 ,66*WIDTH/375, 66*WIDTH/375)];
    label.text=@"微信好友";
    label.font=[UIFont systemFontOfSize:12*WIDTH/375];
    label.textAlignment=NSTextAlignmentCenter;
    [_shareBackView addSubview:label];
    
    UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+40*WIDTH/375,80*WIDTH/375 ,66*WIDTH/375, 66*WIDTH/375)];
    label1.text=@"微信朋友圈";
    label1.font=[UIFont systemFontOfSize:12*WIDTH/375];
    label1.textAlignment=NSTextAlignmentCenter;
    [_shareBackView addSubview:label1];
    
    
    
    UIButton * pengyou=[UIButton buttonWithType:UIButtonTypeCustom];
    pengyou.backgroundColor=[UIColor whiteColor];
    pengyou.frame=CGRectMake(WIDTH/2+40*WIDTH/375,28*WIDTH/375 ,66*WIDTH/375, 66*WIDTH/375);
    [pengyou setImage:[UIImage imageNamed:@"wx_timeline_default"] forState:UIControlStateNormal];
    [pengyou addTarget:self action:@selector(pengyou:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_shareBackView addSubview:pengyou];
    pengyou.layer.cornerRadius=6;
    
    UIButton * cancleButton=[UIButton buttonWithType:UIButtonTypeSystem];
    cancleButton.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    cancleButton.frame=CGRectMake(0,144*WIDTH/375 , WIDTH, 49*WIDTH/375);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(quxiaole:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    cancleButton.titleLabel.font=[UIFont systemFontOfSize:16*WIDTH/375];
    [cancleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    
    [_shareBackView addSubview:cancleButton];
    
    
    
    [self.navigationController.view addSubview:_shareBackView];
}



-(void)setCommentTextView{
    
    
    
    _conmentBackView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT+WIDTH*270/375, WIDTH, WIDTH*270/375)];
    
    _conmentBackView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    _conmmentView=[[XXTextView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 93*WIDTH/375, 351*WIDTH/375, 121*WIDTH/375)];
    _conmmentView.xx_placeholder=@"写下阅读心得或自己的想法等，可以为其他小伙伴提供参考～";
    _conmmentView.xx_placeholderFont=[UIFont systemFontOfSize:12*WIDTH/375];
    _conmmentView.xx_placeholderColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    _theStar=[NSString stringWithFormat:@"%@",[user objectForKey:[NSString stringWithFormat:@"%@",self.kpId]]];
    
    
    
    
    
    
    NSString * temp=[user objectForKey:[NSString stringWithFormat:@"a%@",self.kpId]]?[user objectForKey:[NSString stringWithFormat:@"a%@",self.kpId]]:@"";
    
    _conmmentView.text=temp;
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame=CGRectMake(12*WIDTH/375, 227*WIDTH/375, 71*WIDTH/375, 36*WIDTH/375);
    
    cancelBtn.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    
    [cancelBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 205/255.0, 205/255.0, 205/255.0, 1 });
    cancelBtn.layer.borderWidth=0.5;
    cancelBtn.layer.borderColor=borderColorRef;
    
    
    cancelBtn.layer.cornerRadius=4;
    
    [_conmentBackView addSubview:cancelBtn];
    
    
    
    _koBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _koBtn.frame=CGRectMake(293*WIDTH/375, 227*WIDTH/375, 71*WIDTH/375, 36*WIDTH/375);
    
    
    [_koBtn setTitle:@"发布" forState:UIControlStateNormal];
    
    if (_theStar.length>8) {
        
        _conmmentView.delegate=self;
        
        
        if (temp.length>0) {
            _koBtn.enabled=YES;
            
            [_koBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            _koBtn.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
            
        }else{
            
            _koBtn.enabled=NO;
            [_koBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            
            _koBtn.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
            
        }
        
    }else{
        
        _koBtn.enabled=YES;
        
        [_koBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _koBtn.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
    }
    
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    _koBtn.layer.borderWidth=0.5;
    _koBtn.layer.borderColor=borderColorRef;
    _koBtn.layer.cornerRadius=4;
    
    
    
    [_koBtn addTarget:self action:@selector(compolete:) forControlEvents:UIControlEventTouchUpInside];
    [_conmentBackView addSubview:_koBtn];
    
    
    [_conmentBackView addSubview:_conmmentView];
    
    __block UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 62*WIDTH/375, WIDTH, 15*WIDTH/375)];
    label.text=@"极佳";
    label.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:13*WIDTH/375];
    
    
    [_conmentBackView addSubview:label];
    
    
    
    
    if (_theStar.length>8) {
        
        
        XHStarRateView *starRateView3 = [[XHStarRateView alloc] initWithFrame:CGRectMake(WIDTH*87/375, WIDTH*21/375, WIDTH*200/375, WIDTH*21/375) isCanDian:NO finish:^(CGFloat currentScore) {
            
            
            if (currentScore==1.0000000) {
                label.text=@"较差";
                
                _starLeve=[NSString stringWithFormat:@"1"];
                
            }if (currentScore==2.0000000) {
                label.text=@"一般";
                _starLeve=[NSString stringWithFormat:@"2"];
                
            }if (currentScore==3.0000000) {
                label.text=@"良好";
                _starLeve=[NSString stringWithFormat:@"3"];
                
            }if (currentScore==4.0000000) {
                label.text=@"优秀";
                _starLeve=[NSString stringWithFormat:@"4"];
                
            }if (currentScore==5.0000000) {
                label.text=@"极佳";
                _starLeve=[NSString stringWithFormat:@"5"];
                
            }
            
            
        }];
        
        
        if ([_theStar containsString:@"1"]) {
            starRateView3.currentScore=1;
            
        }    if ([_theStar containsString:@"2"]) {
            starRateView3.currentScore=2;
            
        }
        if ([_theStar containsString:@"3"]) {
            starRateView3.currentScore=3;
            
        }    if ([_theStar containsString:@"4"]) {
            starRateView3.currentScore=4;
            
        }    if ([_theStar containsString:@"5"]) {
            starRateView3.currentScore=5;
            
        }
        [_conmentBackView addSubview:starRateView3];
        
    }else{
        
        
        
        XHStarRateView *starRateView3 = [[XHStarRateView alloc] initWithFrame:CGRectMake(WIDTH*87/375, WIDTH*21/375, WIDTH*200/375, WIDTH*21/375) isCanDian:YES finish:^(CGFloat currentScore) {
            
            
            if (currentScore==1.0000000) {
                label.text=@"较差";
                
                _starLeve=[NSString stringWithFormat:@"1"];
                
            }if (currentScore==2.0000000) {
                label.text=@"一般";
                _starLeve=[NSString stringWithFormat:@"2"];
                
            }if (currentScore==3.0000000) {
                label.text=@"良好";
                _starLeve=[NSString stringWithFormat:@"3"];
                
            }if (currentScore==4.0000000) {
                label.text=@"优秀";
                _starLeve=[NSString stringWithFormat:@"4"];
                
            }if (currentScore==5.0000000) {
                label.text=@"极佳";
                _starLeve=[NSString stringWithFormat:@"5"];
                
            }
            
            
        }];
        
        
        
        starRateView3.currentScore=5;
        
        [_conmentBackView addSubview:starRateView3];
        
    }
    
    
    
    
    
    
    
    
    
    
    
    [self.navigationController.view addSubview:_conmentBackView];
    
    
    
    
    
    
    
    
}

-(void)keyBoardWillShow:(NSNotification *)note{
    CGRect rect=[note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat ty=-rect.size.height;
    
    
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue] animations:^{
        //        self.conmentBackView.transform=CGAffineTransformMakeTranslation(0, ty);
        
        self.conmentBackView.frame=CGRectMake(0,HEIGHT- WIDTH*270/375+ty, WIDTH,  WIDTH*270/375);
    }];
    
    
    
}
-(void)keyBoardWillHide:(NSNotification*)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        //        self.conmentBackView.transform = CGAffineTransformIdentity;
        self.conmentBackView.frame = CGRectMake(0, HEIGHT+ WIDTH*270/375, WIDTH,  WIDTH*270/375);
    }];
}
-(void)cancelBtn:(UIButton *)button{
    _mengban.hidden=YES;
    NSUserDefaults *userInfo=[NSUserDefaults standardUserDefaults];
    
    
    
    [userInfo setObject:_conmmentView.text forKey:[NSString stringWithFormat:@"a%@",self.kpId]];
    
    
    [_conmmentView resignFirstResponder];
    
    
    [_conmentBackView removeFromSuperview];
    
    _conmentBackView = nil;
    
}
-(void)compolete:(UIButton *)button{
    
    
    
    
    
    
    if (_theStar.length>8) {
        
        
        button.enabled=NO;
        NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        NSString * star=[NSString stringWithFormat:@"content_value-%@,attract_degree-%@,spread_degree-%@",_starLeve,_starLeve,_starLeve];
        
        NSString *str = [self.conmmentView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str = [self stringReplaceWithFace:str];

        if (str.length>0) {
            
            
            
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppAddComment.mob?token=%@&knowledge_id=%@&knowledge_title=%@&release_user_id=%@&release_company_id=%@&release_company_name=%@&comment_content=%@&star=%@&integral=0",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId,self.kTitle,self.releaseID,self.companyID,self.companyName,str,star];
            NSString *encodingString =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            
            [manager GET:encodingString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                button.enabled=YES;
                if ([dic[@"responseText"] isEqualToString:@"成功"]) {
                    [_conmmentView resignFirstResponder];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinpinglun" object:nil userInfo:nil];
                    [MBProgressHUD showSuccess:@"评论成功"];
                    _conmmentView.text=nil;
                    _mengban.hidden=YES;
                    [userInfo setObject:star forKey:[NSString stringWithFormat:@"%@",self.kpId]];
                    [userInfo setObject:@"" forKey:[NSString stringWithFormat:@"a%@",self.kpId]];
                    
                    [_conmentBackView removeFromSuperview];
                    
                    _conmentBackView = nil;
                    
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                button.enabled=YES;
                
                [MBProgressHUD showError:@"评论失败"];
                
            }];
            
        }else{
            
            [MBProgressHUD showError:@"请输入内容"];
            button.enabled=YES;
        }
        
    }else{
        
        
        
        
        button.enabled=NO;
        
        
        
        NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        NSString * star=[NSString stringWithFormat:@"content_value-%@,attract_degree-%@,spread_degree-%@",_starLeve,_starLeve,_starLeve];
        
        NSString *str = [self.conmmentView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str = [self stringReplaceWithFace:str];

        
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppAddComment.mob?token=%@&knowledge_id=%@&knowledge_title=%@&release_user_id=%@&release_company_id=%@&release_company_name=%@&comment_content=%@&star=%@&integral=0",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId,self.kTitle,self.releaseID,self.companyID,self.companyName,str,star];
        NSString *encodingString =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        [manager GET:encodingString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            button.enabled=YES;
            
            if ([dic[@"responseText"] isEqualToString:@"成功"]) {
                [_conmmentView resignFirstResponder];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxinpinglun" object:nil userInfo:nil];
                [MBProgressHUD showSuccess:@"评论成功"];
                _conmmentView.text=nil;
                _mengban.hidden=YES;
                [userInfo setObject:star forKey:[NSString stringWithFormat:@"%@",self.kpId]];
                [userInfo setObject:@"" forKey:[NSString stringWithFormat:@"a%@",self.kpId]];
            }else{
                
                [MBProgressHUD showError:@"评论失败"];
                
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            button.enabled=YES;
            
            [MBProgressHUD showError:@"评论失败"];
            
        }];
        
        
        
        
        
        
        
        
    }
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)dianzan:(UIButton *)btn{
    
    
    
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppAddPraise.mob?token=%@&knowledge_id=%@&release_user_id=%@&release_company_id=%@",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId,self.releaseID,self.companyID];
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dic[@"responseText"] isEqualToString:@"成功"]) {
            _isPraised=[NSString stringWithFormat:@"1"];
            [btn setImage:[UIImage imageNamed:@"dianzande"] forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shuaxindianzan" object:nil userInfo:nil];
            [MBProgressHUD showSuccess:@"点赞成功"];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"点赞失败"];
        
        
    }];
    
}
-(void)shoucang:(UIButton *)button{
    
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    if ([_isCollect isEqualToString:@"0"]) {
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppCollect.mob?token=%@&knowledge_id=%@&flag=0",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId];
        
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            _isCollect=[NSString stringWithFormat:@"1"];
            [MBProgressHUD showSuccess:@"收藏成功"];
            
            
            [button setImage:[UIImage imageNamed:@"shoucangde"] forState:UIControlStateNormal];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    }else{
        
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/lytAppKnowledge/clientAppCollect.mob?token=%@&knowledge_id=%@&flag=1",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId];
        
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            _isCollect=[NSString stringWithFormat:@"0"];
            [button setImage:[UIImage imageNamed:@"shoucangS"] forState:UIControlStateNormal];
            [MBProgressHUD showSuccess:@"取消收藏"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
        
    }
    
    
}
-(void)textViewDidChange:(UITextView *)textView{
    
    
    
    
    if (textView.text.length==0) {
        _koBtn.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
        [_koBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        _koBtn.enabled=NO;
    }else{
        _koBtn.enabled=YES;
        
        [_koBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _koBtn.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
    }
    
    
    if (textView.text.length>=200) {
        textView.text=[textView.text substringWithRange:NSMakeRange(0, 200)];
        
        if (!_flag) {
            
            
            
            [MBProgressHUD showError:@"已超出200字"];
            _flag=YES;
        }
        
        
        
        
    }else if(textView.text.length<200){
        
        _flag=NO;
        
    }
    
    
    
    
}
-(void)share:(UIButton *)button{
    if ([self isExistenceNetwork]) {
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        NSString * token=[user objectForKey:@"token"];
        if (token.length>8) {
            _mengban.hidden=NO;
            [UIView animateWithDuration:0.5 animations:^{
                _shareBackView.frame=CGRectMake(0, HEIGHT-WIDTH*193/375, WIDTH, WIDTH*193/375);
                
                [self.navigationController.view bringSubviewToFront:_mengban];
                
                
                [self.navigationController.view bringSubviewToFront:_shareBackView];
                
            }];
            
            
        }else{
            
            [self toLogin:nil];
        }
        
        
    }else{
        [MBProgressHUD showError:@"网络未连接"];
        
    }
    
    
}
-(void)weixin:(UIButton *)button{
    
    _mengban.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        _shareBackView.frame=CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375);
    }];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSString * ret=responseObject[@"ret"];
        if ([ret isEqualToString:@"success"]) {
            
            
            SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
            sendReq.bText = NO;//不使用文本信息
            sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
            //创建分享内容对象
            WXMediaMessage *urlMessage = [WXMediaMessage message];
            
            urlMessage.title = self.kTitle;//分享标题
            
            urlMessage.description = self.kContent;//分享描述
            
            NSURL *url = [NSURL URLWithString:self.kIconUrl];
            
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            
            
            UIImage *img = [UIImage imageWithData:data];
            NSData * imageData1=UIImageJPEGRepresentation(img,0.000);
            
            UIImage * image=[UIImage imageWithData:imageData1];
            
            
            
            if (imageData1.length>20000) {
                CGSize size  = CGSizeMake(50, 50);
                
                UIGraphicsBeginImageContext(size);
                [image drawInRect:CGRectMake(0,0,size.width,size.height)];
                UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                NSData * Data  = UIImageJPEGRepresentation(newImage, 0.8);
                
                [urlMessage setThumbImage:[UIImage imageWithData:Data]];
                
            }else{
                [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
            }
            //创建多媒体对象
            WXWebpageObject * webObj = [WXWebpageObject object];
            webObj.webpageUrl =[NSString stringWithFormat:@"%@",responseObject[@"url"]] ;//分享链接
            
            //完成发送对象实例
            urlMessage.mediaObject = webObj;
            sendReq.message = urlMessage;
            
            //发送分享信息
            [WXApi sendReq:sendReq];
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    
    
    
    
}
-(void)pengyou:(UIButton *)button{
    _mengban.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        _shareBackView.frame=CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375);
    }];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
    
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSString * ret=responseObject[@"ret"];
        
        
        
        if ([ret isEqualToString:@"success"]) {
            
            
            
            
            SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
            sendReq.bText = NO;//不使用文本信息
            sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
            //创建分享内容对象
            WXMediaMessage *urlMessage = [WXMediaMessage message];
            
            
            urlMessage.title = self.kTitle;//分享标题
            
            urlMessage.description = self.kContent;//分享描述
            
            NSURL *url = [NSURL URLWithString:self.kIconUrl];
            
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            
            
            
            UIImage *img = [UIImage imageWithData:data];
            NSData * imageData1=UIImageJPEGRepresentation(img,0.000);
            
            UIImage * image=[UIImage imageWithData:imageData1];
            
            
            
            if (imageData1.length>20000) {
                CGSize size  = CGSizeMake(50, 50);
                
                UIGraphicsBeginImageContext(size);
                [image drawInRect:CGRectMake(0,0,size.width,size.height)];
                UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                NSData * Data  = UIImageJPEGRepresentation(newImage, 0.8);
                
                
                
                [urlMessage setThumbImage:[UIImage imageWithData:Data]];
                
            }else{
                
                
                [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
            }
            //创建多媒体对象
            WXWebpageObject * webObj = [WXWebpageObject object];
            webObj.webpageUrl =[NSString stringWithFormat:@"%@",responseObject[@"url"]] ;//分享链接
            
            //完成发送对象实例
            urlMessage.mediaObject = webObj;
            sendReq.message = urlMessage;
            
            //发送分享信息
            [WXApi sendReq:sendReq];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor:) name:@"changeBgColor" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor1:) name:@"shuaxinleya" object:nil];

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"tanchupinglun" object:nil];
    self.navBarBgAlpha=@"0.0";
    
    _playerView.hidden=NO;
    
    
    
    
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/kpDetail4New.mob?token=%@&kpID=%@&adapterSize=1080",URLDOMAIN,[userInfo objectForKey:@"token"],self.kpId];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        if ([dic count]>0) {
            
            
            
            
            
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:dic[@"kpData"]];
            for (NSString *keyStr in mutableDic.allKeys) {
                
                if ([[mutableDic objectForKey:keyStr] isEqual:[NSNull null]]) {
                    
                    [mutableDic setObject:@"" forKey:keyStr];
                }
                else{
                    
                    [mutableDic setObject:[mutableDic objectForKey:keyStr] forKey:keyStr];
                }
            }
            
            
            [userInfo setObject:mutableDic forKey:@"KPDATA"];
            
            if ([[userInfo objectForKey:@"downloadArr"] count]>0) {
                downloadArr=[NSMutableArray arrayWithArray:[userInfo objectForKey:@"downloadArr"]];
                if ([downloadArr containsObject:[userInfo objectForKey:@"KPDATA"]]) {
                    
                    [_button setImage:[UIImage imageNamed:@"isDownLoad"] forState:UIControlStateNormal];
                    
                    
                }
            }

            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    

}
-(void)viewDidDisappear:(BOOL)animated{
    
    
    
    [_conmentBackView removeFromSuperview];
    
    _conmentBackView = nil;
    
    [_videoPlayer destroyPlayer];
    _backImage.hidden=NO;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


- (void)showVideoPlayer {
    
    
}

-(void)receiveNotificiation:(NSNotification *)n{
    
    [self setCommentTextView];
    
    
    _mengban.hidden=NO;
    [self.conmmentView becomeFirstResponder];
    
    
    
}
-(void)bofang:(UIButton *)button{
   
    

    
    if ([self isExistenceNetwork]) {
        
        if (_video) {
            
//            UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
//            button.frame=CGRectMake(0, 0, WIDTH, 210*WIDTH/375);
//            
//            button.backgroundColor=[UIColor blackColor];
//            [button setTitle:@"播放出错，点击重试" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(chongxin:) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:button];
            
            _backImage.hidden=YES;

            
            _playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/375)];
            [self.view addSubview:_playerView];
            _videoPlayer = [SRVideoPlayer playerWithVideoURL:[NSURL URLWithString:_video] playerView:_playerView playerSuperView:_playerView.superview];
            _videoPlayer.playerEndAction = SRVideoPlayerEndActionStop;
            _videoPlayer.videoName=_videoName;
            
            
            
            [_videoPlayer play];
        }else{
            
            [MBProgressHUD showError:@"视频地址无效"];
            
            
        }
        

        
        
    
        
    }else{
        [MBProgressHUD showError:@"网络未连接"];

        
    }


}
-(void)chongxin:(UIButton *)but{
    _playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 210*WIDTH/375)];
    [self.view addSubview:_playerView];
    _videoPlayer = [SRVideoPlayer playerWithVideoURL:[NSURL URLWithString:_video] playerView:_playerView playerSuperView:_playerView.superview];
    _videoPlayer.playerEndAction = SRVideoPlayerEndActionStop;
    _videoPlayer.videoName=_videoName;
    
    
    
    [_videoPlayer play];


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

- (NSString *)stringReplaceWithFace:(NSString *)str
{
    NSString *mutaStr = str;
    
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            
            mutaStr = [mutaStr stringByReplacingOccurrencesOfString:emoT withString:[NSString stringWithFormat:@"%@",@"[表情]"]];
        }
    }
    
    return mutaStr;
}

@end
