//
//  newheadViewTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/8/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "newheadViewTableViewCell.h"

@implementation newheadViewTableViewCell

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
    newheadViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newheadViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
    
}


/*
 
 
 
 **/
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-90, 5, 50, 50)];
        _headImage.layer.cornerRadius=_headImage.frame.size.width/2;
        _headImage.clipsToBounds=YES;
        
        [self.contentView addSubview:_headImage];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.contentView.frame.size.width-45  , 60)];
        _nameLabel.text=@"头像";
        _nameLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
//        _nameLabel.font=[UIFont systemFontOfSize:14.5];
        [self.contentView addSubview:_nameLabel];
        if ([UIScreen mainScreen].bounds.size.width<350) {
             _nameLabel.font=[UIFont systemFontOfSize:14];
        }
        
                
    }
    return self;
}

@end
