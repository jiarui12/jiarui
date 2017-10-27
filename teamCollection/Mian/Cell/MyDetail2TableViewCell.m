//
//  MyDetail2TableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/5/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MyDetail2TableViewCell.h"

@implementation MyDetail2TableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"my";
    // 1.缓存中取
    MyDetail2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[MyDetail2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /*   添加圆形头像    */
        int i=70;
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, i, i)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.clipsToBounds=YES;
        _headImageView.image=[UIImage imageNamed:@"man_default_icon"];
        [self.contentView addSubview:_headImageView];
        /*   名字label   */
               UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 80,15)];
        label.text=@"请登录";
        label.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:label];
        
       
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
