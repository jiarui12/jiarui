//
//  oneThingTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/3/7.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "oneThingTableViewCell.h"

@implementation oneThingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"one";
    // 1.缓存中取
    oneThingTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[oneThingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * grayView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 10)];
        grayView.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self.contentView addSubview:grayView];
        UIImageView * headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        headView.image=[UIImage imageNamed:@"honor_item_notice"];
        [self.contentView addSubview:headView];
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 1)];
        view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
        [self.contentView addSubview:view];
        UILabel * CloudbagLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 7, 200, 40)];
        CloudbagLabel.text=@"一事一控";
        [self.contentView addSubview:CloudbagLabel];
        UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(0, 160, [UIScreen mainScreen].bounds.size.width, 1)];
        view1.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
        [self.contentView addSubview:view1];
        UIImageView * More=[[UIImageView alloc]initWithFrame:CGRectMake(10, 165, 30, 30)];
        More.image=[UIImage imageNamed:@"honor_more_notice_icon"];
        [self.contentView addSubview:More];
        UILabel* label=[[UILabel  alloc]initWithFrame:CGRectMake(50, 160, 200, 40)];
        label.text=@"再换一批";
        label.textColor=[UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
        [self.contentView addSubview:label];
        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(0, 160, self.contentView.frame.size.width, 40) ;
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(MoreClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        
    }
    return self;
}
-(void)MoreClick:(UIButton *)button{
    
}
@end
