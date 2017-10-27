//
//  ActivateViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "PrefixHeader.pch"
#define POST_HEADIMAGE_URL @"http://bb.89mc.com:PORT/BagServer/BagServer/uploadimgalone.mup"

#import "LoginViewController.h"
#import "ActivateViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SaoViewController.h"
#import "AFNetworking.h"


@interface ActivateViewController ()<UIWebViewDelegate,TestJSObjectProtocol,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UIImage * image;
@property(nonatomic,strong)NSString * ret;
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation ActivateViewController
{


}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString * string=[NSString stringWithFormat:@"%@/WeChat/qrtoc.wc?scene=bag_c",URLDOMAIN];
    NSURL * url=[NSURL URLWithString:string];
    NSURLRequest  * request=[NSURLRequest requestWithURL:url];
    self.webView.delegate=self;
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
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
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    context[@"wvjs_interface"]=self;

}
-(void)tologin
{
  
   [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)startActivity4Scan
{
    SaoViewController * sao=[[SaoViewController alloc]init];
    [self.navigationController pushViewController:sao animated:YES];
}
-(void)chooseimg4wv
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"相册", nil];
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
        NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/BagServer/uploadimgalone.mup",URLDOMAIN];
        
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
