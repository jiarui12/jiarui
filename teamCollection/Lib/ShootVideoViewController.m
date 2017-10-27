//
//  ShootVideoViewController.m
//  VideoRecord
//
//  Created by guimingsu on 15/5/4.
//  Copyright (c) 2015年 guimingsu. All rights reserved.
//

#import "ShootVideoViewController.h"
#import "PlayVideoViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "MBProgressHUD+HM.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "WKProgressHUD.h"


#import <CoreGraphics/CoreGraphics.h>
#define TIMER_INTERVAL 0.05
#define VIDEO_FOLDER @"videoFolder"

#import <CoreMotion/CoreMotion.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface ShootVideoViewController ()<AVCaptureFileOutputRecordingDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>//视频文件输出代理

@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层

@property (nonatomic, strong) CMMotionManager * motionManager;

@property (nonatomic) UIInterfaceOrientation deviceOrientation;

@property (strong,nonatomic)  UIView *viewContainer;//视频容器
@property (strong,nonatomic)  UIImageView *focusCursor; //聚焦光标

@property(nonatomic,strong)UIImageView * redView;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIImageView * shuxianImage;
@end

@implementation ShootVideoViewController{
    
    
    UIButton * fiveBtn;
    UIButton * eightBtn;
    UIButton * fifteenBtn;
    
    NSMutableArray* urlArray;//保存视频片段的数组
    
    float currentTime; //当前视频长度
    
    NSTimer *countTimer; //计时器
    UIView* progressPreView; //进度条
    float progressStep; //进度条每次变长的最小单位
    
    float preLayerWidth;//镜头宽
    float preLayerHeight;//镜头高
    float preLayerHWRate; //高，宽比
    
    UIButton* shootBt;//录制按钮
    UIButton* finishBt;//结束按钮
    
    UIButton* flashBt;//闪光灯
    UIButton* cameraBt;//切换摄像头
    
    NSInteger videoMotion;
    NSInteger videomotion;
    
}
@synthesize totalTime;


- (void)startMotionManager{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1/15.0;
    if (_motionManager.deviceMotionAvailable) {
        NSLog(@"Device Motion Available");
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
                                                
                                            }];
    } else {
        NSLog(@"No device motion on device.");
        [self setMotionManager:nil];
    }
}
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    if (fabs(y) >= fabs(x))
    {
        if (y >= 0){
           
            if (_deviceOrientation!=UIInterfaceOrientationPortraitUpsideDown) {
                _deviceOrientation=UIInterfaceOrientationPortraitUpsideDown;
                 videoMotion=2;
            }
            
            
            // UIDeviceOrientationPortraitUpsideDown;
        }
        else{
            // UIDeviceOrientationPortrait;
            
            if ( _deviceOrientation!=UIInterfaceOrientationPortrait) {
                 _deviceOrientation=UIInterfaceOrientationPortrait;
                 videoMotion=1;
            }
            
        }
    }
    else
    {
        if (x >= 0){
            // UIDeviceOrientationLandscapeRight;
            if (_deviceOrientation!=UIInterfaceOrientationLandscapeRight) {
                _deviceOrientation=UIInterfaceOrientationLandscapeRight;
                videoMotion=4;
            }
            
            
           
        }
        else{
            // UIDeviceOrientationLandscapeLeft;
            if ( _deviceOrientation!=UIInterfaceOrientationLandscapeLeft) {
                 _deviceOrientation=UIInterfaceOrientationLandscapeLeft;
                 videoMotion=3;
            }
            
        }
    }
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self startMotionManager];
    
   
    currentTime=0;
    
    _shuxianImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH *16.5/375, SCREEN_HEIGHT*24.5/666.7)];
    
    _shuxianImage.image=[UIImage imageNamed:@"icon_suspend_defult@2x"];
    
//    _redView.hidden=YES;
    
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0x1d1e20);
    self.title = @"视频录制";
    
    //视频最大时长 默认10秒
    if (totalTime==0) {
        totalTime =900;
    }

    urlArray = [[NSMutableArray alloc]init];
    
    preLayerWidth = SCREEN_WIDTH;
    preLayerHeight = SCREEN_WIDTH;
    preLayerHWRate =preLayerHeight/preLayerWidth;
    
    
    
    [self createVideoFolderIfNotExist];
    [self initCapture];
}

-(void)initCapture{
    
    //视频高度加进度条（10）高度
    self.viewContainer = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.viewContainer];
    
    self.focusCursor = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.focusCursor setImage:[UIImage imageNamed:@"focusImg"]];
    self.focusCursor.alpha = 0;
    [self.viewContainer addSubview:self.focusCursor];
    
    
    
    UIView * buttomView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*537/667 , SCREEN_WIDTH,SCREEN_HEIGHT *130/667)];
    buttomView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.viewContainer addSubview:buttomView];
    
    UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*40/667)];
    
    topView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    topView.tag=105;
    [self.viewContainer addSubview:topView];
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*40/667)];
    
    _timeLabel.text=@"00:00";
    _timeLabel.textColor=[UIColor whiteColor];
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    
    [self.viewContainer addSubview:_timeLabel];
    
    
//    UIView* btView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
//    btView.center = CGPointMake(SCREEN_WIDTH/2, self.view.frame.size.height-53);
//    [btView makeCornerRadius:30 borderColor:nil borderWidth:0];
//    btView.backgroundColor = UIColorFromRGB(0xeeeeee);
//    [self.view addSubview:btView];
    eightBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    eightBtn.frame=CGRectMake(0, 0, 40, 30);
    
    [eightBtn addTarget:self action:@selector(selectVideoTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    eightBtn.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*555/667);
//    eightBtn.backgroundColor=[UIColor redColor];
    [eightBtn setTitle:@"8分钟" forState:UIControlStateNormal];
    eightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [eightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewContainer addSubview:eightBtn];
    
    fiveBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    fiveBtn.frame=CGRectMake(0, 0, 40, 30);
    
    fiveBtn.center=CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT*555/667);
     [fiveBtn addTarget:self action:@selector(selectVideoTime:) forControlEvents:UIControlEventTouchUpInside];
    [fiveBtn setTitle:@"5分钟" forState:UIControlStateNormal];
    fiveBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [fiveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewContainer addSubview:fiveBtn];
    
    
    fifteenBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    fifteenBtn.frame=CGRectMake(0, 0, 50, 30);
    
    fifteenBtn.center=CGPointMake(SCREEN_WIDTH/3*2, SCREEN_HEIGHT*555/667);
     [fifteenBtn addTarget:self action:@selector(selectVideoTime:) forControlEvents:UIControlEventTouchUpInside];
    [fifteenBtn setTitle:@"15分钟" forState:UIControlStateNormal];
    fifteenBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    fifteenBtn.enabled=NO;
    [fifteenBtn setTitleColor:UIColorFromRGB(0xffda00) forState:UIControlStateNormal];
    [self.viewContainer addSubview:fifteenBtn];
    
    
    
    
    shootBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.view.frame.size.height-53,SCREEN_HEIGHT*60/667, SCREEN_HEIGHT*60/667)];
    shootBt.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*610/667);

    [shootBt setImage:[UIImage imageNamed:@"icon_play_defult@2x"] forState:UIControlStateNormal];
    
    [shootBt addTarget:self action:@selector(shootButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.viewContainer addSubview:shootBt];
    
    
    
    [self.viewContainer addSubview:_shuxianImage];
    
    _shuxianImage.center=shootBt.center;
    finishBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*3-SCREEN_WIDTH* 28.5/375/2,SCREEN_HEIGHT*1205/1334 ,SCREEN_WIDTH* 28.5/375, SCREEN_WIDTH* 20.5/375)];
//    finishBt.center = CGPointMake(SCREEN_WIDTH-35, self.view.frame.size.height-53);
    finishBt.adjustsImageWhenHighlighted = NO;
    [finishBt setBackgroundImage:[UIImage imageNamed:@"baocun@2x"] forState:UIControlStateNormal];
    [finishBt addTarget:self action:@selector(finishBtTap) forControlEvents:UIControlEventTouchUpInside];
    finishBt.hidden = YES;
    [self.view addSubview:finishBt];
    
    
    UIButton * localBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    localBtn.frame=CGRectMake(SCREEN_WIDTH*545/750,SCREEN_HEIGHT*1190/1334 ,100, 30) ;
//    localBtn.center=CGPointMake(SCREEN_WIDTH-35, SCREEN_HEIGHT-53);
    [localBtn setTitle:@"本地上传" forState:UIControlStateNormal] ;
    localBtn.tag=100;
    localBtn.titleLabel.font=[UIFont systemFontOfSize:SCREEN_WIDTH * 18/375];
    [localBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [localBtn addTarget:self action:@selector(loocalVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:localBtn];
    
    
    
    
    
    
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset640x480]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset640x480;
    }
    
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice=[[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];

    AVCaptureDeviceInput *audioCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];

    //初始化设备输出对象，用于获得输出数据
    _captureMovieFileOutput=[[AVCaptureMovieFileOutput alloc]init];
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:audioCaptureDeviceInput];
        AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported ]) {
            captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
        }
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer= self.viewContainer.layer;
    layer.masksToBounds=YES;
    
    _captureVideoPreviewLayer.frame=  CGRectMake(0, 0, preLayerWidth, self.view.frame.size.height);
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    [layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];

//    [self addGenstureRecognizer];
    
    //进度条
    progressPreView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*535/667, 0, 4)];
    progressPreView.backgroundColor = UIColorFromRGB(0xffda00);
    [progressPreView makeCornerRadius:2 borderColor:nil borderWidth:0];
    
    UIView * backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*535/667, SCREEN_WIDTH, 4)];
    backgroundView.backgroundColor=UIColorFromRGB(0xc8c8c8);
    [self.viewContainer addSubview:backgroundView];
    
    [self.viewContainer addSubview:progressPreView];
    
    flashBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT * 5/667, SCREEN_WIDTH*34/375, SCREEN_WIDTH*34/375)];
    [flashBt setImage:[UIImage imageNamed:@"icon_changeshuanguangdeng@2x"] forState:UIControlStateNormal];
//    [flashBt makeCornerRadius:17 borderColor:nil borderWidth:0];
    [flashBt addTarget:self action:@selector(flashBtTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContainer addSubview:flashBt];
    
    cameraBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, SCREEN_HEIGHT * 5/667, SCREEN_WIDTH*34/375, SCREEN_WIDTH*34/375)];
    [cameraBt setImage:[UIImage imageNamed:@"icon_changecamera_defult@2x"] forState:UIControlStateNormal];
//    [cameraBt makeCornerRadius:17 borderColor:nil borderWidth:0];
    [cameraBt addTarget:self action:@selector(changeCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContainer addSubview:cameraBt];
    
    
    UIButton * returnBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame=CGRectMake(SCREEN_WIDTH * 5/375,SCREEN_HEIGHT *5/667, SCREEN_WIDTH * 34/375, SCREEN_WIDTH * 34/375);
    
    [returnBtn setImage:[UIImage imageNamed:@"quxiao@2x"] forState:UIControlStateNormal];
    returnBtn.tag=1200;
    [returnBtn addTarget:self action:@selector(Return:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewContainer addSubview:returnBtn];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    button.frame=CGRectMake(SCREEN_WIDTH/4-SCREEN_WIDTH* 18.5/375/2, SCREEN_HEIGHT*1205/1334,SCREEN_WIDTH* 18.5/375, SCREEN_WIDTH* 20.5/375);
//    button.center = CGPointMake(35, self.view.frame.size.height-53);
//    [button setImage:[UIImage imageNamed:@"shanchu@2x"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"shanchu@2x"] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:19];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.tag=102;
    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    button.hidden=YES;
    [self.view addSubview:button];
    
    
    _redView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40,SCREEN_HEIGHT *16/667, 8, 8)];
    
    _redView.backgroundColor=[UIColor redColor];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setDuration:0.8];
    [animation setAutoreverses:YES];    //这里设置是否恢复初始的状态,
    [animation setRepeatCount:100000000];   //设置重复次数
    [animation setFromValue:[NSNumber numberWithInt:1.0]];  //设置透明度从1 到 0
    [animation setToValue:[NSNumber numberWithInt:0.0]];
    [_redView.layer addAnimation:animation forKey:@"opatity-animation"];
    _redView.layer.cornerRadius=4;
    [self.viewContainer addSubview:_redView];
    _redView.hidden=YES;
}
-(void)selectVideoTime:(UIButton *)button{

    if (button==fiveBtn) {
        totalTime =300;
        [fiveBtn setTitleColor:UIColorFromRGB(0xffda00) forState:UIControlStateNormal];
        fiveBtn.enabled=NO;
        fifteenBtn.enabled=YES;
        eightBtn.enabled=YES;
        [eightBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [fifteenBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    }else if (button==fifteenBtn){
    
        totalTime =900;
        [fifteenBtn setTitleColor:UIColorFromRGB(0xffda00) forState:UIControlStateNormal];
        fifteenBtn.enabled=NO;
        fiveBtn.enabled=YES;
        eightBtn.enabled=YES;
        
        [eightBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [fiveBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    }else if (button==eightBtn){
        totalTime =480;
        [eightBtn setTitleColor:UIColorFromRGB(0xffda00) forState:UIControlStateNormal];
        fifteenBtn.enabled=YES;
        fiveBtn.enabled=YES;
        eightBtn.enabled=NO;
        [fifteenBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [fiveBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    }


}
-(void)delete:(id)sender{
    UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"重拍后已拍摄内容会丢失" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重拍", nil];
    av.tag=200;
    [av show];



}
-(void)loocalVideo:(UIButton *)button{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                            imagePicker.delegate = self;
                           imagePicker.allowsEditing = YES;
                           imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    
    
            [self presentViewController:imagePicker animated:YES completion:^{
    
            }];
    
    

}
-(void)Return:(UIButton *)button{
    
    if (currentTime!=0) {
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"退出后已拍摄内容会丢失" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        
        [av show];
        
    }else{
    
   [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
   }];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==200) {
  
        if (buttonIndex==0) {
            
        }else{
        
            [self deleteAllVideos];
            currentTime = 0;
            [progressPreView setFrame:CGRectMake(0, preLayerHeight, 0, 4)];
            UIButton * button=[self.view viewWithTag:102];
            button.hidden=YES;
            UIButton * Btn=[self.view viewWithTag:100];
            Btn.hidden=NO;
            finishBt.hidden=YES;
            _timeLabel.text=@"00:00";
            fiveBtn.enabled=YES;
            fifteenBtn.enabled=YES;
            eightBtn.enabled=YES;
            
            if (totalTime==480) {
                [fiveBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                [fifteenBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            }else if (totalTime==900){
                [fiveBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                [eightBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                
            }else{
                [eightBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                [fifteenBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                
            }
            
            
            
        }
        
        
        
        
    }else{
    
    
    
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex==0) {
        
    }else{
        [self deleteAllVideos];
        currentTime = 0;
        [progressPreView setFrame:CGRectMake(0, preLayerHeight, 0, 4)];
        
           [self dismissViewControllerAnimated:YES completion:^{
               
           }];
    
    }
    
    }
}








-(void)flashBtTap:(UIButton*)bt{
    if (bt.selected == YES) {
        bt.selected = NO;
        //关闭闪光灯
        [flashBt setImage:[UIImage imageNamed:@"icon_changeshuanguangdeng@2x"] forState:UIControlStateNormal];
        [self setTorchMode:AVCaptureTorchModeOff];
    }else{
        bt.selected = YES;
        //开启闪光灯
        [flashBt setImage:[UIImage imageNamed:@"icon_shanguangdeng_open@2x"] forState:UIControlStateNormal];
        [self setTorchMode:AVCaptureTorchModeOn];
    }
}

-(void)startTimer{

    
    countTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
    
    
    [countTimer fire];
}

-(void)stopTimer{

    
    [countTimer invalidate];
    countTimer = nil;
    
}
- (void)onTimer:(NSTimer *)timer
{
    
    
    currentTime += TIMER_INTERVAL;
    
  //  NSLog(@"%f",currentTime);
    
//    NSDate *a=[NSDate dateWithTimeIntervalSinceReferenceDate:currentTime];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:currentTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        [formatter setDateFormat:@"mm:ss"];
  

    NSString *showtimeNew = [formatter stringFromDate:d];
    _timeLabel.text=showtimeNew;

    
    
    float progressWidth = progressPreView.frame.size.width+progressStep;
    [progressPreView setFrame:CGRectMake(0, SCREEN_HEIGHT*535/667, progressWidth, 4)];
    
    
    
    
    //时间到了停止录制视频
    if (currentTime>=totalTime) {
        [countTimer invalidate];
        countTimer = nil;
        [_captureMovieFileOutput stopRecording];
    }
    
}
-(void)finishBtTap{
    
    currentTime=totalTime+10;
    [countTimer invalidate];
    countTimer = nil;
    
    //正在拍摄
    if (_captureMovieFileOutput.isRecording) {
        [_captureMovieFileOutput stopRecording];
    }else{//已经暂停了
        [self mergeAndExportVideosAtFileURLs:urlArray];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.captureSession startRunning];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
    
    //还原数据-----------
//    [self deleteAllVideos];
//    currentTime = 0;
//    [progressPreView setFrame:CGRectMake(0, preLayerHeight, 0, 4)];
    
//    finishBt.hidden = NO;
}

#pragma mark 视频录制
- (void)shootButtonClick{
    //根据设备输出获得连接
    
    UIButton * button=[self.view viewWithTag:102];
    UIButton * button1=[self.view viewWithTag:1200];
    UIView * view=[self.view viewWithTag:105];
    
    AVCaptureConnection *captureConnection=[self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //根据连接取得设备输出的数据
    if (![self.captureMovieFileOutput isRecording]) {
         progressStep = SCREEN_WIDTH*TIMER_INTERVAL/totalTime;
        //预览图层和视频方向保持一致
        [_motionManager stopGyroUpdates];
        [shootBt setImage:[UIImage imageNamed:@"image_red@2x"] forState:UIControlStateNormal];
        
        
        UIButton * buff=[self.view viewWithTag:100];
        
        buff.hidden=YES;
        
        CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        centerZoom.duration = 2.f;
        centerZoom.repeatCount=1000000;
        
        centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
        centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

        [shootBt.layer addAnimation:centerZoom forKey:@"buttonScale"];
        
        
        captureConnection.videoOrientation=[self.captureVideoPreviewLayer connection].videoOrientation;
        captureConnection.videoOrientation=videoMotion;
        videomotion=videoMotion;
        NSLog(@"视频方向%ld",(long)videoMotion);
        
        [self.captureMovieFileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:[self getVideoSaveFilePathString]] recordingDelegate:self];
        
         finishBt.hidden = YES;
        flashBt.hidden=YES;
        cameraBt.hidden=YES;
        button.hidden=YES;
        view.hidden=YES;
        fiveBtn.enabled=NO;
        fifteenBtn.enabled=NO;
        eightBtn.enabled=NO;
        
        button1.hidden=YES;
        _redView.hidden=NO;
        
        if (totalTime==480) {
            [fiveBtn setTitleColor:UIColorFromRGB(0xafafaf) forState:UIControlStateNormal];
            [fifteenBtn setTitleColor:UIColorFromRGB(0xafafaf) forState:UIControlStateNormal];
        }else if (totalTime==900){
            [fiveBtn setTitleColor:UIColorFromRGB(0xafafaf) forState:UIControlStateNormal];
            [eightBtn setTitleColor:UIColorFromRGB(0xafafaf) forState:UIControlStateNormal];
        
        }else{
            [eightBtn setTitleColor:UIColorFromRGB(0xafafaf) forState:UIControlStateNormal];
            [fifteenBtn setTitleColor:UIColorFromRGB(0xafafaf) forState:UIControlStateNormal];
        
        }
        
        
        
    }
    else{
        [shootBt.layer removeAnimationForKey:@"buttonScale"];
        [shootBt setImage:[UIImage imageNamed:@"icon_play_defult@2x"] forState:UIControlStateNormal];
        
        [self stopTimer];
        [self.captureMovieFileOutput stopRecording];//停止录制
         finishBt.hidden = NO;
         flashBt.hidden=NO;
        cameraBt.hidden=NO;
        button.hidden=NO;
        view.hidden=NO;
        _redView.hidden=YES;
        button1.hidden=NO;
        
        
    }
}
#pragma mark 切换前后摄像头
- (void)changeCamera:(UIButton*)bt {
    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition=[currentDevice position];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront) {
        toChangePosition=AVCaptureDevicePositionBack;
        flashBt.hidden = NO;
    }else{
        flashBt.hidden = YES;
    }
    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput=toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];
    
    //关闭闪光灯
    flashBt.selected = NO;
    [flashBt setBackgroundImage:[UIImage imageNamed:@"flashOn"] forState:UIControlStateNormal];
    [self setTorchMode:AVCaptureTorchModeOff];
    
}

#pragma mark - 视频输出代理
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"开始录制...");
    [self startTimer];
}
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    [urlArray addObject:outputFileURL];
    //时间到了
    if (currentTime>=totalTime) {
        [self mergeAndExportVideosAtFileURLs:urlArray];
    }
}



- (void)mergeAndExportVideosAtFileURLs:(NSMutableArray *)fileURLArray
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"视频处理中..." animated:YES];
    
    NSError *error = nil;
    
    CGSize renderSize = CGSizeMake(0, 0);
    
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    CMTime totalDuration = kCMTimeZero;
    
    NSMutableArray *assetTrackArray = [[NSMutableArray alloc] init];
    NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    for (NSURL *fileURL in fileURLArray) {
        
        AVAsset *asset = [AVAsset assetWithURL:fileURL];
        [assetArray addObject:asset];
        
        NSArray* tmpAry =[asset tracksWithMediaType:AVMediaTypeVideo];
        if (tmpAry.count>0) {
            AVAssetTrack *assetTrack = [tmpAry objectAtIndex:0];
            [assetTrackArray addObject:assetTrack];
            renderSize.width = MAX(renderSize.width, assetTrack.naturalSize.height);
            renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
        }
    }
    
    CGFloat renderW = MIN(renderSize.width, renderSize.height);
    
    for (int i = 0; i < [assetArray count] && i < [assetTrackArray count]; i++) {
        
        AVAsset *asset = [assetArray objectAtIndex:i];
        AVAssetTrack *assetTrack = [assetTrackArray objectAtIndex:i];
        
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        NSArray*dataSourceArray= [asset tracksWithMediaType:AVMediaTypeAudio];
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:([dataSourceArray count]>0)?[dataSourceArray objectAtIndex:0]:nil
                             atTime:totalDuration
                              error:nil];
        
        AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:assetTrack
                             atTime:totalDuration
                              error:&error];
        
        AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
        
        CGFloat rate;
        rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
        
        CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx * rate, assetTrack.preferredTransform.ty * rate);
        layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0+preLayerHWRate*(preLayerHeight-preLayerWidth)/2));
        layerTransform = CGAffineTransformScale(layerTransform, rate, rate);
        
        [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
        [layerInstruciton setOpacity:0.0 atTime:totalDuration];

        [layerInstructionArray addObject:layerInstruciton];
    }
    
    NSString *path = [self getVideoMergeFilePathString];
    NSURL *mergeFileURL = [NSURL fileURLWithPath:path];
    
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
    mainInstruciton.layerInstructions = layerInstructionArray;
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions = @[mainInstruciton];
    mainCompositionInst.frameDuration = CMTimeMake(1, 100);
    mainCompositionInst.renderSize = CGSizeMake(renderW, renderW*preLayerHWRate);
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition = mainCompositionInst;
    exporter.outputURL = mergeFileURL;
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud dismiss:YES];
            PlayVideoViewController* view = [[PlayVideoViewController alloc]init];
            view.videoURL =mergeFileURL;
            view.motion=videomotion;
            [self.navigationController pushViewController:view animated:YES];
//            [self presentViewController:view animated:YES completion:^{
//                
//            }];
            
            
        });
    }];
    
    
}
//最后合成为 mp4
- (NSString *)getVideoMergeFilePathString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@"merge.mp4"];
    
    return fileName;
}

//录制保存的时候要保存为 mov
- (NSString *)getVideoSaveFilePathString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@".mov"];
    
    return fileName;
}

- (void)createVideoFolderIfNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建保存视频文件夹失败");
        }
    }
}
- (void)deleteAllVideos
{
    for (NSURL *videoFileURL in urlArray) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *filePath = [[videoFileURL absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath]) {
                NSError *error = nil;
                [fileManager removeItemAtPath:filePath error:&error];
                
                if (error) {
                    NSLog(@"delete All Video 删除视频文件出错:%@", error);
                }
            }
        });
    }
    [urlArray removeAllObjects];
}

#pragma mark - 私有方法
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}

-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

-(void)setTorchMode:(AVCaptureTorchMode )torchMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isTorchModeSupported:torchMode]) {
            [captureDevice setTorchMode:torchMode];
        }
    }];
}

-(void)setFocusMode:(AVCaptureFocusMode )focusMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}

-(void)setExposureMode:(AVCaptureExposureMode)exposureMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
    }];
}

-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}

-(void)addGenstureRecognizer{
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
//    [self.viewContainer addGestureRecognizer:tapGesture];
}
-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
//    CGPoint point= [tapGesture locationInView:self.viewContainer];
//    //将UI坐标转化为摄像头坐标
//    CGPoint cameraPoint= [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
//    [self setFocusCursorWithPoint:point];
//    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

-(void)setFocusCursorWithPoint:(CGPoint)point{
//    self.focusCursor.center=point;
//    self.focusCursor.transform=CGAffineTransformMakeScale(1.5, 1.5);
//    self.focusCursor.alpha=1.0;
//    [UIView animateWithDuration:1.0 animations:^{
//        self.focusCursor.transform=CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        self.focusCursor.alpha=0;
//        
//    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     [_motionManager stopDeviceMotionUpdates];
 [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}
-(void)viewWillAppear:(BOOL)animated{
   
//    self.tabBarController.tabBar.hidden=YES;
//    
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=YES;
    
    
    self.navigationController.navigationBarHidden=YES;
    
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    
    if (currentTime==0) {
        UIButton * button=[self.view viewWithTag:100];
        
        button.hidden=NO;
    }
    

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    
    
    [self dismissViewControllerAnimated:YES completion:nil];

//    NSData * data=[NSData dataWithContentsOfFile:info[@"UIImagePickerControllerMediaURL"]];
    
    
    
    PlayVideoViewController* view = [[PlayVideoViewController alloc]init];
    view.videoURL =info[@"UIImagePickerControllerMediaURL"];
    [self.navigationController pushViewController:view animated:YES];
    
    
    
}
@end
