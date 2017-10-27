//
//  TwoImageTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/7/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "TwoImageTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation TwoImageTableViewCell

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
    static NSString *identifier = @"two";
    // 1.缓存中取
    TwoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[TwoImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /*@property(nonatomic,strong)UILabel * titleLabel;
         @property(nonatomic,strong)UIImageView * OneImage;
         @property(nonatomic,strong)UIImageView * TwoImage;
         
         
         
         
         
         
         @property(nonatomic,strong)UILabel * categaryLabel;
         @property(nonatomic,strong)UIImageView * commentImage;
         @property(nonatomic,strong)UIImageView * flowerImage;
         @property(nonatomic,strong)UILabel * commentLabel;
         @property(nonatomic,strong)UILabel * flowerLabel;*/
        
        
        _OneImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 10/375, 40, WIDTH * 175/375, 116)];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _OneImage.layer.borderWidth=0.5;
        _OneImage.layer.borderColor=borderColorRef;
        
        [self.contentView addSubview:_OneImage];
        
        _TwoImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 190/375, 40, WIDTH * 175/375, 116)];
       
        _TwoImage.layer.borderWidth=0.5;
        _TwoImage.layer.borderColor=borderColorRef;
        [self.contentView addSubview:_TwoImage];
        
        
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 10/375, 10, 300, 30)];
//        _titleLabel.backgroundColor=[UIColor redColor];
        
        
        
        
        
        _titleLabel.font=[UIFont systemFontOfSize:18];
        [self.contentView addSubview:_titleLabel];
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 10/375, 170, 35, 20)];
        
        
        
        
        
        
        
        
        
        CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef1 = CGColorCreate(colorSpace1,(CGFloat[]){ 44/255.0, 140/255.0, 251/255.0, 1 });
        
        _categaryLabel.layer.borderColor=borderColorRef1;
        _categaryLabel.layer.cornerRadius=5;
        
        _categaryLabel.textAlignment=NSTextAlignmentCenter;
        _categaryLabel.layer.borderWidth=0.5;
        _categaryLabel.textColor=[UIColor colorWithRed:44/255.0 green:140/255.0 blue:251/255.0 alpha:1.0];
        
        
        
        _categaryLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_categaryLabel];
        
        _commentImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 275/375, 170, 15, 15)];
        
        
        [self.contentView addSubview:_commentImage];
        _flowerImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 315/375, 170, 15, 15)];
        
       
        
        
        _commentImage.image=[UIImage imageNamed:@"icon_-comment_defult@2x"];
        
        
        _flowerImage.image=[UIImage imageNamed:@"icon_like_defult@2x"];

        [self.contentView addSubview:_flowerImage];
        
        
        _commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 294/375, 175-2, 25, 10)];
        [self.contentView addSubview:_commentLabel];
        _commentLabel.font=[UIFont systemFontOfSize:12];
        
        _flowerLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 333/375, 175-2, 25, 10)];
        _flowerLabel.font=[UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_flowerLabel];
        
        _flowerLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        _commentLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        
        
          _titleLabel.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        
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
