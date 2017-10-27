//
//  notifyMessageTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/24.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "notifyMessageTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation notifyMessageTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"notifyMessage";
    // 1.缓存中取
    notifyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[notifyMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
   
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /*   添加圆形头像    */
//        int i=70;
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH* 10/375,WIDTH* 9/375,WIDTH*50/375, WIDTH*50/375)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.clipsToBounds=YES;
        _headImageView.image=[UIImage imageNamed:@"man_default_icon"];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*70/375, WIDTH*10/375,WIDTH *250/375, 30)];
        _nameLabel.font=[UIFont systemFontOfSize:WIDTH*17/375];
        _nameLabel.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        [self.contentView addSubview:_nameLabel];
    
        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*70/375,WIDTH *40/375,WIDTH* 250/375, 20)];
        _detailLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        _detailLabel.font=[UIFont systemFontOfSize:WIDTH*14/375];
        [self.contentView addSubview:_detailLabel];
        
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH *695/750, WIDTH*86/750,WIDTH* 16/375,WIDTH * 16/375)];
        _numberLabel.font = [UIFont boldSystemFontOfSize:10];  //UILabel的字体大小
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
        [_numberLabel setBackgroundColor:[UIColor redColor]];
        _numberLabel.layer.cornerRadius=WIDTH* 16/375/2;
        _numberLabel.clipsToBounds=YES;
        NSString *str = @"99";
        _numberLabel.backgroundColor=[UIColor redColor];
        _numberLabel.textColor=[UIColor whiteColor];
        CGSize size = [str sizeWithFont:_numberLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
//        [_numberLabel setFrame:CGRectMake(self.contentView.frame.size.width/8, 10, size.width, 10)];
        _numberLabel.text = str;
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        _numberLabel.userInteractionEnabled=YES;
        [self.contentView addSubview:_numberLabel];
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*70/375, WIDTH*18.5/375, WIDTH*585/750, 15)];
        _timeLabel.font=[UIFont systemFontOfSize:WIDTH* 12/375];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        [self.contentView addSubview:_timeLabel];
        
        
  
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
