//
//  newCepingTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/26.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "newCepingTableViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation newCepingTableViewCell

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
    static NSString *identifier = @"ceping";
    // 1.缓存中取
    newCepingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newCepingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(12*WIDTH/375, 0*WIDTH/375,WIDTH-24*WIDTH/375 , 58*WIDTH/375)];
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH/375, 58*WIDTH/375, WIDTH-24*WIDTH/375 , 60*WIDTH/375)];
        
        [self.contentView addSubview:_timeLabel];
        
        _jiezhiLabel=[[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH/375, 118*WIDTH/375, WIDTH-24*WIDTH/375 , 60*WIDTH/375)];
    
        [self.contentView addSubview:_jiezhiLabel];
        
        _zongfenLabel=[[UILabel alloc]initWithFrame:CGRectMake(36*WIDTH/375, 178*WIDTH/375, WIDTH-24*WIDTH/375 , 60*WIDTH/375)];
        
        
        [self.contentView addSubview:_zongfenLabel];
        
        _jinruBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        _jinruBtn.frame=CGRectMake(263*WIDTH/375, 254*WIDTH/375, 100*WIDTH/375, 30*WIDTH/375);
        
        [_jinruBtn setTitle:@"进入" forState:UIControlStateNormal];
        
        _jinruBtn.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
        
        [_jinruBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 220/255.0, 220/255.0, 220/255.0, 1 });
        
        _jinruBtn.layer.borderWidth=0.5;
        
        _jinruBtn.layer.borderColor=borderColorRef;
        
        _jinruBtn.layer.cornerRadius=15*WIDTH/375;
        
        [self.contentView addSubview:_jinruBtn];
        
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 58*WIDTH/375,WIDTH-24*WIDTH/375, 1)];
        view.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
        [self.contentView addSubview:view];
        UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 118*WIDTH/375,WIDTH-24*WIDTH/375, 1)];
        view1.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [self.contentView addSubview:view1];
        UIView * view2=[[UIView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 178*WIDTH/375,WIDTH-24*WIDTH/375, 1)];
        view2.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [self.contentView addSubview:view2];
        UIView * view3=[[UIView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 238*WIDTH/375,WIDTH-24*WIDTH/375, 1)];
        view3.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [self.contentView addSubview:view3];
        UIView * view4=[[UIView alloc]initWithFrame:CGRectMake(0, 298*WIDTH/375, WIDTH, 12*WIDTH/375)];
        
        view4.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        
        [self.contentView addSubview:view4];
        
        
        
        _timeLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _jiezhiLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _zongfenLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _timeLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
        _jiezhiLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
        _zongfenLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
        
        
        
        UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 80*WIDTH/375, 16*WIDTH/375, 16*WIDTH/375)];
        image.image=[UIImage imageNamed:@"cepingbiaozhun"];
        [self.contentView addSubview:image];
        
        UIImageView * image1=[[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 140*WIDTH/375, 16*WIDTH/375, 16*WIDTH/375)];
        image1.image=[UIImage imageNamed:@"jiezhishijian"];
        [self.contentView addSubview:image1];
        
        UIImageView * image2=[[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 200*WIDTH/375, 16*WIDTH/375, 16*WIDTH/375)];
        image2.image=[UIImage imageNamed:@"zongfen"];
        [self.contentView addSubview:image2];
        
        
        
        
    }
    return self;
    
    
}

@end
