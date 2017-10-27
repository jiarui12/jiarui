//
//  JRMuneTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/4/27.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "JRMuneTableViewCell.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation JRMuneTableViewCell

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
    static NSString *identifier = @"mune";
    // 1.缓存中取
    JRMuneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[JRMuneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      
        _label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, 0,WIDTH*97/375, 50)];
        _label.font = [UIFont systemFontOfSize:WIDTH* 15/375];
        _label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _label.textAlignment = NSTextAlignmentLeft;
        
        
        [self.contentView addSubview:_label];
        
    }
    return self;
    
    
}

@end
