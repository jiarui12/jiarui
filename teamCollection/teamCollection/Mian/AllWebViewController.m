//
//  AllWebViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "AllWebViewController.h"
#import "KnowledgeDetailViewController.h"

#import "PrefixHeader.pch"
#import "AFNetworking.h"
@interface AllWebViewController ()<UIWebViewDelegate,DetailController>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)NSString * Width;
@end

@implementation AllWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_title_back_normal"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];

    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    
    NSURL * url=[NSURL URLWithString:self.webUrl];
    self.webView.delegate=self;
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    AllWebViewController * all=[[AllWebViewController alloc]init];
    all.delegate=self;
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"js_interface"]=self;
    

}
-(void)Back:(UIBarButtonItem * )button{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)kpDetail:(int)ID{
    

    NSString * str2=[NSString stringWithFormat:@"%d",ID];

    KnowledgeDetailViewController * detail=[[KnowledgeDetailViewController alloc]init];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * str1=@"1080";
    NSString * str=[NSString stringWithFormat:@"%@/WeChat/kpDetailHtml5.wc?token=%@&kpID=%@&adapterSize=%@",URLDOMAIN,[user objectForKey:@"token"],str2,str1];
    detail.webUrl=str;
    detail.kpId=str2;
    [user setObject:str2 forKey:@"kpID"];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/kpDetail4New.mob",URLDOMAIN];
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    CGFloat width =[UIScreen mainScreen].applicationFrame.size.width;
    if (width<400) {
        _Width=@"720";
    }if (width>400) {
        _Width=@"1080";
    }
    NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":str2,@"adapterSize":_Width};
    
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        
        NSDictionary * Dic=dic[@"kpData"];
     
        NSString * categatr=Dic[@"category"];
        detail.fenlei=categatr;
        [self.navigationController pushViewController:detail animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
    
    
}
@end
