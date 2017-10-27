//
//  RightImageTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/7/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "RightImageTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation RightImageTableViewCell

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
    static NSString *identifier = @"right";
    // 1.缓存中取
    RightImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[RightImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        
        
        _ThreeImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 235/375, 15, WIDTH * 130/375, 195/2)];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _ThreeImage.layer.borderWidth=0.5;
        _ThreeImage.layer.borderColor=borderColorRef;

        [self.contentView addSubview:_ThreeImage];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake( WIDTH * 10/375, 15, WIDTH * 213/375,40)];
//        _titleLabel.numberOfLines=2;
        _titleLabel.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:_titleLabel];
        
        
        
       
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 10/375, 97, 35, 17)];
        
        _nodeLabel=[[UILabel alloc]initWithFrame:CGRectMake(_categaryLabel.frame.size.width+_categaryLabel.frame.origin.x+3,95.5,WIDTH * 80/375, 20)];
        _nodeLabel.textAlignment=NSTextAlignmentLeft;
        _nodeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:175/255.0];
        _nodeLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nodeLabel];
        CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef1 = CGColorCreate(colorSpace1,(CGFloat[]){ 44/255.0, 140/255.0, 251/255.0, 1 });
        
        _categaryLabel.layer.borderColor=borderColorRef1;
        _categaryLabel.layer.cornerRadius=5;
        _categaryLabel.layer.borderWidth=0.5;
        _categaryLabel.textAlignment=NSTextAlignmentCenter;
        
        _categaryLabel.textColor=[UIColor colorWithRed:44/255.0 green:140/255.0 blue:251/255.0 alpha:1.0];
        
        
        _categaryLabel.font=[UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_categaryLabel];
        
        _commentImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 146/375, 97.5, 15, 15)];
        
        
        [self.contentView addSubview:_commentImage];
        _flowerImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 195/375, 97.5, 15, 15)];
        
        
        _commentImage.image=[UIImage imageNamed:@"icon_-comment_defult@2x"];
        
        
        _flowerImage.image=[UIImage imageNamed:@"icon_like_defult@2x"];

        [self.contentView addSubview:_flowerImage];
        
        
        _commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 165/375, 100.5, 25,10)];
        [self.contentView addSubview:_commentLabel];
        _commentLabel.font=[UIFont systemFontOfSize:12];
        
        _flowerLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 213/375, 100.5, 25, 10)];
        _flowerLabel.font=[UIFont systemFontOfSize:12];
      
        [self.contentView addSubview:_flowerLabel];
        
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 10/375, _titleLabel.frame.size.height+_titleLabel.frame.origin.y+5, _titleLabel.frame.size.width, 35)];
        _DetailLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        _DetailLabel.font=[UIFont systemFontOfSize:14];
        _DetailLabel.numberOfLines=2;
        [self.contentView addSubview:_DetailLabel];
        
        
        
        _flowerLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        _commentLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
          _titleLabel.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        
        
        
        
        
        if ([UIScreen mainScreen].bounds.size.width<350) {
            _commentLabel.font=[UIFont systemFontOfSize:10];
            
            _flowerLabel.font=[UIFont systemFontOfSize:10];
            
            
            _titleLabel.font=[UIFont systemFontOfSize:16];
            
            _AuthenticateLabel.font=[UIFont systemFontOfSize:14];
            _categaryLabel.font=[UIFont systemFontOfSize:12];
            
            
        }
        
        
        
        
    }
    return self;
    
    
}

@end
