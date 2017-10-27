//
//  MyErWeiMaViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/8/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MyErWeiMaViewController.h"
#import "UIImageView+WebCache.h"
@interface MyErWeiMaViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *headView;
@end
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@implementation MyErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"我的二维码";
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, HEIGHT*170/667, 200, 200)];
   
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = [NSString stringWithFormat:@"//http://bag.89mc.com/BagServer/jsp/wechat/wechat.jsp?{flag:3,userID:%@}",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.将CIImage转换成UIImage，并放大显示
    self.imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    [self.view addSubview:_imageView];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 20)];
    label.text=@"扫描上面的二维码,添加我为好友";
    
    label.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    _headView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*20/375, HEIGHT*90/667, WIDTH-WIDTH*151.5/375-WIDTH*151.5/375, WIDTH-WIDTH*151.5/375-WIDTH*151.5/375)];
    _headView.image=[UIImage imageNamed:@"班组汇图标"];
    _headView.layer.cornerRadius=_headView.frame.size.width/2;
    _headView.clipsToBounds=YES;
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSString * head=[user objectForKey:@"headImageViewURL"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    
    NSString *documentsPath =documentsDirectory;
    NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/1.png",documentsPath]];
    
    NSData * data1=[NSData dataWithContentsOfURL:url];
    if (data1) {
        _headView.image=[UIImage imageWithData:data1];
    }else{
        
        [_headView sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
    }
    
    [self.view addSubview:_headView];
    
    UILabel * nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*100/375, HEIGHT*100/667,WIDTH*100/375, WIDTH*20/375)];
    nameLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    nameLabel.text=self.name;
    [self.view addSubview:nameLabel];
    
    UILabel * phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*100/375, HEIGHT*140/667,WIDTH, WIDTH*20/375)];
    phoneLabel.text=[NSString stringWithFormat:@"账号  %@",_phone];
     phoneLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    [self.view addSubview:phoneLabel];
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
