//
//  ContancTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/1/27.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "ContancTableViewCell.h"

@implementation ContancTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"contanc";
    // 1.缓存中取
    ContancTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[ContancTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 4, 40, 40)];
    
        self.headImageView.layer.cornerRadius=self.headImageView.frame.size.width/2;
        self.headImageView.clipsToBounds=YES;
        [self.contentView addSubview:self.headImageView];
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 4, 100, 20)];
        [self.contentView addSubview:_nameLabel];
        _infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 24, 200, 20)];
        [self.contentView addSubview:_infoLabel];
        
        
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
