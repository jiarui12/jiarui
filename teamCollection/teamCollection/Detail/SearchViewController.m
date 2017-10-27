//
//  SearchViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/2/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SearchViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface SearchViewController ()<AVCaptureFileOutputRecordingDelegate>
@property(nonatomic,strong)AVCaptureMovieFileOutput * output;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"关键词搜索";
    /* 设置背景颜色防止卡顿  */
    self.view.backgroundColor=[UIColor whiteColor];
    /* 替换左按钮为自定义图片 */
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *inputVideo = [AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:NULL];
    AVCaptureDevice * deviceAudio=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput * inputAudio=[AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:NULL];
    AVCaptureMovieFileOutput * output=[[AVCaptureMovieFileOutput alloc]init];
    self.output=output;
    AVCaptureSession * session=[[AVCaptureSession alloc]init];
    if ([session canAddInput:inputVideo]) {
        [session addInput:inputVideo];
    }
    if ([session canAddInput:inputAudio]) {
        [session addInput:inputAudio];
    }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    AVCaptureVideoPreviewLayer * preLayer=[AVCaptureVideoPreviewLayer layerWithSession:session];
    preLayer.frame=self.view.bounds;
    [self.view.layer addSublayer:preLayer];
    [session startRunning];
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(30, 30, 30, 20);
    [btn setTitle:@"暂停" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)clickVideoBtn:(UIButton*)button{
    if ([self.output isRecording]) {
        [self.output stopRecording];
        [button setTitle:@"录制" forState:UIControlStateNormal];
        return;
    }
    [button setTitle:@"停止" forState:UIControlStateNormal];
    NSString * path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"myVideo.mov"];
    NSURL * url=[NSURL fileURLWithPath:path];
    
    [self.output startRecordingToOutputFileURL:url recordingDelegate:self];
    
}
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
   NSLog(@"录制完成，可做进一步处理");
}
-(void)Back:(UIBarButtonItem * )button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
