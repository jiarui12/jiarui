//
//  CommentListTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/8/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "CommentListTableViewCell.h"

@implementation CommentListTableViewCell

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
    
    static NSString *identifier = @"newCompany";
    // 1.缓存中取
    CommentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CommentListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
    
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(12, 7, 30, 30)];
        _headImage.layer.cornerRadius=_headImage.frame.size.width/2;
        _headImage.clipsToBounds=YES;
        
        [self.contentView addSubview:_headImage];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(48, 0, self.contentView.frame.size.width-45  , 42.5)];
        
        
        _nameLabel.textColor=[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
        _nameLabel.font=[UIFont systemFontOfSize:14.5];
        [self.contentView addSubview:_nameLabel];
        
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-80, 10, 70, 20)];
        
        _timeLabel.font=[UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_timeLabel];
        
        
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(48, 10, self.contentView.frame.size.width, 20)];
        
        [self.contentView addSubview:_contentLabel];
        
    }
    return self;
}
@end
