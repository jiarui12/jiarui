//
//  SGScanningQRCodeVC.m
//  SGQRCodeExample
//
//  Created by Sorgle on 16/8/25.
//  Copyright © 2016年 Sorgle. All rights reserved.
//


#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGScanningQRCodeView.h"
#import "ScanSuccessJumpVC.h"
#import "SGQRCodeTool.h"
#import <Photos/Photos.h>
#import "SGAlertView.h"
#import "biaoganViewController.h"
#import "DynamicViewController.h"
#import "PrefixHeader.pch"
@interface SGScanningQRCodeVC () <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) SGScanningQRCodeView *scanningView;

@property (nonatomic, strong) UIButton *right_Button;
@property (nonatomic, assign) BOOL first_push;
@property (nonatomic, strong)NSString * flag;
@end

@implementation SGScanningQRCodeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 创建扫描边框
  
    self.scanningView = [[SGScanningQRCodeView alloc] init];
    self.scanningView = [[SGScanningQRCodeView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    [self.view addSubview:self.scanningView];
    [self setupScanningQRCode];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"扫一扫";

    // 二维码扫描
//    [self setupScanningQRCode];
    
    self.first_push = YES;
    
    // rightBarButtonItem
  UIButton * _button1=[UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame=CGRectMake(0, 0, 10, 20);
    [_button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:_button1];
    [_button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
}

// rightBarButtonItem
-(void)Back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];


}
#pragma mark - - - rightBarButtonItenAction 的点击事件
- (void)rightBarButtonItenAction {
    [self readImageFromAlbum];
}
#pragma mark - - - 从相册中读取照片
- (void)readImageFromAlbum {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
                        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
                        imagePicker.delegate = self; // 指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
                        [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相册权限
                    NSLog(@"用户第一次同意了访问相册权限");
                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相册");
                }
            }];
       
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
            imagePicker.delegate = self; // 指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
            [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册

        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 照片 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
            
        } else if (status == PHAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
        
    } else {
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
}
#pragma mark - - - UIImagePickerControllerDelegate
/*
// 此方法，已过期
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {

    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:image];
    }];
}
*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info - - - %@", info);
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    }];
}
#pragma mark - - - 从相册中识别二维码, 并进行界面跳转
- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image {
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *scannedResult = feature.messageString;
        
        if (self.first_push) {
            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
            jumpVC.jump_URL = scannedResult;
            [self.navigationController pushViewController:jumpVC animated:NO];
            
            self.first_push = NO;
        }
    }
}

#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    [SGQRCodeTool SG_scanningQRCodeOutsideVC:self session:_session previewLayer:_previewLayer];
}

#pragma mark - - - 二维码扫描代理方法
// 调用代理方法，会频繁的扫描
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // 0、扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];

    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2、删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        /**
         *  获取扫描结果
         */
        stringValue = metadataObject.stringValue;
    }
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"扫描结果：%@", stringValue] preferredStyle:UIAlertControllerStyleAlert];
    //    [alert addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //        [_session startRunning];
    //    }]];
    //    [self presentViewController:alert animated:true completion:nil];
    
    NSLog(@"%@",stringValue);
    
    
    biaoganViewController * web=[[biaoganViewController alloc]init];
    if ([stringValue containsString:@"WeChat/qrscc.wc?uuid="]) {
        
        web.webUrl=[NSString stringWithFormat:@"%@&sceneApp=bagApp&userID=%@",stringValue,[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
        //         web.Title=@"登录PC端的确认";
        
        
        
        [self.navigationController pushViewController:web animated:NO];
    }else if([stringValue containsString:@"jsp?"]){
        
        NSRange  rang=[stringValue rangeOfString:@"{"];
        
        NSString * string=[stringValue substringFromIndex:rang.location];
        NSLog(@"%@",string);
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonData);
        NSError *err;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                             
                                                            options:NSJSONReadingMutableContainers
                             
                                                              error:&err];
        
        if (err) {
            NSLog(@"%@",err);
        }
        
        if (dic) {
            
            
            
            _flag=[NSString stringWithFormat:@"%@",dic[@"flag"]];
        }else{
            
            NSRange Rang=[string rangeOfString:@"flag:"];
            _flag=[string substringWithRange:NSMakeRange(Rang.length+1, 1)];
            
        }
        NSLog(@"%@",_flag);
        if ([_flag isEqualToString:@"1"]) {
            
            
        }
        if ([_flag isEqualToString:@"2"]) {
            
            
            NSArray * arr=[string componentsSeparatedByString:@","];
            
            NSString * s=arr[1];
            
            
            NSString * userID=[s substringFromIndex:8];
            
            NSArray * arr1=[userID componentsSeparatedByString:@"}"];
            
            web.webUrl=[NSString stringWithFormat:@"%@/WeChat/toAddCircle.wc?token=%@&scene=bag_a&circleID=%@&companyId=%@&userId=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],[NSString stringWithFormat:@"%@",arr1[0]],[[NSUserDefaults standardUserDefaults] objectForKey:@"companyID"],[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
            
            
            //            web.Title=@"虚拟班组";
            [self.navigationController pushViewController:web animated:NO];
        }
        if ([_flag isEqualToString:@"3"]) {
            
            DynamicViewController * dy=[[DynamicViewController alloc]init];
            
            NSArray * arr=[string componentsSeparatedByString:@":"];
            
            NSString * s=arr[2];
            
            
            NSString * userID=[s substringToIndex:s.length-1];
            NSLog(@"%@",userID);
            
            dy.userID=userID;
            [self.navigationController pushViewController:dy animated:NO];
            
            
            
        }
        
    }else{
        
        biaoganViewController * web=[[biaoganViewController alloc]init];
        
        //        MoreViewController * web=[[MoreViewController alloc]init];
        
        web.webUrl=stringValue;
        
        [self.navigationController pushViewController:web animated:NO];
        
        
    }
}

#pragma mark - - - 扫描提示声
/** 播放音效文件 */
- (void)playSoundEffect:(NSString *)name{
    // 获取音效
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;

    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    NSLog(@"播放完成...");
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;

}
#pragma mark - - - 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
  
    //    NSLog(@" - - -- viewDidAppear");
}



@end

/*
 
 二维码扫描的步骤：
     1、创建设备会话对象，用来设置设备数据输入
     2、获取摄像头，并且将摄像头对象加入当前会话中
     3、实时获取摄像头原始数据显示在屏幕上
     4、扫描到二维码/条形码数据，通过协议方法回调
 
 AVCaptureSession 会话对象。此类作为硬件设备输入输出信息的桥梁，承担实时获取设备数据的责任
 AVCaptureDeviceInput 设备输入类。这个类用来表示输入数据的硬件设备，配置抽象设备的port
 AVCaptureMetadataOutput 输出类。这个支持二维码、条形码等图像数据的识别
 AVCaptureVideoPreviewLayer 图层类。用来快速呈现摄像头获取的原始数据
 二维码扫描功能的实现步骤是创建好会话对象，用来获取从硬件设备输入的数据，并实时显示在界面上。在扫描到相应图像数据的时候，通过AVCaptureVideoPreviewLayer类型进行返回
 
 */

