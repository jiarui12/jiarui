//
//  commentTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/3/17.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "commentTableViewCell.h"

@implementation commentTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"comment";
    // 1.缓存中取
    commentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[commentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;


}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width, 20)];
        _commentLabel.font=[UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_commentLabel];
        UIView * backgroundView=[[UIView alloc]initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width-20, 40)];
        backgroundView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        _titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 40)];
        [backgroundView addSubview:_titleImage];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 280, 40)];
        [backgroundView addSubview:_titleLabel];
        
        [self.contentView addSubview:backgroundView];
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, [UIScreen mainScreen].bounds.size.width-20, 10)];
        
        _timeLabel.textColor=[UIColor grayColor];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
    }
    return self;
}
@end
