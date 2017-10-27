//
//  MyDetail1TableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/1/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "MyDetail1TableViewCell.h"

@implementation MyDetail1TableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"status";
    // 1.缓存中取
    MyDetail1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[MyDetail1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;


}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        int i=70;
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, i, i)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.clipsToBounds=YES;
        _headImageView.image=[UIImage imageNamed:@"man_default_icon"];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 200, 30)];
        [self.contentView addSubview:_nameLabel];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(90, 50, 40, 20)];
        label.text=@"总积分:";
        label.backgroundColor=[UIColor redColor];
        label.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        _scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 40, 60, 30)];
        _scoreLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_scoreLabel];
        _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 50, 40, 20)];
        [self.contentView addSubview:_rankLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
