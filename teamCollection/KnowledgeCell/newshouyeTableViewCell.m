//
//  newshouyeTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/2.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "newshouyeTableViewCell.h"

@implementation newshouyeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{


    static NSString *identifier = @"shouye";
    // 1.缓存中取
    newshouyeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newshouyeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
    
    
}


@end
