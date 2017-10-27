//
//  newStudyCalendarTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/6/13.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "newStudyCalendarTableViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation newStudyCalendarTableViewCell

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
    newStudyCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newStudyCalendarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(83*WIDTH/375, 10, 258*WIDTH/375, 22.5*WIDTH/375)];
        [self.contentView addSubview:_titleLabel];
        
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 41/375, 10 *WIDTH/375,WIDTH * 36/375, WIDTH * 16/375)];
        
        
        
        
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
        
        
        
        
        
        
        
    }
return self;
    
    
}



@end
