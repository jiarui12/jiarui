//
//  followTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/2/25.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "followTableViewCell.h"

@implementation followTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"follow";
    // 1.缓存中取
   followTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[followTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 80)];
        [self.contentView addSubview:_mainImageView];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110,10 , [UIScreen mainScreen].bounds.size.width-110, 20)];
      
        
        [self.contentView addSubview:_titleLabel];
        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, [UIScreen mainScreen].bounds.size.width-110, 40)];
        _detailLabel.font=[UIFont systemFontOfSize:13];
        _detailLabel.numberOfLines=2;
        
        [self.contentView addSubview:_detailLabel];
        _fromLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 10)];
        _fromLabel.font=[UIFont systemFontOfSize:12];
        _fromLabel.textColor=[UIColor grayColor];
        [self.contentView addSubview:_fromLabel];
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 100, 80, 10)];
        _timeLabel.textColor=[UIColor grayColor];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_timeLabel];
        
    }
    return self;
}

@end
