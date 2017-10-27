//
//  SaoErWeiViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/1/11.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SaoErWeiViewController.h"

@interface SaoErWeiViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation SaoErWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL * url=[NSURL URLWithString:self.url];
    NSURLRequest * requset=[NSURLRequest requestWithURL:url];
    self.webView.delegate=self;
    [self.webView loadRequest:requset];
    [self.view addSubview:self.webView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
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
