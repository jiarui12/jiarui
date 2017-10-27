//
//  uploadTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "uploadTableViewCell.h"
#import "MCDownloadManager.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation uploadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"upload";
    // 1.缓存中取
    uploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[uploadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*10/375, 15,WIDTH*130/375, 97.5)];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _headImage.layer.borderWidth=0.5;
        
        
        _headImage.layer.masksToBounds=YES;
        _headImage.layer.borderColor=borderColorRef;
        _headImage.layer.cornerRadius=4*WIDTH/375;
        [self.contentView addSubview:_headImage];
        UIImageView * play=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH* 50/375, 34,WIDTH *30/375, WIDTH *30/375)];
        
        play.image=[UIImage imageNamed:@"icon_play_defult_2x"];
        
        [self.headImage addSubview:play];
        
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *149/375, 10, WIDTH * 210/375, 50)];
        _titleLabel.numberOfLines=2;
        _titleLabel.font=[UIFont systemFontOfSize:WIDTH *16/375];
        
        [self.contentView addSubview:_titleLabel];
        _videoImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *149/375, 55,WIDTH *15/375, WIDTH *15/375)];
        _videoImage.image=[UIImage imageNamed:@"icon_play_defult@2x"];
      
        
        _uploadStatus=[[UILabel  alloc]initWithFrame:CGRectMake(WIDTH *149/375, 60, WIDTH * 210/375, 20)];
        
        _uploadStatus.textColor=[UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
        _uploadStatus.font=[UIFont systemFontOfSize:WIDTH* 14/375];
        _uploadStatus.textAlignment=NSTextAlignmentRight;
        
        [self.contentView addSubview:_uploadStatus];
        
        _progress=[[UIProgressView alloc]initWithFrame:CGRectMake(WIDTH *149/375, 80, WIDTH * 210/375, 5)];
        
        _progress.trackTintColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0];
        //设置进度颜色
        _progress.progressTintColor = [UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
        _progress.progress=0;
        [self.contentView addSubview:_progress];
        
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 149/375, _titleLabel.frame.size.height+_titleLabel.frame.origin.y+5, _titleLabel.frame.size.width,35)];
        _DetailLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        _DetailLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        _DetailLabel.numberOfLines=2;
        
        [self.contentView addSubview:_DetailLabel];
        
        _nodeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 187/375, 87*WIDTH/375,WIDTH * 80/375, 20)];
        _nodeLabel.textAlignment=NSTextAlignmentLeft;
        _nodeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];
        _nodeLabel.font=[UIFont systemFontOfSize:WIDTH *12/375];
        [self.contentView addSubview:_nodeLabel];
        _percentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 149/375, 96.5, WIDTH * 210/375, 20)];
        
        _percentLabel.textColor=[UIColor colorWithRed:124/255.0 green:194/255.0 blue:236/255.0 alpha:1.0];
        
        
        _percentLabel.font=[UIFont systemFontOfSize:WIDTH* 14/375];
        _percentLabel.textAlignment=NSTextAlignmentRight;
        
        [self.contentView addSubview:_percentLabel];
        
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 150/375, 88 *WIDTH/375,WIDTH * 35/375, 17)];
        
        
        
        
        CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef1 = CGColorCreate(colorSpace1,(CGFloat[]){ 41/255.0, 180/255.0, 237/255.0, 1 });
        
        _categaryLabel.layer.borderColor=borderColorRef1;
        _categaryLabel.layer.cornerRadius=5;
        
        _categaryLabel.textAlignment=NSTextAlignmentCenter;
        _categaryLabel.layer.borderWidth=0.5;
        _categaryLabel.textColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
        //        _categaryLabel.hidden=YES;
        
        _categaryLabel.font=[UIFont systemFontOfSize:WIDTH* 11/375];
        
        [self.contentView addSubview:_categaryLabel];
        
        
       
        _titleLabel.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        
        if ([UIScreen mainScreen].bounds.size.width<350) {
            
            
           
            
            _categaryLabel.font=[UIFont systemFontOfSize:12];
            
           
            
            
            _titleLabel.font=[UIFont systemFontOfSize:16];
        }
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(WIDTH*10/375, 15,WIDTH*130/375, 97.5);
        
        [button addTarget:self action:@selector(statusBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        
        
    }
    return self;
    
    
}
-(void)statusBtn:(UIButton *)button{
    MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:self.url];
    
    if (receipt.state == MCDownloadStateDownloading) {
//        [self.button setTitle:@"下载" forState:UIControlStateNormal];
        _uploadStatus.text=@"已暂停";
        [[MCDownloadManager defaultInstance] suspendWithDownloadReceipt:receipt];
    }else if (receipt.state == MCDownloadStateCompleted) {
        
        if ([self.delegate respondsToSelector:@selector(cell:didClickedBtn:)]) {
            [self.delegate cell:self didClickedBtn:button];
        }
    }else {
//        [self.button setTitle:@"停止" forState:UIControlStateNormal];
        
        _uploadStatus.text=@"下载中";
        [self download];
    }
    

}
- (void)setUrl:(NSString *)url {
    _url = url;
    
    MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:url];
    
   
//    self.speedLable.text = nil;
//    self.bytesLable.text = nil;
    self.progress.progress = 0;
 
    self.progress.progress = receipt.progress.fractionCompleted;
    
    self.percentLabel.text=[NSString stringWithFormat:@"%.0f%%",ceilf(receipt.progress.fractionCompleted*100)];
    
    
    if (receipt.state == MCDownloadStateDownloading) {
        
        _uploadStatus.text=@"下载中";
        [self download];
//        [self.button setTitle:@"停止" forState:UIControlStateNormal];
    }else if (receipt.state == MCDownloadStateCompleted) {
//        [self.button setTitle:@"播放" forState:UIControlStateNormal];
        self.percentLabel.hidden=YES;
        self.progress.hidden=YES;
        self.uploadStatus.hidden=YES;
//        self.bytesLable.hidden=YES;
//        self.speedLable.hidden=YES;
        
    }else {
        _uploadStatus.text=@"暂停";
//        [self.button setTitle:@"下载" forState:UIControlStateNormal];
    }
    
    receipt.progressBlock = ^(NSProgress * _Nonnull downloadProgress,MCDownloadReceipt *receipt) {
        if ([receipt.url isEqualToString:self.url]) {
            self.progress.progress = downloadProgress.fractionCompleted ;
            
            
            self.percentLabel.text=[NSString stringWithFormat:@"%.0f%%",ceilf(downloadProgress.fractionCompleted*100)];
            
            
            
            
            
//            self.bytesLable.text = [NSString stringWithFormat:@"%0.2fm/%0.2fm", downloadProgress.completedUnitCount/1024.0/1024, downloadProgress.totalUnitCount/1024.0/1024];
//            self.speedLable.text = [NSString stringWithFormat:@"%@/s", receipt.speed];
        }
    };
    
    receipt.successBlock = ^(NSURLRequest * _Nullablerequest, NSHTTPURLResponse * _Nullableresponse, NSURL * _NonnullfilePath) {
        
        
        
//        [self.button setTitle:@"播放" forState:UIControlStateNormal];
        self.progress.hidden=YES;
//        self.bytesLable.hidden=YES;
//        self.speedLable.hidden=YES;
        
        
        self.percentLabel.hidden=YES;
        self.uploadStatus.hidden=YES;
        
        
        [self.delegate refreshData];
        
        
        
        NSLog(@"完成");
        
       
       
//        UILocalNotification *localNote = [[UILocalNotification alloc] init];
//        
//        // 2.设置本地通知的内容
//        // 2.1.设置通知发出的时间
//        localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
//        // 2.2.设置通知的内容
//        localNote.alertBody = @"";
//        // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
//        localNote.alertAction = @"解锁";
//        // 2.4.决定alertAction是否生效
//        localNote.hasAction = NO;
//        // 2.5.设置点击通知的启动图片
//        localNote.alertLaunchImage = @"123Abc";
//        // 2.6.设置alertTitle
//        localNote.alertTitle = @"你有一条新通知";
//        // 2.7.设置有通知时的音效
//        localNote.soundName = @"buyao.wav";
//        // 2.8.设置应用程序图标右上角的数字
//        localNote.applicationIconBadgeNumber = 999;
//        
//        // 2.9.设置额外信息
//        localNote.userInfo = @{@"type" : @1};
//        
//        // 3.调用通知
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
        
        
    };
    
    receipt.failureBlock = ^(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response,  NSError * _Nonnull error) {
//        [self.button setTitle:@"下载" forState:UIControlStateNormal];
    };
    
}
- (void)download {
    [[MCDownloadManager defaultInstance] downloadFileWithURL:self.url
                                                    progress:^(NSProgress * _Nonnull downloadProgress, MCDownloadReceipt *receipt) {
                                                        
                                                        if ([receipt.url isEqualToString:self.url]) {
                                                            self.progress.progress = downloadProgress.fractionCompleted ;
                                                             self.percentLabel.text=[NSString stringWithFormat:@"%.0f%%",ceilf(downloadProgress.fractionCompleted*100)];
//                                                            self.bytesLable.text = [NSString stringWithFormat:@"%0.2fm/%0.2fm", downloadProgress.completedUnitCount/1024.0/1024, downloadProgress.totalUnitCount/1024.0/1024];
//                                                            self.speedLable.text = [NSString stringWithFormat:@"%@/s", receipt.speed];
                                                        }
                                                        
                                                    }
                                                 destination:nil
                                                     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSURL * _Nonnull filePath) {
//                                                         [self.button setTitle:@"播放" forState:UIControlStateNormal];
                                                         self.percentLabel.hidden=YES;
                                                         self.progress.hidden=YES;
                                                         self.uploadStatus.hidden=YES;
                                                         
                                                        
                                                             [self.delegate refreshData];
                                                        
//                                                         self.bytesLable.hidden=YES;
//                                                         self.speedLable.hidden=YES;
                                                     }
                                                     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//                                                         [self.button setTitle:@"下载" forState:UIControlStateNormal];
                                                     }];
    
}
@end
