//
//  myLocalValueTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/3/21.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "myLocalValueTableViewCell.h"

@implementation myLocalValueTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{

    static NSString *identifier = @"localValue";
    // 1.缓存中取
    myLocalValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[myLocalValueTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;


}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 60)];
        [self.contentView addSubview:_headImage];
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 10, 80, 20)];
        _titleLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 35, 50, 10)];
        _categaryLabel.font=[UIFont systemFontOfSize:12];
        _categaryLabel.textColor=[UIColor grayColor];
        [self.contentView addSubview:_categaryLabel];
        
        _stateLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, 10, 50, 20)];
        _stateLabel.textColor=[UIColor greenColor];
        _stateLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_stateLabel];
        
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
