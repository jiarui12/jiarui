//
//  PlayVideoViewController.m
//  VideoRecord
//
//  Created by guimingsu on 15/4/27.
//  Copyright (c) 2015年 guimingsu. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "mySlider.h"
#import "myLocalValueViewController.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface PlayVideoViewController ()<UITextFieldDelegate,CALayerDelegate>
@property (nonatomic,strong)NSTimer *avTimer;
@property (nonatomic,strong)UISlider * slider;
@property(nonatomic,strong)mySlider * my;
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)UILabel * nowLabel;
@property(nonatomic,strong)UILabel * titalLabel;
@end

@implementation PlayVideoViewController
{

    
    AVPlayerLayer *playerLayer;
    AVPlayerItem *playerItem;
    
    UIImageView* playImg;
    CGFloat totalMovieDuration;
}

@synthesize videoURL;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"预览";
    
    UIView * blackView=[[UIView alloc]initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width/16*9)];
    blackView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:blackView];
    
    UIButton * finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame=CGRectMake(0, 0, Width*60/375, Width*60/375);
    
    [finishBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [finishBtn setImage:[UIImage imageNamed:@"image_accomplish_defult@2x"] forState:UIControlStateNormal];
    finishBtn.center=CGPointMake(Width/2,Height*895/1334);
    
    [self.view addSubview:finishBtn];
    
    float videoWidth = self.view.frame.size.width;
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    
    
    
    if (!self.motion) {
    NSArray *tracks = [movieAsset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
            self.motion=1;
        }else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
self.motion=2;        }else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
self.motion=3;        }else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
self.motion=4;        }
    }
    
    }
    
    
    
   CMTime totleTime = movieAsset.duration;
    totalMovieDuration  = ceil(totleTime.value/totleTime.timescale);
    
   
    playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer.delegate=self;
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_return_defult@2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    [self.player.currentItem addObserver:self forKeyPath:@"status"
                                 options:NSKeyValueObservingOptionNew
                                 context:nil];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    NSLog(@"%f       %f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width/16*9);
    
    if (self.motion==1) {
       
         playerLayer.frame = CGRectMake(videoWidth/2-videoWidth/16*9/16*9/2, 64,videoWidth/16*9/16*9 , videoWidth/16*9);
    }else if(self.motion==2){
        playerLayer.frame = CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width/16*9);
    }else if(self.motion==3){
        playerLayer.frame = CGRectMake(0, 64,videoWidth , [UIScreen mainScreen].bounds.size.height*180/568);
    }else if(self.motion==4){
        playerLayer.frame = CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width/16*9);
    }else{
    
    playerLayer.frame = CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width/16*9);
    }
    
    playerLayer.backgroundColor=(__bridge CGColorRef _Nullable)([UIColor redColor]);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer addSublayer:playerLayer];
    
    UITapGestureRecognizer *playTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playOrPause)];
   // [self.view addGestureRecognizer:playTap];
    
//    [self pressPlayButton];
    
       // self.avTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer)userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
   
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 64+videoWidth/16*9-self.view.frame.size.height * 60/1334, videoWidth,self.view.frame.size.height * 60/1334)];
    view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:view];
    
   _my=[[mySlider alloc]init];
   // _slider=[[UISlider alloc]initWithFrame:CGRectMake(Width *50/375,Height*13/667,Width*275/375,Height *8/667)];
    
    _my.minimumValue = 0;//设置最小值
    _my.maximumValue = 1;
    
    _my.minimumTrackTintColor = UIColorFromRGB(0x1dabfd);
    _my.maximumTrackTintColor = UIColorFromRGB(0x444444);
    [_my setThumbImage:[UIImage imageNamed:@"image_rate_defult@2x"] forState:UIControlStateNormal];
    [_my setThumbImage:[UIImage imageNamed:@"image_rate_defult@2x"] forState:UIControlStateHighlighted];
   //默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
    
    [self.my addTarget:self action:@selector(scrubbingDidBegin) forControlEvents:UIControlEventTouchDown];
    [self.my addTarget:self action:@selector(scrubberIsScrolling) forControlEvents:UIControlEventValueChanged];
    [self.my addTarget:self action:@selector(scrubbingDidEnd) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel)];
    _my.continuous=YES;
    view.userInteractionEnabled=YES;
    
    self.view.userInteractionEnabled=YES;
    [view addSubview:_my];
    _nowLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width *50/375, self.view.frame.size.height * 60/1334)];
    _nowLabel.text=@"00:00";
    _nowLabel.font=[UIFont systemFontOfSize:14];
    _nowLabel.textColor=[UIColor whiteColor];
    _nowLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:_nowLabel];
    _titalLabel=[[UILabel alloc]initWithFrame:CGRectMake(Width*325/375, 0, Width *50/375, self.view.frame.size.height * 60/1334)];
    _titalLabel.text=@"15:00";
    _titalLabel.font=[UIFont systemFontOfSize:14];
    _titalLabel.textColor=[UIColor whiteColor];
    _titalLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:_titalLabel];
    
    UIView * clearView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height * 503/1334 )];
    clearView.backgroundColor=[UIColor clearColor];
    [clearView addGestureRecognizer:playTap];
    
    [self.view addSubview:clearView];
    playImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 50/375, self.view.frame.size.width * 50/375)];
    playImg.center = CGPointMake(videoWidth/2, self.view.frame.size.height * 680/1334/2);
    [playImg setImage:[UIImage imageNamed:@"icon_played_defult@2x"]];
    [self.view addSubview:playImg];
    playImg.hidden = YES;
     [_player play];
    self.view.backgroundColor=UIColorFromRGB(0xc8c8c8);
}
-(void)finish:(UIButton *)button{

//    myLocalValueViewController * my=[[myLocalValueViewController alloc]init];
//    [self.navigationController pushViewController:my animated:YES];
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
       
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        gen.appliesPreferredTrackTransform = YES;
        
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        
        NSError *error = nil;
        
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        
        CGImageRelease(image);
        
        NSLog(@"%@",thumb);
        
//        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 500, 80, 80)];
        
//        imageView.image=thumb;
//        [self.view addSubview:imageView];
        
        NSString *path_sandox = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //设置一个图片的存储路径
        NSString *imagePath = [path_sandox stringByAppendingString:@"/flower.png"];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
      BOOL success =[UIImagePNGRepresentation(thumb) writeToFile:imagePath atomically:YES];
        if (success){
            NSLog(@"写入本地成功");
        }
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        [user setObject:imagePath forKey:@"smallImage"];
        
    }];
    
    
    
}
-(void)Back:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:YES];

}


-(void)playOrPause{
    if (playImg.isHidden) {
        playImg.hidden = NO;
        [_player pause];
    }else{
        playImg.hidden = YES;
        [_player play];
    }
}

- (void)pressPlayButton
{
    [playerItem seekToTime:kCMTimeZero];
    [_player play];
}

- (void)playingEnd:(NSNotification *)notification
{
    if (playImg.isHidden) {
        [self pressPlayButton];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    
    self.navigationController.navigationBarHidden=NO;
[[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)scrubberIsScrolling
{
    
    NSLog(@"滑动");
    double currentTime = floor(totalMovieDuration *self.my.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    [_player seekToTime:dragedCMTime completionHandler:
     ^(BOOL finish)
     {
         
         
             [_player play];
         playImg.hidden = YES;
     }];
}

//按动滑块
-(void)scrubbingDidBegin
{
    NSLog(@"按动滑块");
    playImg.hidden = NO;
    [_player pause];
}


-(void)scrubbingDidEnd
{
    NSLog(@"结束");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem1 = (AVPlayerItem*)object;
        if (playerItem1.status==AVPlayerStatusReadyToPlay) {
            //视频加载完成
            
            //计算视频总时间
            CMTime totalTime = playerItem1.duration;
            totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
            NSDate *d = [NSDate dateWithTimeIntervalSince1970:totalMovieDuration];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            if (totalMovieDuration/3600 >= 1) {
                [formatter setDateFormat:@"HH:mm:ss"];
            }
            else
            {
                [formatter setDateFormat:@"mm:ss"];
            }
            NSString *showtimeNew = [formatter stringFromDate:d];
            _titalLabel.text=showtimeNew;
            __weak typeof(self)weakself = self;
            CGFloat weakTotalMovieDuration = totalMovieDuration;
            
            [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time){
                //获取当前时间
                CMTime currentTime =weakself.player.currentItem.currentTime;
                //转成秒数
                CGFloat currentPlayTime = (CGFloat)currentTime.value/currentTime.timescale;
                weakself.my.value = (float)currentPlayTime/weakTotalMovieDuration;
                
                NSDate *d = [NSDate dateWithTimeIntervalSince1970:currentPlayTime];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                if (currentPlayTime/3600 >= 1) {
                    [formatter setDateFormat:@"HH:mm:ss"];
                }
                else
                {
                    [formatter setDateFormat:@"mm:ss"];
                }
                NSString *showtimeNew = [formatter stringFromDate:d];
                weakself.nowLabel.text=showtimeNew;

                
                
            }];
            
           // [_player play];
           // isPlaying = YES;
            
        }
    }
   
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];

}

@end
