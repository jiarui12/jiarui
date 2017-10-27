//
//  newOtherTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/8/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "newOtherTableViewCell.h"

@implementation newOtherTableViewCell

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
    
    static NSString *identifier = @"newhead";
    // 1.缓存中取
    newOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newOtherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
    
}


/*
 
 
 
 **/
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    _headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 50)];
       _headLabel.text=@"贾瑞";
        _headLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _headLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_headLabel];
        
        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.contentView.frame.size.width-45  , 50)];
        _detailLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        _detailLabel.text=@"姓名";
        if ([UIScreen mainScreen].bounds.size.width<350) {
            _detailLabel.font=[UIFont systemFontOfSize:14];
             _headLabel.font=[UIFont systemFontOfSize:14];
        }
//        _detailLabel.font=[UIFont systemFontOfSize:14.5];
        [self.contentView addSubview:_detailLabel];
        
        
        
    }
    return self;
}


@end
