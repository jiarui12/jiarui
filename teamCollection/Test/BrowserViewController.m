//
//  BrowserViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/6/23.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "BrowserViewController.h"
#import "MBProgressHUD+HM.h"
#import "UWDatePickerView.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import <WebKit/WebKit.h>
#import "WXApi.h"
@interface BrowserViewController ()<UIActionSheetDelegate,WKNavigationDelegate,WKUIDelegate,UWDatePickerViewDelegate>
{
    UIImageView *_demoImageView;
    
    UIImageView *_demoImageView2;

}
@property(nonatomic,strong)UIButton * collectionButton;
@property(nonatomic,strong)WKWebView * webView;
@property(nonatomic,strong)UWDatePickerView * pickerView;
@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"安全生产";
   
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
  
    config.preferences = [[WKPreferences alloc] init];
   
    config.preferences.minimumFontSize = 10;
    
    config.preferences.javaScriptEnabled = YES;
    
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    
    config.processPool = [[WKProcessPool alloc] init];
    
    
    config.userContentController = [[WKUserContentController alloc] init];

    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-49-64)
                                      configuration:config];
    self.webView.scrollView.bounces=NO;

    
    
    
    
    
    
    
  
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
    


    
    
    
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 17);
    [button1 setBackgroundImage:[UIImage imageNamed:@"nav_icon_return_defult@2x"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"nav_icon_return_selected@2x"] forState:UIControlStateHighlighted];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];

     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    _collectionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _collectionButton.frame=CGRectMake(0, 0, 34, 19);
    self.collectionButton.layer.zPosition = 1;
    [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collect_selected@2x"] forState:UIControlStateHighlighted];
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:_collectionButton];
    [_collectionButton addTarget:self action:@selector(collectionKnowledge:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(0, 0, 30, 18);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"more_m"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"repeat_selected@2x"] forState:UIControlStateHighlighted];
    UIBarButtonItem * right1=[[UIBarButtonItem alloc]initWithCustomView:shareButton];
    [shareButton addTarget:self action:@selector(shareKnowledge:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0,0 ,0);
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    button.backgroundColor=[UIColor greenColor];
    button.enabled=NO;
    
    
    [button addTarget:self action:@selector(collectionKnowledge:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.navigationItem setRightBarButtonItems:@[right1,right]];
    
    NSArray * imgArr=@[@"icon_comment_defult",@"icon_dwonload_defult",@"icon_remind_defult",@"icon_add_defult"];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    
    view.backgroundColor=[UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:view];
    for (int i=0; i<4; i++) {
        UIButton *buttomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        buttomBtn.tag=i+10;
        buttomBtn.frame=CGRectMake((self.view.frame.size.width/4)*i, 0, (self.view.frame.size.width/4), 49);
        [buttomBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [buttomBtn setBackgroundImage:[UIImage imageNamed:@"backgroundcolor"] forState:UIControlStateHighlighted];
         buttomBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [buttomBtn addTarget:self action:@selector(Add:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:buttomBtn];
        
        
    }
    self.view.backgroundColor=[UIColor whiteColor];
    UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49.5, self.view.frame.size.width, 0.5)];
    backView.backgroundColor=[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
    [self.view addSubview:backView];

    


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/8+10, 25, 20, 10)];
    label.font = [UIFont boldSystemFontOfSize:10];  //UILabel的字体大小
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label setBackgroundColor:[UIColor redColor]];
    label.layer.cornerRadius=5;
    label.clipsToBounds=YES;
    NSString *str = @"1";
    label.backgroundColor=[UIColor redColor];
    label.textColor=[UIColor whiteColor];
    CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
    [label setFrame:CGRectMake(self.view.frame.size.width/8, 10, size.width+10, 13)];
    label.text = str;
    label.textAlignment=NSTextAlignmentCenter;
    label.userInteractionEnabled=YES;
    UIButton * button2=[self.view viewWithTag:10];
    
    [button2 addSubview:label];

    

    
    
    [self.view addSubview:self.webView];
    
}


#pragma mark - 单视图的转场动画
//- (void)animation2
//{
//    UIImageView *from;
//    UIImageView *to;
//    
//    if (_demoImageView.superview) {
//        from = _demoImageView;
//        to = _demoImageView2;
//    } else {
//        from = _demoImageView2;
//        to = _demoImageView;
//    }
//    
//    [UIView transitionFromView:from toView:to duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
//        
//        NSLog(@"image view1 的主视图： %@", _demoImageView.superview);
//        NSLog(@"image view2 的主视图： %@", _demoImageView2.superview);
//    }];
//}
//
//#pragma mark - 单视图的转场动画
//- (void)animation1
//{
//    [UIView transitionWithView:_demoImageView duration:1.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        
//        // 在动画块代码中设置视图内容变化
//        if (_demoImageView.tag == 0) {
//            [_demoImageView setImage:[UIImage imageNamed:@"icon_remind_defult"]];
//            [_demoImageView setTag:1];
//        } else {
//            [_demoImageView setImage:[UIImage imageNamed:@"icon_dwonload_defult"]];
//            [_demoImageView setTag:0];
//        }
//        
//    } completion:nil];
//}


-(void)Add:(UIButton*)button{
    
    if (button.tag==12) {
        [self setupDateView:DateTypeOfStart];

    }if (button.tag==10) {
//        AllWebViewController  * my=[[AllWebViewController alloc]init];
//        
//        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//        NSString * webUrl=[NSString stringWithFormat:@"%@/WeChat/toComment.wc?platform=android&userID=%@&companyID=%@&kpID=%@",URLDOMAIN,[user objectForKey:@"userID"],[user objectForKey:@"companyID"],self.kpId];
//        my.webUrl=webUrl;
//        my.Title=@"评论";
//        
//        [self.navigationController pushViewController:my animated:YES];

    }
  
}
- (void)setupDateView:(DateType)type {
    
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor clearColor]];
    _pickerView.delegate = self;
    _pickerView.type = type;
    [self.view addSubview:_pickerView];
    
}
- (CGRect)imageRectForContentRect:(CGRect)bounds{
   
    return CGRectMake(0.0, 0.0, 40, 40);
  
}
-(void)collectionKnowledge:(UIBarButtonItem*)button{

    
    
    
    
    
    
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect: _collectionButton.layer.bounds];
    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectZero];
    
    
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.5];
    //位置移动
    
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue =  [NSValue valueWithCGPoint: _collectionButton.layer.position];
    CGPoint toPoint = _collectionButton.layer.position;
    toPoint.x += 180;
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    //旋转动画
    CABasicAnimation* rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3];
    // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.duration = 2.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
    
    
    //缩放动画
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    
    scaleAnimation.byValue=[NSNumber numberWithBool:0.5];
    
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 0.4f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0f;
    animationGroup.autoreverses = NO;   //是否重播，原动画的倒播
    animationGroup.repeatCount = NSNotFound;//HUGE_VALF;     //HUGE_VALF,源自math.h
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    
    
    
    CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    centerZoom.duration = 0.5f;
    centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_collectionButton.layer addAnimation:centerZoom forKey:@"buttonScale"];
    
    
    
    //将上述两个动画编组
//    [_collectionButton.layer addAnimation:scaleAnimation forKey:@"transform.scale"];
    
    
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSString * isCollection=[user objectForKey:@"isCollection"];
    
    if ([isCollection isEqualToString:@"0"]) {
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/my_kp_favourite.mob?token=%@&kpID=%@",URLDOMAIN,[user objectForKey:@"token"],self.kpId];
       
        
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
            
            if ([responseObject[@"ret"]isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:@"收藏成功"];
                [user setObject:@"1" forKey:@"isCollection"];
                [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collect_pressed@2x"] forState:UIControlStateNormal];
            }
            if ([responseObject[@"ret"]isEqualToString:@"-1"]) {
                
                [MBProgressHUD showSuccess:@"收藏失败"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }else{
        
        
        [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        
        [MBProgressHUD showSuccess:@"取消收藏成功"];
        
        
        [user setObject:@"0" forKey:@"isCollection"];
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/deleteMyCollected.mob?token=%@&kpIDS=%@&flag=2",URLDOMAIN,[user objectForKey:@"token"],self.kpId];
        
       
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSLog(@"%@",[NSString stringWithUTF8String:object_getClassName(responseObject)]);
            if ([responseObject[@"ret"]isEqualToString:@"1"]) {
                
                
                
                
            }
            if ([responseObject[@"ret"]isEqualToString:@"-1"]) {
                
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    }
    
    

    

    
    

}
-(void)shareKnowledge:(UIBarButtonItem *)button{
    UIActionSheet * s=[[UIActionSheet alloc]initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"朋友圈",@"微信好友", nil];
    s.tag=1000;
    [s showInView:self.view];

}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    image.hidden=YES;
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/kpDetail4New.mob",URLDOMAIN];
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    
    
    
    NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":self.kpId,@"adapterSize":@"1080"};
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * Dic=dic[@"kpData"];
        
        
        [userInfo setObject:Dic forKey:@"KPDATA"];
        
        
        
        
        
        
        NSString * isCollection=[NSString stringWithFormat:@"%@",Dic[@"isCollected"]];
        [userInfo setObject:isCollection forKey:@"isCollection"];
        
        
        
        if ([isCollection isEqualToString:@"0"]) {
            [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
            
        }else{
            
            
            [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collect_pressed@2x"] forState:UIControlStateNormal];
            //        _collectionButton.selected=YES;
            
        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    

    
    
    
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
    
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/add_study_plan.mob",URLDOMAIN];
    
    NSDictionary * dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"title":[[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"],@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"],@"planTime":date};
    NSLog(@"%@",dic);
    
    
    
    
    
    
    
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * str=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
        if ([str isEqualToString:@"1"]) {
            
            
            [MBProgressHUD showSuccess:@"添加成功"];
        }
        if ([str isEqualToString:@"-1"]) {
            
            [MBProgressHUD showError:@"添加失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    switch (type) {
        case DateTypeOfStart:
            
            break;
            
        case DateTypeOfEnd:
            
            break;
        default:
            break;
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex==0) {
        
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        
        NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
        
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSLog(@"%@",responseObject);
            NSString * ret=responseObject[@"ret"];
            
            
            
            
            
            if ([ret isEqualToString:@"success"]) {
                
                
                NSDictionary * dic=[user objectForKey:@"KPDATA"];
                
                
                SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                sendReq.bText = NO;//不使用文本信息
                sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                
                //创建分享内容对象
                WXMediaMessage *urlMessage = [WXMediaMessage message];
                urlMessage.title = dic[@"title"];//分享标题
                urlMessage.description = dic[@"summary"];//分享描述
                
                NSURL *url = [NSURL URLWithString:dic[@"iconUrl"]];
                NSLog(@"1111111111111%@",dic[@"iconUrl"]);
                
                NSData *data = [[NSData alloc] initWithContentsOfURL:url];
               
                UIImage *img = [UIImage imageWithData:data];
                
                
                [urlMessage setThumbImage:img];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                
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
    if (buttonIndex==1) {
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        
        NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_social_share_url.wc?kp_id=%@&social=wx&token=%@",URLDOMAIN,self.kpId,[user objectForKey:@"token"]];
        
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            
            NSString * ret=responseObject[@"ret"];
            if ([ret isEqualToString:@"success"]) {
                
                
                NSDictionary * dic=[user objectForKey:@"KPDATA"];
                
                
                
                SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                sendReq.bText = NO;//不使用文本信息
                sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                
                //创建分享内容对象
                WXMediaMessage *urlMessage = [WXMediaMessage message];
                urlMessage.title = dic[@"title"];//分享标题
                urlMessage.description = dic[@"summary"];//分享描述
                
                NSURL *url = [NSURL URLWithString:self.imageURL];
                NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:data];
                
                
                [urlMessage setThumbImage:img];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                
                //创建多媒体对象
                WXWebpageObject *webObj = [WXWebpageObject object];
                
                
                
                //                    webObj.webpageUrl = responseObject[@"url"];//分享链接
                
                
                webObj.webpageUrl = responseObject[@"url"];
                
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

}
@end
