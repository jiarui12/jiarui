//
//  refreshTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/7/8.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "refreshTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation refreshTableViewCell

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
    static NSString *identifier = @"re";
    // 1.缓存中取
    refreshTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[refreshTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 23, [UIScreen mainScreen].bounds.size.width, 12)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"刚刚更新，点击刷新";
        label.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        label.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
    }
    return self;
    
    
}


@end
