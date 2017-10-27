//
//  integralLevelTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/4/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "integralLevelTableViewCell.h"

@implementation integralLevelTableViewCell

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
    integralLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[integralLevelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
    
}


/*
 
 @property(nonatomic,strong)UILabel * levelNum;
 @property(nonatomic,strong)UIImageView * levelIcon;
 @property(nonatomic,strong)UILabel * levelName;
 @property(nonatomic,strong)UILabel * integralNum;
 
 **/
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        _levelNum=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width/4, 30)];
        _levelNum.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_levelNum];
        _levelIcon=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/4+50, 10, 20, 10)];
        [self.contentView addSubview:_levelIcon];
        _levelName=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2+35, 0, self.contentView.frame.size.width/4, 30)];
        _levelName.textAlignment=NSTextAlignmentCenter;
         _levelName.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_levelName];
        _integralNum=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/4*3+50, 0, self.contentView.frame.size.width/4, 40)];
        _integralNum.textAlignment=NSTextAlignmentCenter;
        _integralNum.font=[UIFont systemFontOfSize:14];
        _integralNum.numberOfLines=0;
        [self.contentView addSubview:_integralNum];
        
    }
    return self;
}
@end
