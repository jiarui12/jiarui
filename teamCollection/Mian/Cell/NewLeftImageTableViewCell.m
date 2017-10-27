//
//  NewLeftImageTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "NewLeftImageTableViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation NewLeftImageTableViewCell

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
    static NSString *identifier = @"left1";
    // 1.缓存中取
    NewLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewLeftImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 133.3/375, 14*WIDTH/375, WIDTH * 225/375, 23)];
        _titleLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];

        _titleLabel.numberOfLines=2;
        _titleLabel.font=[UIFont systemFontOfSize:WIDTH *16/375];
        [self.contentView addSubview:_titleLabel];
        _OneImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*12/375,14*WIDTH/375 ,WIDTH*109.3/375, 82*WIDTH/375)];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _OneImage.layer.borderWidth=0.5;
        _OneImage.layer.borderColor=borderColorRef;
        _OneImage.layer.cornerRadius=4*WIDTH/375;
        [self.OneImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:_OneImage];
        
        self.OneImage.clipsToBounds = YES;
        
     
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 133.3/375,80*WIDTH/375 ,WIDTH * 35/375,17)];
        
        
        
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
        
        _commentImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 295/375, 80*WIDTH/375,WIDTH *15/375, WIDTH *15/375)];
        
        
        [self.contentView addSubview:_commentImage];
        _flowerImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 330/375, 80*WIDTH/375, WIDTH *15/375, WIDTH *15/375)];
        
        
        _commentImage.image=[UIImage imageNamed:@"icon_-comment_defult@2x"];
        
        
        _flowerImage.image=[UIImage imageNamed:@"icon_like_defult@2x"];
        
        [self.contentView addSubview:_flowerImage];
        
        
        _commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 314/375, 83*WIDTH/375, 25, 10)];
        [self.contentView addSubview:_commentLabel];
        _commentLabel.font=[UIFont systemFontOfSize:WIDTH *12/375];
        _flowerLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 342.5/375, 83*WIDTH/375, 25, 10)];
        _flowerLabel.font=[UIFont systemFontOfSize:WIDTH *12/375];
        _flowerLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        _flowerLabel.textAlignment=NSTextAlignmentCenter;
        _commentLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        [self.contentView addSubview:_flowerLabel];
   
        
       
        
        
        if ([UIScreen mainScreen].bounds.size.width<350) {
            _commentLabel.font=[UIFont systemFontOfSize:10];
            
            _flowerLabel.font=[UIFont systemFontOfSize:10];
            
            
            _titleLabel.font=[UIFont systemFontOfSize:16];
            
            _categaryLabel.font=[UIFont systemFontOfSize:12];
            
            
        }
        
    }
    return self;
    
    
}


@end
