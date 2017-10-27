//
//  collectionKnowledgeTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/2/26.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "collectionKnowledgeTableViewCell.h"

@implementation collectionKnowledgeTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"collection";
    // 1.缓存中取
    collectionKnowledgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[collectionKnowledgeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mainImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 90)];
        [self.contentView addSubview:_mainImage];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, [UIScreen mainScreen].bounds.size.width-110, 20)];
        [self.contentView addSubview:_titleLabel];
        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, [UIScreen mainScreen].bounds.size.width-110, 10)];
        _detailLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_detailLabel];
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 80, 80, 10)];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.textColor=[UIColor grayColor];
        [self.contentView addSubview:_timeLabel];
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 80, 80, 10)];
        _categaryLabel.font=[UIFont systemFontOfSize:12];
        _categaryLabel.textColor=[UIColor grayColor];
        
        [self.contentView addSubview:_categaryLabel];
        
        
        
        
    }
    return self;

}
@end
