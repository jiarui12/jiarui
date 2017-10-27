//
//  DynamicTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/4/11.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "DynamicTableViewCell.h"

@implementation DynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"Dy";
    // 1.缓存中取
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[DynamicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;

}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        
        [self.contentView addSubview:_TitleLabel];
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 0, 200, 40)];
        
        
        [self.contentView addSubview:_DetailLabel];
        
    }
    return self;
    
    
}
@end
