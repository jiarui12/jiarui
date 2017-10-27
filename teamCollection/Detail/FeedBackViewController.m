//
//  FeedBackViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/4/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "FeedBackViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
@interface FeedBackViewController ()
@property(nonatomic,strong)UITextView * textView;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"意见反馈";
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 120)];
    _textView.font=[UIFont fontWithName:@"Arial" size:18.0];
    _textView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_textView];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(self.view.frame.size.width-60, 204, 50, 30);
    button.backgroundColor=[UIColor colorWithRed:11/255.0 green:127/255.0 blue:255/255.0 alpha:1.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendAdvice) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    _textView.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:button];
    
    
}
-(void)sendAdvice{
    NSString * url=[NSString stringWithFormat:@"%@/BagServer/addSuggestion.mob",URLDOMAIN];
    NSDictionary * para=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"suggestion":_textView.text};
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    

}

@end
