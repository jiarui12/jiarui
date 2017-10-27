//
//  changepasswordViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "changepasswordViewController.h"
#import "MBProgressHUD+HM.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"
#import <CommonCrypto/CommonDigest.h>
#import "HistoryLoginViewController.h"
#import "WKProgressHUD.h"
@interface changepasswordViewController ()
@property(nonatomic,strong)UITextField * field;
@property(nonatomic,strong)UITextField * field2;
@property(nonatomic,strong)UITextField * field3;
@end

@implementation changepasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"设置新密码";
    int y=180;
    _field=[[UITextField alloc]init];
    _field.frame=CGRectMake(110, y-2.5, 300, 20);
    _field.backgroundColor=[UIColor whiteColor];
    _field.placeholder=@"请输入6-12位数字或字母";
    
    
    [self.view addSubview:_field];
    
    
    _field2=[[UITextField alloc]init];
    _field2.frame=CGRectMake(110, y+47.5, 300, 20);
    _field2.backgroundColor=[UIColor whiteColor];
    _field2.placeholder=@"请再次确认您的密码";
    
    
    [self.view addSubview:_field2];
    
    
    _field3=[[UITextField alloc]init];
    _field3.frame=CGRectMake(110, y-52.5, 300, 20);
    _field3.backgroundColor=[UIColor whiteColor];
    _field3.placeholder=@"请输入旧密码";
    
   
    [self.view addSubview:_field3];
    _field.secureTextEntry = YES;
    _field2.secureTextEntry=YES;
    _field3.secureTextEntry=YES;
    UIImageView*bacImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, y-15, self.view.frame.size.width-40, 42)];
    UIImage *image1 = [UIImage imageNamed:@"text_background_xi"];
    UIImage *image2 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    bacImage.image=image2;
    [self.view addSubview:bacImage];
    UIImageView*bacImage1=[[UIImageView alloc]initWithFrame:CGRectMake(20, y+35,self.view.frame.size.width-40 , 42)];
    bacImage1.image=image2;
    [self.view addSubview:bacImage1];
    
    UIImageView*bacImage2=[[UIImageView alloc]initWithFrame:CGRectMake(20, y-65,self.view.frame.size.width-40 , 42)];
    bacImage2.image=image2;
   
    [self.view addSubview:bacImage2];
    
    
    
    UIButton * button3=[UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame=CGRectMake(20, y+100, self.view.frame.size.width-40, 40);
    [button3 setTitle:@"确定" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button3.backgroundColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [button3 addTarget:self action:@selector(ActivateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UILabel* YanLabel=[[UILabel alloc]initWithFrame:CGRectMake(30,y-2, 60, 20)];
    YanLabel.text=@"新密码";
    YanLabel.font=[UIFont systemFontOfSize:15];
    YanLabel.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:YanLabel];
    UILabel* YanLabel1=[[UILabel alloc]initWithFrame:CGRectMake(30,y+48, 80, 20)];
    YanLabel1.text=@"确认新密码";
    YanLabel1.font=[UIFont systemFontOfSize:15];
    YanLabel1.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:YanLabel1];
    
    UILabel * oldLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, y-52, 80, 20)];
    oldLabel.text=@"旧密码";
    oldLabel.font=[UIFont systemFontOfSize:15];
    oldLabel.textColor=[UIColor colorWithRed:60/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    [self.view addSubview:oldLabel];
}
-(void)Back:(UIBarButtonItem *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)ActivateClick:(UIButton *)button{
WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"" animated:YES];
    
    if (_field.text.length!=0&&_field2.text.length!=0) {
        
        if ([_field.text isEqualToString:_field2.text]) {
            NSString * token=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
            AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFJSONResponseSerializer serializer];
            manager.requestSerializer=[AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
            
            
            
            
            NSString * url=[NSString stringWithFormat:@"%@/BagServer/app/api/update_pwd.mob?token=%@&oldPassword=%@&newPassword=%@",URLDOMAIN,token,[self getMd5_32Bit:_field3.text],[self getMd5_32Bit:_field2.text]];
            NSLog(@"%@",url);
          
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [hud dismiss:YES];
                
                NSLog(@"%@",responseObject);
                NSString * ret=[NSString stringWithFormat:@"%@",responseObject[@"ret"]];
                if ([ret isEqualToString:@"1"]) {
                   
                    [MBProgressHUD showSuccess:@"修改成功"];
                    
                    
                    
                    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                    [user setObject:@"" forKey:@"token"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
                        //            [self.navigationController popToRootViewControllerAnimated:YES];
                        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
                        nav.navigationBar.barTintColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
                        [self presentViewController:nav animated:YES completion:^{
                            
                        }];
                    });
                    
                   
                    
                }
                if ([ret isEqualToString:@"2"]) {
                    [MBProgressHUD showError:@"原密码错误"];
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [hud dismiss:YES];
                NSLog(@"%@",error);
            }];
            _field.text=nil;
            _field2.text=nil;
            _field3.text=nil;
            
            
            
           
        }else{
            [hud dismiss:YES];
        
          [MBProgressHUD showError:@"两次输入密码不一致"];
        }
        
     
        
        
        
        
    }else{
        [MBProgressHUD showError:@"密码不能为空"];
    
    }
    
    
  
}

/**
                         _ooOoo_
                        o8888888o
                        88" . "88
                        (| -_- |)
                        O\  =  /O
                     ____/`---'\____
                   .'  \\|     |//  `.
                  /  \\|||  :  |||//  \
                 /  _||||| -:- |||||-  \
                 |   | \\\  -  /// |   |
                 | \_|  ''\---/''  |   |
                 \  .-\__  `-`  ___/-. /
               ___`. .'  /--.--\  `. . __
            ."" '<  `.___\_<|>_/___.'  >'"".
           | | :  `- \`.;`\ _ /`;.`/ - ` : | |
           \  \ `-.   \_ __\ /__ _/   .-` /  /
	  ======`-.____`-.___\_____/___.-`____.-'======
                         `=---='
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                     佛祖保佑       永无BUG
 
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
-(void)viewWillAppear:(BOOL)animated{


//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
    
//    image.hidden=YES;
    

}
@end
