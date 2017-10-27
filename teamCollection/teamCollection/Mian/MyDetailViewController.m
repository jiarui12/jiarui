//
//  MyDetailViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MyDetailViewController.h"

@interface MyDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL * url=[NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate=self;
    [self.view addSubview:_webView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
