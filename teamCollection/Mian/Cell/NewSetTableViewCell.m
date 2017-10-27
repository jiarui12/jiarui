//
//  NewSetTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/7/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "NewSetTableViewCell.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
@implementation NewSetTableViewCell

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
   
    static NSString *identifier = @"localValue";
    // 1.缓存中取
    NewSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewSetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
    
}


/*
 

 
 **/
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH* 13.5/375, WIDTH*15/375,WIDTH*16/375, WIDTH*16/375)];
        
        
        [self.contentView addSubview:_headImage];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 40/375, 0,WIDTH- 50, WIDTH*45/375)];
        
        _nameLabel.font=[UIFont systemFontOfSize:WIDTH *16/375];
        _nameLabel.textColor=[UIColor blackColor];
        
        [self.contentView addSubview:_nameLabel];
        
        
        
        
    }
    return self;
}

@end
