//
//  ActivateViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "PrefixHeader.pch"
#import "LoginViewController.h"
#import "ActivateViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SaoViewController.h"
#import "AFNetworking.h"
#import "MainViewController.h"
#import "ScanningViewController.h"
#import <CommonCrypto/CommonDigest.h>
@interface ActivateViewController ()<UIWebViewDelegate,TestJSObjectProtocol,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,NJKWebViewProgressDelegate>
@property(nonatomic,strong)UIImage * image;
@property(nonatomic,strong)NSString * ret;
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UIActionSheet * sheet;
@end

@implementation ActivateViewController
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    
    
    
    
    NSString * string=[NSString stringWithFormat:@"%@/WeChat/qrtoc.wc?scene=bag_c",URLDOMAIN];
    NSURL * url=[NSURL URLWithString:string];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    _progressProxy=[[NJKWebViewProgress alloc]init];
    _webView.delegate=_progressProxy;
    
    _progressProxy.webViewProxyDelegate=self;
    _progressProxy.progressDelegate=self;
    
    
    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0,
                                 navBounds.size.height - 2,
                                 navBounds.size.width,
                                 2);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [_progressView setProgress:0];
    [self.navigationController.navigationBar addSubview:_progressView];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    NSLog(@"%@",self);
    
    
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
   -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
              /*获取js对象*/
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    context[@"wvjs_interface"]=self;

}
             /*实现js方法跳转到登录界面*/
-(void)tologin
{
  
   [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)signin:(NSString * )phoneNum :(NSString *)passwd{
    NSLog(@"%@",passwd);
    
    
    NSString * passWord=[self getMd5_32Bit:passwd];
    NSDictionary * parameter=@{@"account":phoneNum,@"password":passWord,@"imie":[[UIDevice currentDevice].identifierForVendor UUIDString]};
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/login.mob",URLDOMAIN];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        
       
        NSString * token1=dic[@"token"];
        
        
            MainViewController * main=[[MainViewController alloc]init];
            //            main.token=token1;
        
      
            NSUserDefaults *UserInfo = [NSUserDefaults standardUserDefaults];
            [UserInfo setObject:token1 forKey:@"token"];
            [UserInfo setObject:dic[@"companyID"] forKey:@"companyID"];
            [UserInfo setObject:dic[@"companyNO"] forKey:@"companyNO"];
            [UserInfo setObject:dic[@"openfireDomain"] forKey:@"openfireDomain"];
            [UserInfo setObject:dic[@"openfireIP"] forKey:@"openfireIP"];
            [UserInfo setObject:dic[@"openfirePort"] forKey:@"openfirePort"];
            [UserInfo setObject:dic[@"phoneNum"] forKey:@"phoneNum"];
            [UserInfo setObject:dic[@"userID"] forKey:@"userID"];
            [UserInfo setObject:dic[@"userNO"] forKey:@"userNO"];
        
        
        
        
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/AddIosDeviceToken.mob?deviceToken=%@&userID=%@&token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
        
        
        [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

        
       
            [self.navigationController pushViewController:main animated:YES];
            
            
            
            
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
       
       
    }];
    
   

}
- (NSString *)getMd5_32Bit:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)input.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}


            /*实现js方法跳到扫一扫界面*/
-(void)startActivity4Scan
{
   ScanningViewController  * sao=[[ScanningViewController alloc]init];
    [self.navigationController pushViewController:sao animated:YES];
}
             /*独立上传头像方法*/
-(void)chooseimg4wv
{
    UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 2){
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
   
    imagePicker.delegate =self;
    
    // 设置允许编辑
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) {//照相
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{//相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // 显示图片选择器
    [self presentViewController:imagePicker animated:YES completion:nil];
    


}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    // 获取图片 设置图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    self.image = image;
    
    // 隐藏当前模态窗口
    [self dismissViewControllerAnimated:YES completion:^{
       
        AFHTTPSessionManager * session=[AFHTTPSessionManager manager];
        session.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/BagServer/uploadimgalone.mup",URLDOMAIN];
        
        [session POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data=UIImagePNGRepresentation(self.image);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"imgfile" fileName:fileName mimeType:@"text/html"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic=(NSDictionary *)responseObject;
            NSString * str=dic[@"imgurl"];
            NSString * str1=dic[@"resid"];
            NSString * string=[NSString stringWithFormat:@"javascript:actBean.img_choose_app_post('{imgurl : \"%@\",resid : \"%@\",ret : 0}')",str,str1];
            [self.webView stringByEvaluatingJavaScriptFromString:string];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
        }];
        
    }];
    
    
    
}
@end
