//
//  smallSampleViewController.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/15.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "smallSampleViewController.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import "WQLStarView.h"
#import "XHStarRateView.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface smallSampleViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIDatePicker * pickerView;
@property(nonatomic,strong)UITextView * conmmentView;
@property(nonatomic,strong)UIView * conmentBackView;
@property(nonatomic,strong)UIButton * koBtn;
@property(nonatomic,strong)UIView * shareBackView;
@property(nonatomic,strong)UIView * mengban;
@end

@implementation smallSampleViewController
{
    WQLStarView * starView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mengban=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _mengban.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView)];
    [_mengban addGestureRecognizer:tapGesture];
    
    [self.navigationController.view addSubview:_mengban];
    
    _mengban.hidden=YES;
    
    UIButton *  button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UISegmentedControl * se=[[UISegmentedControl alloc]initWithItems:@[@"介绍",@"相关知识",@"评论"]];
    
    [se setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [se setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    se.tintColor=[UIColor whiteColor];
    [se addTarget:self action:@selector(myAction:)forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView=se;
    
NSArray * imageNameArr=@[@"kp_detail_calendar_normal",@"kp_detail_zoom_normal",@"kp_detail_comment_normal",@"kp_detail_download_normal"];
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0,HEIGHT-WIDTH *49/375,WIDTH,WIDTH *49/375 )];
    

    
    _bottomView.backgroundColor=[UIColor whiteColor];
    
    for (int i = 0; i<4; i++) {
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*WIDTH/4, 0, WIDTH/4, WIDTH*49/375);
        [button setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        button.tag=i;
        
//        button.backgroundColor=[UIColor redColor];
        
        [button addTarget: self action:@selector(clickBottomView:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
        
    }
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 1, WIDTH, 1)];
    
    view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    
    [self.bottomView addSubview:view];
    
    [self.view addSubview:self.bottomView];
    
    
    [self setCommentTextView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setShareAlert];
    
}

-(void)setShareAlert{
    
    _shareBackView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375)];
    
    _shareBackView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    
    UIButton * weixin=[UIButton buttonWithType:UIButtonTypeCustom];
    weixin.backgroundColor=[UIColor whiteColor];
    weixin.frame=CGRectMake(WIDTH/2-106*WIDTH/375,28*WIDTH/375 ,66*WIDTH/375, 66*WIDTH/375);
    [weixin setImage:[UIImage imageNamed:@"wx_logo_default"] forState:UIControlStateNormal];
    [_shareBackView addSubview:weixin];
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
    _conmmentView=[[UITextView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 93*WIDTH/375, 351*WIDTH/375, 121*WIDTH/375)];
    _conmmentView.text=@"想说的话";
    _conmmentView.delegate=self;
    
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame=CGRectMake(12*WIDTH/375, 227*WIDTH/375, 43*WIDTH/375, 36*WIDTH/375);
    
    cancelBtn.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    
    [cancelBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.layer.cornerRadius=4;
    
    [_conmentBackView addSubview:cancelBtn];
    
    
    
    _koBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _koBtn.frame=CGRectMake(293*WIDTH/375, 227*WIDTH/375, 71*WIDTH/375, 36*WIDTH/375);
    
    _koBtn.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    
    [_koBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_koBtn setTitle:@"发布" forState:UIControlStateNormal];
    
    _koBtn.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 205/255.0, 205/255.0, 205/255.0, 1 });
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
    
    XHStarRateView *starRateView3 = [[XHStarRateView alloc] initWithFrame:CGRectMake(WIDTH*122/375, WIDTH*21/375, WIDTH*130/375, WIDTH*21/375) isCanDian:YES  finish:^(CGFloat currentScore) {
        
    
        if (currentScore==1.0000000) {
            label.text=@"较差";
        }if (currentScore==2.0000000) {
            label.text=@"一般";
        }if (currentScore==3.0000000) {
            label.text=@"良好";
        }if (currentScore==4.0000000) {
            label.text=@"优秀";
        }if (currentScore==5.0000000) {
          label.text=@"极佳";
        }
        
        
    }];
    starRateView3.currentScore=5;
    
    [_conmentBackView addSubview:starRateView3];

    //            starView.backgroundColor=[UIColor redColor];
    

    
    
    
    [self.view addSubview:_conmentBackView];
    
    
    
    
    
    
    

}
-(void)clickBottomView:(UIButton *)button{

    [self setDatePicker];
    
    if (button.tag==0) {
        
        
        
        
        
    
        UIView * botton=[self.view viewWithTag:100];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            botton.frame=CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375);
        }];

    }if (button.tag==1) {
        [self.conmmentView becomeFirstResponder];
    }
    if (button.tag==2) {
        _mengban.hidden=NO;
        [UIView animateWithDuration:0.5 animations:^{
           _shareBackView.frame=CGRectMake(0, HEIGHT-WIDTH*193/375, WIDTH, WIDTH*193/375);
           [self.view bringSubviewToFront:_shareBackView];
            
        }];
    }
    
}
-(void)myAction:(UISegmentedControl *)s{


}
-(void)Back:(UIButton*)button{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setDatePicker{



    UIView * bottom=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375)];
    bottom.tag=100;
    bottom.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, 0, WIDTH/2, WIDTH*43/375)];
    timeLabel.font=[UIFont systemFontOfSize:WIDTH* 14/375];
    timeLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    timeLabel.text=@"无";
    timeLabel.tag=1000;
    
  
    
    UIButton *finishbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    finishbutton.frame=CGRectMake(WIDTH *305/375, 0, WIDTH *70/375, WIDTH *43/375);
    [finishbutton setTitle:@"完成" forState:UIControlStateNormal];
    [finishbutton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [finishbutton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:finishbutton];
    
    self.pickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,WIDTH*43/375, WIDTH,WIDTH*215/375 )];
    
    
    
    _pickerView.backgroundColor=[UIColor whiteColor];
    //指定数据源和委托
   
    _pickerView.datePickerMode=UIDatePickerModeDateAndTime;
    NSDate *minDate = [NSDate date];
    
    
    
    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:365*24*60*60];
    self.pickerView.maximumDate = maxDate;
    
    self.pickerView.minimumDate = minDate;
    [bottom addSubview:self.pickerView];
    
    [self.view addSubview:bottom];



}

-(void)finish{

    
    NSDate *theDate = _pickerView.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    
    
    UIView * botton=[self.view viewWithTag:100];
    [UIView animateWithDuration:0.5 animations:^{
        
        //        UIView * bottom=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375)];
        botton.frame=CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375);
    }];
   
    
    
//    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    
//    
//    NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/add_study_plan.mob",URLDOMAIN];
//    
//    
//    NSLog(@"%@%@%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],[[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"],[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"],[dateFormatter stringFromDate:theDate]);
//    
//    
//    NSDictionary * dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"title":[[NSUserDefaults standardUserDefaults] objectForKey:@"KPDATA"][@"title"],@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"],@"planTime":[dateFormatter stringFromDate:theDate]};
//    
//    
//    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSString * str=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
//        if ([str isEqualToString:@"1"]) {
//            
//            
//            NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
//            
//            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
//            
//            NSDate* date1 = [df dateFromString:[dateFormatter stringFromDate:theDate]];
//            
//            UILocalNotification *notification = [[UILocalNotification alloc] init];
//            
//            NSDate *pushDate = date1;
//            UIApplication *app = [UIApplication sharedApplication];
//            if (notification != nil) {
//                // 设置推送时间
//                notification.fireDate = pushDate;
//                // 设置时区
//                notification.timeZone = [NSTimeZone systemTimeZone];
//                // 设置重复间隔
//                notification.repeatInterval = 0;
//                // 推送声音
//                notification.soundName = UILocalNotificationDefaultSoundName;
//                
//                //                notification.soundName = @"Bell.caf";
//                // 推送内容
//                notification.alertBody = @"是时候学习知识点啦";
//                notification.userInfo=@{@"type":@"alarm",@"kpID":[[NSUserDefaults standardUserDefaults] objectForKey:@"kpID"]};
//                //显示在icon上的红色圈中的数字
//                notification.applicationIconBadgeNumber = 1;
//                //添加推送到UIApplication
//                
//                [app scheduleLocalNotification:notification];
//                
//            }
//            
//            //            else{
//            //                //获取所有除与调度中的数组
//            //                NSArray *locationArr = app.scheduledLocalNotifications;
//            //                if (locationArr)
//            //                {
//            //                    for (UILocalNotification *ln in locationArr)
//            //                    {
//            //                        NSDictionary *dict =  ln.userInfo;
//            //
//            //                        if (dict)
//            //                        {
//            //                            NSString *obj = [dict objectForKey:@"amer.org"];
//            //
//            //                            if ([obj isEqualToString:@"key"])
//            //                            {
//            //                                //取消调度通知
//            //                                [app cancelLocalNotification:ln];
//            //                            }
//            //                        }
//            //                    }
//            //                }
//            //            }
//            
//            
//            
//            
//            
//           
//            
//        }
//       
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//    

    
    
    
    
    _pickerView=nil;
    [_pickerView removeFromSuperview];
    botton = nil;
    [botton removeFromSuperview];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"想说的话"]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"想说的话";
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
    
    
    
    
    [_conmmentView resignFirstResponder];
    
    
    
    
    
}
-(void)compolete:(UIButton *)button{
    _mengban.hidden=YES;
    [_conmmentView resignFirstResponder];

}
-(void)quxiaole:(UIButton *)button{
    _mengban.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        _shareBackView.frame=CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375);
    }];

}
-(void)dismissContactView{

    _mengban.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        _shareBackView.frame=CGRectMake(0, HEIGHT+WIDTH*193/375, WIDTH, WIDTH*193/375);
    }];

}
@end
