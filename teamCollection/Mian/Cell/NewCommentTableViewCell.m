//
//  NewCommentTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "NewCommentTableViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation NewCommentTableViewCell

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
    static NSString *identifier = @"comment";
    // 1.缓存中取
    NewCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 64/375, 14*WIDTH/375, WIDTH * 100/375, 14*WIDTH/375)];
        _nameLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        
        _nameLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        [self.contentView addSubview:_nameLabel];
        _OneImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*12/375,14*WIDTH/375 ,WIDTH*36/375, 36*WIDTH/375)];
        self.OneImage.layer.masksToBounds = YES;
        _OneImage.layer.cornerRadius=18*WIDTH/375;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _OneImage.layer.borderWidth=0.5;
        _OneImage.layer.borderColor=borderColorRef;
        [self.OneImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:_OneImage];
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 64/375, 60*WIDTH/375, WIDTH * 287/375, 10*WIDTH/375)];
        _DetailLabel.numberOfLines=2;
        _DetailLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
        _DetailLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        [self.contentView addSubview:_DetailLabel];
        
        
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 64/375, 35*WIDTH/375, WIDTH * 100/375, 12*WIDTH/375)];
        
        _timeLabel.font=[UIFont systemFontOfSize:12*WIDTH/375];
        
        _timeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        
        
        [self.contentView addSubview:_timeLabel];
        
        _starView = [[WQLStarView alloc]initWithFrame:CGRectMake(WIDTH*273/375,WIDTH* 12/375, WIDTH*80/375,WIDTH* 18/375) withTotalStar:5 withTotalPoint:10 starSpace:WIDTH*7/375];
        //            starView.backgroundColor=[UIColor redColor];
        _starView.starAliment = StarAlimentCenter;
        
        [self.contentView addSubview:_starView];
        
    }
    return self;
    
    
}


-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.DetailLabel.text = text;
    //设置label的最大行数
    self.DetailLabel.numberOfLines = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ;
    CGSize size = CGSizeMake(287*WIDTH/375, 1000);
    CGSize labelSize = [self.DetailLabel.text sizeWithFont:self.DetailLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.DetailLabel.frame = CGRectMake(WIDTH * 64/375, 60*WIDTH/375, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+70*WIDTH/375;
    
    self.frame = frame;
}


@end
