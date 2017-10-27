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
        
                    /*   添加圆形头像    */
        int i=70;
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, i, i)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.clipsToBounds=YES;
        _headImageView.image=[UIImage imageNamed:@"man_default_icon"];
        [self.contentView addSubview:_headImageView];
        /*   名字label   */
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 200, 30)];
        [self.contentView addSubview:_nameLabel];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(90, 55, 40, 15)];
        label.text=@"总积分:";
        label.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        
              /* 积分label */
        _scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 45, 70, 30)];
        _scoreLabel.font=[UIFont systemFontOfSize:20];
        [_scoreLabel setTextColor:[UIColor colorWithRed:26/255.0 green:155/255.0 blue:252/255.0 alpha:1.0]];
        _scoreLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_scoreLabel];
        
        
              /* 排名label */
        _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 50, 35, 20)];
        [_rankLabel setTextColor:[UIColor colorWithRed:252/255.0 green:102/255.0 blue:33/255.0 alpha:1.0]];
        _rankLabel.font=[UIFont systemFontOfSize:20];
        _rankLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_rankLabel];
        UILabel * scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 55, 40, 15)];
        scoreLabel.font=[UIFont systemFontOfSize:12];
        scoreLabel.text=@"分";
        [self.contentView addSubview:scoreLabel];
        UILabel * ranklabel=[[UILabel alloc]initWithFrame:CGRectMake(235 , 55, 15, 15)];
        ranklabel.textAlignment=NSTextAlignmentRight;
        ranklabel.text=@"第";
        ranklabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:ranklabel];
        UILabel * rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(280, 55, 15, 15)];
        rankLabel.font=[UIFont systemFontOfSize:12];
        rankLabel.textAlignment=NSTextAlignmentRight;
        rankLabel.text=@"名";
        [self.contentView addSubview:rankLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
