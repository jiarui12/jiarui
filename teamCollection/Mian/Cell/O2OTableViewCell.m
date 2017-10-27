//
//  O2OTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/4/7.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "O2OTableViewCell.h"

@implementation O2OTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"message";
    // 1.缓存中取
    O2OTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[O2OTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10,80, 60)];
        
        [self.contentView addSubview:_headImage];
        
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 20)];
        [self.contentView addSubview:_TitleLabel];
        
        UIImageView * look=[[UIImageView alloc]initWithFrame:CGRectMake(100, 45, 20, 20)];
        look.image=[UIImage imageNamed:@"kp_count_read"];
        [self.contentView addSubview:look];
        
        UIImageView * conment=[[UIImageView alloc]initWithFrame:CGRectMake(150, 45, 20, 20)];
        conment.image=[UIImage imageNamed:@"kp_count_review"];
        [self.contentView addSubview:conment];
        
        UIImageView * time=[[UIImageView alloc]initWithFrame:CGRectMake(200, 45, 20, 20)];
        time.image=[UIImage imageNamed:@"kp_time_publish_time"];
        [self.contentView addSubview:time];
        _focusLabel =[[UILabel alloc]initWithFrame:CGRectMake(170, 45, 30, 20)];
        [self.contentView addSubview:_focusLabel];
        _viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 45, 30, 20)];
        [self.contentView addSubview:_viewLabel];
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 45, 200, 20)];
        [self.contentView addSubview:_timeLabel];
        
        
    }
    return self;
 
}
@end
