//
//  ManagerViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/26.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "ManagerViewController.h"
#import <WebKit/WebKit.h>
@interface ManagerViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)WKWebView * WebView1;
@property(nonatomic,strong)UIProgressView * progressView;
@end

@implementation ManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    NSURL * url=[NSURL URLWithString:self.url];
    _webView.delegate=self;
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.navigationItem.title=@"频道管理";
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, 10, 20);
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.view addSubview:self.webView];
    
    
}

-(void)Back:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadView" object:nil];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    NSLog(@"完成");

}
-(void)viewWillAppear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden=YES;
//    
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    image.hidden=YES;
    
    

}
@end
