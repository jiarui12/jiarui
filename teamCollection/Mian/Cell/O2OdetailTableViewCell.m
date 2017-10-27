//
//  O2OdetailTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/4/7.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "O2OdetailTableViewCell.h"

@implementation O2OdetailTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"detail";
    // 1.缓存中取
    O2OdetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[O2OdetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-50, 10, 20, 20);
        [button setBackgroundImage:[UIImage imageNamed:@"kp_detail_download_normal"] forState:UIControlStateNormal];
//        [self.contentView addSubview:button];
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 40)];
        [self.contentView addSubview:_TitleLabel];
        
        
    }
    return self;


}
@end
