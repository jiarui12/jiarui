//
//  NewOneImageTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "NewOneImageTableViewCell.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation NewOneImageTableViewCell

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
    static NSString *identifier = @"one1";
    // 1.缓存中取
    NewOneImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewOneImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*12/375,14*WIDTH/375 ,WIDTH*109.3/375, 82*WIDTH/375)];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _headImage.layer.borderWidth=0.5;
        _headImage.layer.borderColor=borderColorRef;
        [self.headImage setContentMode:UIViewContentModeScaleAspectFill];
        _headImage.layer.cornerRadius=4*WIDTH/375;

        self.headImage.clipsToBounds = YES;
        _headImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImage];
        UIImageView * play=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH* 40/375, 25,WIDTH *30/375, WIDTH *30/375)];
        
        play.image=[UIImage imageNamed:@"icon_play_defult_2x"];
//        play.center=_headImage.center;
        [self.headImage addSubview:play];
        
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *149/375, 10, WIDTH * 210/375, 30)];
        
        _titleLabel.font=[UIFont systemFontOfSize:WIDTH *16/375];
        
        [self.contentView addSubview:_titleLabel];
        
        
        
      
        
        
        
        
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 133.3/375, 80*WIDTH/375,WIDTH * 35/375, 17)];
        
        
        
        
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        
        
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
        
        _commentImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *295/375, WIDTH * 80/375,WIDTH *15/375,  WIDTH *15/375)];
        _commentImage.image=[UIImage imageNamed:@"icon_-comment_defult@2x"];
        
        [self.contentView addSubview:_commentImage];
        _flowerImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH *330/375, WIDTH * 80/375,WIDTH *15/375, WIDTH *15/375)];
        
        
        _flowerImage.image=[UIImage imageNamed:@"icon_like_defult@2x"];
        [self.contentView addSubview:_flowerImage];
        
        
        _commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 314/375, WIDTH * 83/375, 25, 10)];
        [self.contentView addSubview:_commentLabel];
        
        _commentLabel.font=[UIFont systemFontOfSize:12];
        
        _flowerLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 342.5/375, WIDTH * 83/375, 25,10)];
        _flowerLabel.font=[UIFont systemFontOfSize:12];
        
        _flowerLabel.textAlignment=NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:_flowerLabel];
        
        _flowerLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        _commentLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        _titleLabel.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        
        if ([UIScreen mainScreen].bounds.size.width<350) {
            
            
            _commentLabel.font=[UIFont systemFontOfSize:10];
            
            _flowerLabel.font=[UIFont systemFontOfSize:10];
            
            _videoTimeLabel.font=[UIFont systemFontOfSize:12];
            
            _categaryLabel.font=[UIFont systemFontOfSize:12];
            
            _AuthenticateLabel.font=[UIFont systemFontOfSize:14];
            
            
            _titleLabel.font=[UIFont systemFontOfSize:16];
        }
        
        
        
    }
    return self;
    
    
}

@end
